From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 09 Sep 2011 09:47:39 +0100
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <alpine.LFD.2.02.1109081855590.2723@ionos>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
	<20110815121312.GF26827@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1109081339120.2723@ionos>
	<4E68E961.8050309@arm.com>
	<alpine.LFD.2.02.1109081855590.2723@ionos>
Message-ID: <4E69D2AB.5030303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 08/09/11 19:05, Thomas Gleixner wrote:
> Marc,
> 
> On Thu, 8 Sep 2011, Marc Zyngier wrote:
>> Thomas,
>>
>> On 08/09/11 14:14, Thomas Gleixner wrote:
>>
>>> Another thing, which sticks out compared to other percpu interrupt
>>> users in arch/* is that you provide the ability to assign different
>>> handlers on different CPUs to a given PPI interrupt number. Most other
>>> percpu implementations setup the interrupt with a unique percpu aware
>>> handler and just enable/disable it per core in the low level
>>> setup/shutdown code. Is running different handlers on different cores
>>> a real requirement or just a nice feature with no usecase?
>>
>> At the moment, it sort of falls into the second category. MSM has
>> "asymmetric" timers (each core has its private timer on a different
>> PPI), but that doesn't mandate having separate handlers per core, unless
>> someone decides to connect something on another CPU, using the same
>> PPI... The architecture would probably allow it.
> 
> The question is whether we really want to allow it from the OS
> side. That makes irq accounting an utter mess as you end up with
> devA,B,C,D on the same interrupt line and each counts on the
> corresponding CPU0,1,2,3
> 
>> But a clear requirement we have is that the handler has to be called
>> with a per-cpu dev_id pointer (we use this to obtain the
>> clock_event_device in the timer handler, for example). Which makes
>> having something similar to request_irq() quite the natural thing.
> 
> That makes a lot of sense, but it requires your extra percpu handler
> registration/free interface ....
> 
> Looking at the other PERCPU irq users there might be a general
> interest for this.
> 
> If we can apply the following set of (sane) restricitions to this:
> 
>    - interrupt is never shared
>    - interrupt is never threaded
>    - handler is common for all CPUs
> 
> then we could do something like the patch below. Warning, this is
> incomplete and requires a bunch of other changes like adding per cpu
> aware enable/disable functions and excluding the other interfaces from
> fiddling with such an interrupt.
> 
> So a request/setup_irq() of such an interrupt would require the
> following steps.
> 
>   irq_set_percpu_devid(irq);
> 
>     This would set: IRQ_NOAUTOEN | IRQ_PER_CPU | IRQ_NOPROBE | IRQ_PER_CPU_DEVID
>     and 
> 
>   irq_set_handler(irq, handle_irq_per_cpu_devid);
> 
>   setup/request_percpu_irq(irq, .....);
> 
>     The dev_id pointer for those interrupts would be a percpu pointer
>     which holds the real dev_ids, e.g. the percpu clockevents
> 
> Due to the restricted nature of those interrupts we probably can
> ignore nested disable/enable_percpu_irq() calls and just keep the
> *_percpu_irq API to a bare minimum.
> 
> Thoughts ?

I quite like it. Specially if it can be useful to other architectures.
Let me glue all that together to get a feel of how it would work, and
I'll get back to you.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
