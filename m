From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 10 Jun 2013 16:12:34 +0800
Subject: [RFC PATCH 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <Pine.LNX.4.44L0.1306091148270.13202-100000@netrider.rowland.org>
References: <1370791112-18464-2-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306091148270.13202-100000@netrider.rowland.org>
Message-ID: <CACVXFVPYUYR=kfX3fk3SS9NskMR5xfS6123-dP4oompDDoT-5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 11:58 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 9 Jun 2013, Ming Lei wrote:
>
>> This patch implements the mechanism of giveback of URB in
>> tasklet context, so that hardware interrupt handling time for
>> usb host controller can be saved much, and HCD interrupt handling
>> can be simplified.
>
> Why do you want to minimize the hardware interrupt handling time?  The
> total interrupt handling time will actually be increased by your
> change; the only advantage is that much of the work will not be in
> hardirq context.

Disabling interrupts too long will cause system to respond slowly, for
example timer interrupt may be handled very lately.  That is why tasklet/
softirq is introduced to split driver's interrupt handler into two parts: the
urgent thing is done quickly in hard irq context with IRQs disabled, and
the remaining is handled in softirq/tasklet part with IRQs enabled.

>
> Also, I suspect that this will make HCD interrupt handling _more_
> complicated, not less.

If HCD's lock wasn't released before calling usb_hcd_giveback_urb(),
HCD interrupt handling would have been a bit simpler.

>
>> Motivations:
>>
>> 1), on some arch(such as ARM), DMA mapping/unmapping is a bit
>> time-consuming, for example: when accessing usb mass storage
>> via EHCI on pandaboard, the common length of transfer buffer is 120KB,
>> the time consumed on DMA unmapping may reach hundreds of microseconds;
>> even on A15 based box, the time is still about scores of microseconds
>
> DMA mapping/unmapping will remain just as time-consuming as before.
> This patch won't change that.

Yes, it is platform dependent, and I have tried to improve it, but not succeed.

But, is there any good reason to do time-consuming DMA mapping/
unmapping with all IRQs disabled to make system response slowly?

>
>> 2), on some arch, reading DMA coherent memoery is very time-consuming,
>> the most common example is usb video class driver[1]
>
> Reading DMA-coherent memory will remain just as time-consuming as
> before.

Same with above.

>
>> 3), driver's complete() callback may do much things which is driver
>> specific, so the time is consumed unnecessarily in hardware irq context.
>
> With this patch, the time is consumed in softirq context.  What is the
> advantage?

IRQs are enabled in softirq context so that system can respond events
which might require to be handled very quickly.

>
>> 4), running driver's complete() callback in hardware irq context causes
>> that host controller driver has to release its lock in interrupt handler,
>> so reacquiring the lock after return may busy wait a while and increase
>> interrupt handling time. More seriously, releasing the HCD lock makes
>> HCD becoming quite complicated to deal with introduced races.
>
> There is no choice; the lock _has_ to be released before giving back
> completed URBs.  Therefore the races are unavoidable, as is the
> busy-wait.

Could you explain it in a bit detail why there is no choice?

IMO, the patchset can make it possible.

>
>> So the patch proposes to run giveback of URB in tasklet context, then
>> time consumed in HCD irq handling doesn't depend on drivers' complete and
>> DMA mapping/unmapping any more, also we can simplify HCD since the HCD
>> lock isn't needed to be released during irq handling.
>
> I'm not convinced.  In particular, I'm not convinced that this is
> better than using a threaded interrupt handler.

Threaded interrupt handler should be OK but with more context switch
cost, so URB giveback may be handled a bit lately and performance
might be affected. Also ISOC transfer for video/audio applicaton should
be handled with as less latency as possible to provide good user
experience, thread handler may be delayed a bit too long to meet the
demand.

Also there is no any sleep in usb_hcd_giveback_urb(), so tasklet
should be better.

>
>> The patch should be reasonable and doable:
>>
>> 1), for drivers, they don't care if the complete() is called in hard irq
>> context or softirq context
>
> True.
>
>> 2), the biggest change is the situation in which usb_submit_urb() is called
>> in complete() callback, so the introduced tasklet schedule delay might be a
>> con, but it shouldn't be a big deal:
>>
>>       - control/bulk asynchronous transfer isn't sensitive to schedule
>>         delay
>
> Mass-storage device access (which uses bulk async transfers) certainly
> _is_ sensitive to scheduling delays.
>
>>       - the patch schedules giveback of periodic URBs using
>>         tasklet_hi_schedule, so the introduced delay should be very
>>         small
>>
>>       - use percpu tasklset for each HCD to schedule giveback of URB,
>>         which are running as much as parallel
>
> That might be an advantage; it depends on the work load.  But if the
> tasklet ends up running on a different CPU from the task that submitted
> the URB originally, it would be less of an advantage.
>
>>       - for ISOC transfer, generally, drivers submit several URBs
>>         concurrently to avoid interrupt delay, so it is OK with the
>>         little schedule delay.
>
> This varies.  Some drivers use very low overheads for isochronous
> transfers.  A delay of even one millisecond might be too long for them.
>
>>       - for interrupt transfer, generally, drivers only submit one URB
>>         at the same time, but interrupt transfer is often used in event
>>         report, polling, ... situations, and a little delay should be OK.
>
> Agreed.
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
--
Ming Lei
