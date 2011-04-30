From: ccross@google.com (Colin Cross)
Date: Sat, 30 Apr 2011 09:42:47 -0700
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.02.1104301135190.3005@ionos>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-7-git-send-email-will.deacon@arm.com>
	<BANLkTi=rM=r5UdUHPG5XceX=ppnQ44K+oA@mail.gmail.com>
	<alpine.LFD.2.02.1104301135190.3005@ionos>
Message-ID: <BANLkTikw=V2CdbwWsDOVZuoQ+cBw2yZdMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2011 at 2:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 29 Apr 2011, Colin Cross wrote:
>> > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
>> > Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>>
>> After further testing, I'm having a problem with this patch, although
>> I think its more of a core issue than the fault of this patch. ?One of
>> my interrupts is getting stuck with the PENDING flag set, and
>> preventing suspend. ?The flow that triggers this is:
>>
>> level triggered irq
>> ?handle_fasteoi_irq
>> ? handle_irq_event
>> ? ?isr
>> ? ? disable_irq_nosync
>> ? ? schedule_work (because it takes a sleeping i2c transaction to
>> deassert the irq pin)
>
> If you'd use a threaded irq handler the IRQ_ONESHOT mechanism would
> handle that problem for you. It masks the irq line before calling the
> handler and unmask happens after the threaded handler has run.
>
> disable_irq_nosync from an interrupt handler plus scheduling work is
> the historic "threaded" interrupt handler mechanism. It's kinda murky
> nowadays due to the lazy irq disable mechanism.

Yes, and in the specific case that reproduces this problem for me a
threaded handler would be appropriate.  However, there are cases where
disable irq can legitimately be called from an interrupt handler.  One
example I was given is a debounce timer - the interrupt handler
disables the irq and then sets a timer.

>> ? ?irq_eoi
>> same irq
>> ?handle_fasteoi_irq
>> ? mark irq pending
>> ? mask_irq
>> work function
>> ?causes level triggered irq to go low
>> ?enable_irq
>> ? unmask_irq
>> ? check_irq_resend (returns immediately)
>>
>> At this point, the irq is unmasked, but not being asserted, and marked
>> as pending. ?check_irq_resend doesn't clear the pending flag for level
>> triggered interrupts, so the pending flag will stay set until the next
>> time the interrupt occurs.
>
> Yes, that should be cleared unconditionally in check_irq_resend.
>
>> Should handle_fasteoi_irq mask the interrupt before eoi if it was
>> disabled by the interrupt handler? ?Otherwise, every level triggered
>> interrupt that is not deasserted by the interrupt handler will
>> interrupt the cpu twice. ?There is still the case where a driver
>
> No, we should stop doing the disable_irq_nosync from handlers and use
> threaded interrupts instead.

As in the example above, I don't think threaded interrupts cover all
the cases where disable_irq_nosync is used in an interrupt handler,
although 99% of the time they do.  handle_level_irq already has this
optimization - it doesn't unmask the irq line if the handler returns
with the irq disabled.  I think the patch I posted would need to check
for a level triggered interrupt, masking the line on an edge triggered
interrupt could lose the next interrupt.

>> disables the irq, the interrupt goes high, then goes low again before
>> enable_irq is called.
>
> So what you're saying is:
>
> irq ____ ? ? ? ? ? ? ? ? ?_______
> ? ? ? ?|________________| ? ? ? |_____________________
>
> ? ? ? ? ? ?| ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?|
> ? ? ? ? ISR/mask/eoi ? ? ? ? ? ? ? ?enable_irq/unmask
>
> So after the unmask the asserted new interrupt is not delivered?
> That's not a software problem :)

Of course its not delivered, the problem is that it is marked pending,
check_wakeup_irqs returns true and prevents suspend.  Always clearing
the pending flag in check_if_resend fixes suspend after calling
enable_irq, but suspend will still fail if attempted between when the
irq line goes low and enable_irq is called (which could be never if
the driver has been disabled for some reason).
