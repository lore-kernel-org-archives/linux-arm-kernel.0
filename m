From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 May 2011 12:31:11 -0700
Subject: [RFC PATCH v2 08/12] ARM: msm: use remapped PPI interrupts for
	local timer
In-Reply-To: <1305800121.27474.39.camel@e102391-lin.cambridge.arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>	
	<1304677997-26947-9-git-send-email-marc.zyngier@arm.com>	
	<4DCC41CB.3050802@codeaurora.org>
	<1305800121.27474.39.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DDC077F.6060901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2011 03:15 AM, Marc Zyngier wrote:
> On Thu, 2011-05-12 at 13:23 -0700, Stephen Boyd wrote:
>> On 5/6/2011 3:33 AM, Marc Zyngier wrote:
>>> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
>>> index 38b95e9..f063860 100644
>>> --- a/arch/arm/mach-msm/timer.c
>>> +++ b/arch/arm/mach-msm/timer.c
>>> @@ -83,18 +85,7 @@ enum {
>>>  
>>>  
>>>  static struct msm_clock msm_clocks[];
>>> -static struct clock_event_device *local_clock_event;
>>> -
>>> -static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
>>> -{
>>> -	struct clock_event_device *evt = dev_id;
>>> -	if (smp_processor_id() != 0)
>>> -		evt = local_clock_event;
>>> -	if (evt->event_handler == NULL)
>>> -		return IRQ_HANDLED;
>> We just lost this important line. This prevents spurious interrupts from
>> crashing the system.
> Is this something you actually see on a real system, or just a guard in
> case something goes horribly wrong?
>

I believe a bootloader left a pending interrupt at some point and thus
when we request the interrupt before registering the clockevent the
interrupt handler will be called and evt->event_handler == NULL. Perhaps
we could register the clockevent before registering the interrupt
handler? I'm not sure that works. Otherwise we need to clear the
interrupt in the GIC or something. Any suggestions?

If it's any consolation, x86 seems to do the same thing presumably for
the same reason.

>>> -	evt->event_handler(evt);
>>> -	return IRQ_HANDLED;
>>> -}
>> I would prefer to keep the whole interrupt function because 1) MSM
>> doesn't have a local_timer_ack() to implement and 2) I want to put code
>> in here to stop the timer so that the timer doesn't wrap and cause
>> another interrupt (yes the patches haven't been sent yet).
> I was thinking of reusing the local_timer_ack() for that, possibly
> passing some useful parameters (evt, cpu...). I'd really like the
> event_handler() call to become common code, and move everything else to
> the local_timer_ack() method (with a possible empty default implemented
> as a weak symbol).
>

Ok. So you're saying there is one interrupt handler that will call down
to the hardware specific handler via local_timer_ack()? That sounds like
one step backwards when you consider we want to compile many machines
into one kernel.

A generic interrupt handler for simple timers where there is nothing to
do besides call the event handler is probably good consolidation. But if
the hardware requires something else, it doesn't seem so bad to write
your own.

What's the use of local_timer_ack() in the scheme of this patch series
again? I was really hoping that function would go away.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
