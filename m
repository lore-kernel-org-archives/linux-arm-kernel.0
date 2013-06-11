From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 13:40:20 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 1:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 10 Jun 2013, Ming Lei wrote:
>
>> > That isn't clear.  It is documented that USB completion handlers are
>> > called with local interrupts disabled.  An IRQ arriving before the
>>
>> Is there any good reason to do URB giveback with interrupt disabled?
>
> That's a good question.  Offhand I can't think of any drivers that rely
> on this -- although there certainly are places where callback routines
> use spin_lock() rather than spin_lock_irq() or spin_lock_irqsave(),
> because they know that interrupts are already disabled.

Complete() may take long time, for example in UVC's driver, URB's
complete() may take more than 3 ms, as reported in below link:

      http://marc.info/?t=136438111600010&r=1&w=2

Also complete() is provided by interface driver, and it does many driver
specific works, so it isn't good to disable interrupt only for one driver.

If complete() callback runs in one tasklet context, spin_lock() inside
complete() is enough, just like hard irq, the tasklet itself is disabled
during complete(), if the percpu tasklet is converted to single tasklet.
So no problem when the lock is to protect shared resources between
complete().

When the lock is to protect shared resources between complete() and
non-IRQ context, currently spin_lock_irqsave() is used in non-IRQ
context, which is enough to prevent tasklet from being run on the CPU,
so no problem for this situation too.

When all HCDs support to run URB giveback in tasklet context, we can
change all spin_lock_irq*() to spin_lock() in drivers URB->complete(), and
in other places, the spin_lock_irq*() can be changed to spin_lock_bh().

>
> However, changing a documented API is not something to be done lightly.
> You would have to audit _every_ USB driver to make sure no trouble
> would arise.

OK, I will write patch to request for changing the API if the improvement
on the situation isn't objected.

In fact, at least now, the change on API is only about document change, and
no drivers' change is required, isn't it?  We can describe that URB->complete()
might run in hard irq or softirq context, depends on HCD_BH flag of
hcd->driver->flags.

>
>> IMO, disabling IRQs isn't necessary for completing URB since the
>> complete() of URBs for same endpoint is reentrant.
>
> Whether it is _necessary_ isn't the point.  It is _documented_, and
> therefore it cannot be changed easily.

Same with above.

>
>> > tasklet starts up might therefore be serviced during the short interval
>> > before the tasklet disables local interrupts, but if that happens it
>>
>> Tasklet doesn't disable local interrupts.
>
> It is documented that interrupts will be disabled while the completion
> handler runs.  Therefore the tasklet _must_ disable local interrupts.

Same with above, we can change the document which itself shouldn't
have been the only reason for blocking the change, :-)

>> > would mean that the completion handler would be delayed.
>>
>> Yes, the tasklet schedule delay is introduced to URB completion, but
>> the delay doesn't have much side effect about completing URB.
>
> What about delays that occur because a separate interrupt is serviced
> before the URB's completion handler is called?  With the current code
> that can't happen, but with your scheme it can.

Even with current code, one HCD's interrupt handling still may delay
the handling for another HCD interrupt handling for quite long, that is
the motivation to decrease the interrupt handling time of USB HCD, ;-)
And finally, USB HCDs themselves will benefit from the change, won't they?

Also it shouldn't be a problem since most of interrupt handlers
takes very less time.

>> For async transfer, generally, it should have no effect since there should
>> have URBs queued on the qh queue before submitting URB.
>
> That's not how the Bulk-Only mass-storage protocol works.  There are
> times when the protocol _requires_ bulk packets not to be submitted
> until a particular URB has completed.

Yes, I agree. But mass-storage driver itself is very fragile, it will perform
badly if CPU has a higher load.  And it is better to submit DATA/CSW
transfer in previous transfer's complete(), IMO.

Compared with "usb-storage" task's schedule latency, the tasklet
schedule delay should be lower at most of situations since the tasklet
is scheduled inside irq handler.

>
> Since mass-storage is an important use case for USB, its requirements
> should not be ignored.

That is why I did many tests on mass storage case, and from the results
in commit log of patch 4/4, looks no performance loss is involved with
the change on usb storage.

>
>> > In effect, you are prioritizing other IRQs higher than USB completion
>> > handlers.
>>
>> Both other IRQs and HCD's IRQ are prioritizing the URB completion.
>
> I don't understand that sentence.  "Prioritizing" means "assigning a
> priority to".  IRQs and HCDs don't assign priorities to anything;
> priorities are assigned by human programmers.

Sorry, prioritizing should have been "prioritized".

>> > Nevertheless, the total time spent with interrupts disabled
>> > will remain the same.
>>
>> No, the total time spent with interrupts disabled does not remain same,
>> since no local IRQs are disabled during URB giveback anymore.
>
> That is a bug.  Local IRQs must be disabled during URB giveback.

I guess it is still the document API. If so, please see my above explanation,
and I will request to change it.

>> > (There's one other side effect that perhaps you haven't considered.
>> > When multiple URBs are addressed to the same endpoint, their completion
>> > handlers are called in order of URB completion, which is the same as
>> > the order of URB submission unless an URB is cancelled.  By delegating
>> > the completion handlers to tasklets, and particularly by using per-CPU
>> > tasklets, you may violate this behavior.)
>>
>> Even though URB giveback is handled by hard interrupt handler, it still can't
>> guarantee that 100%,  please see below:
>>
>> - interrupt for URB A comes in CPU 0, and handled, then HCD private
>> lock is released, and usb_hcd_giveback_urb() is called to complete URB A
>>
>> - interrupt for URB B comes in CPU 1 just before CPU0 releases HCD private
>> lock, so CPU1 holds the private lock when CPU 0 releases the lock and
>> handles the HCD interrupt.
>>
>> So now just like two CPUs are racing, if CPU0 wins, URB A is completed
>> first, otherwise URB B is completed first.
>
> Although you didn't say so, I assume you mean that A and B are URBs for
> the same endpoint.  This means they use the same host controller and

Exactly.

> hence they use the same IRQ line.
>
> When an interrupt is handled, it is not possible for a second interrupt
> to arrive on the same IRQ line before the handler for the first
> interrupt returns.  The kernel disables the IRQ line when the first
> interrupt occurs, and keeps it disabled until all the handlers are
> finished.  Therefore the scenario you described cannot occur.

OK, thanks for pointing it out.

So I decided to replace the percpu tasklet with one single tasklet,
which can avoid the problem.

Also the tasklet running in CPU0 can handle the work which should
have been done by the same tasket scheduled in CPU1,  so we can
avoid busy-waitting in CPU1 which may be introduced by tasklet_schedule()
in CPU1.

>> With introducing completing URB in percpu tasklet, the situation is
>> just very similar.
>
> No, it isn't, for the reason given above.

Right, but the single tasklet may avoid the problem.

>
>> On ehci hcd, it can make sure that by always letting CPU0 complete all URBs
>> (use ehci->scanning/ehci->need_rescan flag), but the patch can change percpu
>> tasklet to tasklet to meet the demand.
>
> Or perhaps you could assign each endpoint to a particular tasklet.

That still need changing percpu tasklet to single tasklet, since per-endpoint
tasklet can't be distributed on each CPU.

>> > As I understand it, the tradeoff between hardirq and softirq is
>> > generally unimportant.  It does matter a lot in realtime settings --
>>
>> I don't think so, and obviously softirq allows IRQs to be served quickly,
>> otherwise why is softirq and tasklet introduced? and why so many drivers
>> are using tasklet/softirq?
>
> This is part of what I would like to hear Thomas and Steve comment on.

Me too, :-)

Thanks,
--
Ming Lei
