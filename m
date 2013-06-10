From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 10 Jun 2013 23:37:30 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306100946570.1133-100000@iolanthe.rowland.org>
References: <CACVXFVOrniwAUaJN1dkUZD4HzfV6StajzL3Okw2dNBpkSPRjNA@mail.gmail.com>
 <Pine.LNX.4.44L0.1306100946570.1133-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 10:03 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> [Thomas and Steve, please see the question below.]
>
> On Mon, 10 Jun 2013, Ming Lei wrote:
>
>> On Sun, Jun 9, 2013 at 11:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Sun, 9 Jun 2013, Ming Lei wrote:
>> >
>> >> Hi,
>> >>
>> >> The patchset supports to run giveback of URB in tasklet context, so that
>> >> DMA unmapping/mapping on transfer buffer and compelte() callback can be
>> >> run with interrupt enabled, then time of HCD interrupt handler can be
>> >> saved much. Also this approach may simplify HCD since HCD lock needn't
>> >> be released any more before calling usb_hcd_giveback_urb().
>> >
>> > That's a lot of material.  However, you haven't specifically said
>> > _what_ you want to accomplish.  It sounds like you're trying to
>>
>> All IRQs are disabled(locally) in hard interrupt context, but they are
>> enabled in softirq context, this patchset can decrease the time a lot.
>
> That isn't clear.  It is documented that USB completion handlers are
> called with local interrupts disabled.  An IRQ arriving before the

Is there any good reason to do URB giveback with interrupt disabled?

IMO, disabling IRQs isn't necessary for completing URB since the
complete() of URBs for same endpoint is reentrant.

> tasklet starts up might therefore be serviced during the short interval
> before the tasklet disables local interrupts, but if that happens it

Tasklet doesn't disable local interrupts.

> would mean that the completion handler would be delayed.

Yes, the tasklet schedule delay is introduced to URB completion, but
the delay doesn't have much side effect about completing URB.

For async transfer, generally, it should have no effect since there should
have URBs queued on the qh queue before submitting URB.

For periodic transfer, the patch uses high priority tasklet to schedule it.

>
> In effect, you are prioritizing other IRQs higher than USB completion
> handlers.

Both other IRQs and HCD's IRQ are prioritizing the URB completion.

> Nevertheless, the total time spent with interrupts disabled
> will remain the same.

No, the total time spent with interrupts disabled does not remain same,
since no local IRQs are disabled during URB giveback anymore.

>
> (There's one other side effect that perhaps you haven't considered.
> When multiple URBs are addressed to the same endpoint, their completion
> handlers are called in order of URB completion, which is the same as
> the order of URB submission unless an URB is cancelled.  By delegating
> the completion handlers to tasklets, and particularly by using per-CPU
> tasklets, you may violate this behavior.)

Even though URB giveback is handled by hard interrupt handler, it still can't
guarantee that 100%,  please see below:

- interrupt for URB A comes in CPU 0, and handled, then HCD private
lock is released, and usb_hcd_giveback_urb() is called to complete URB A

- interrupt for URB B comes in CPU 1 just before CPU0 releases HCD private
lock, so CPU1 holds the private lock when CPU 0 releases the lock and
handles the HCD interrupt.

So now just like two CPUs are racing, if CPU0 wins, URB A is completed
first, otherwise URB B is completed first.

With introducing completing URB in percpu tasklet, the situation is
just very similar.

On ehci hcd, it can make sure that by always letting CPU0 complete all URBs
(use ehci->scanning/ehci->need_rescan flag), but the patch can change percpu
tasklet to tasklet to meet the demand.

>
>> > minimize the amount of time spent in hardirq context, but I can't be
>> > sure that is really what you want.
>> >
>> > If it is, this is not a good way to do it.  A better way to minimize
>> > the time spent in hardirq context is to use a threaded interrupt
>> > handler.  But why do you want to minimize this time in the first place?
>>
>> Process context switch may have more cost than switching to softirq,
>> then USB performance may be effected, that is why I choose to use
>> tasklet.  Also now there is no any sleep in URB giveback, so it isn't
>> necessary to introduce process to handle the giveback or completion.
>
> Thomas and Steve, can you comment on this?  I do not have a good
> understanding of the relative benefits/drawbacks of tasklets vs.
> threaded interrupt handlers.
>
>> > The CPU will be still have to use at least as much time as before; the
>> > only difference is that it will be in softirq or in a high-priority
>> > thread instead of in hardirq.
>>
>> Yes, as I said above, but we can allow other IRQs to be served in
>> handling URB giveback in softirq context, that is the value of softirq/tasklet.
>> Of course, system may have more important things to do during the time.
>> Generally speaking, for one driver, hard interrupt handler should always
>> consume less time as possible.
>
> As I understand it, the tradeoff between hardirq and softirq is
> generally unimportant.  It does matter a lot in realtime settings --

I don't think so, and obviously softirq allows IRQs to be served quickly,
otherwise why is softirq and tasklet introduced? and why so many drivers
are using tasklet/softirq?

> but the RT kernel effectively makes _every_ interrupt handler threaded,
> so it won't benefit from this change.

We still need mainline kernel to benefit the change, :-)

Thanks,
--
Ming Lei
