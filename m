From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 30 Jun 2014 14:54:11 +0100
Subject: [PATCH v6 4/4] ARM: Add KGDB/KDB FIQ debugger generic code
In-Reply-To: <53ABEDC9.6020407@linaro.org>
References: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-5-git-send-email-daniel.thompson@linaro.org>
 <20140624160844.GV32514@n2100.arm.linux.org.uk> <53ABEDC9.6020407@linaro.org>
Message-ID: <53B16C03.7090503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/14 10:54, Daniel Thompson wrote:
>> Also bear in mind that svc_entry calls trace_hardirqs_off - is this
>> appropriate and safe for the FIQ to call?
> 
> I personally think it appropriate and it looked safe on the lockdep side
> of things. However I will look a bit deeper at this since I don't
> remember how far I chased things back.

I've reviewed as far as I can.

Regarding safety I can't find anything much to upset the FIQ handler. I
think it might occasionally trigger the trace code's recursion avoidance
causing the trace event to be dropped but that's about it.

I admit I came very close to removing the trace_hardirqs calls from the
FIQ code but in the end I've left it. The hardirqs *are* off during FIQ
execution.


>>> +	msr	cpsr_c, #FIQ_MODE | PSR_I_BIT | PSR_F_BIT
>>
>> Here we switch to FIQ mode.  What about the PSR_A_BIT which prevents
>> imprecise aborts on ARMv6+ ?
>>
>> Nevertheless, I think it's safe because the A bit will be set by the
>> CPU when taking the FIQ exception, and it should remain set since
>> cpsr_c won't modify it.
> 
> Agreed.
> 
> Note that while double checking this I realized that this code will drop
> the value of PSR_ISETSTATE (T bit) that the vector_stub macro set for
> us. I'll fix this.

I was wrong about this. CPSR T bit is part of execution state can cannot
be modified by msr.


> I've picked out the following actions from the above:
> 
> 1. Wrap a save and restore lr_abt and spsr_abt around the FIQ handler

Done.

> 2. Add a paired up trace_hardirqs_on() (and review more deeply).

Done.

> 3. Add comments explaining hazards w.r.t. data abort,

Done.

> 4. Correctly manage T bit during transition back to FIQ mode.

Not applicable.

> Do I miss anything?

I hope not!


Daniel.
