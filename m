From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 09 Dec 2014 19:25:06 +0900
Subject: [RESEND][PATCH v15 7/7] ARM: kprobes: enable OPTPROBES
 for ARM 32
In-Reply-To: <1418116450.3641.7.camel@linaro.org>
References: <1418047765-53197-1-git-send-email-wangnan0@huawei.com>
 <1418047765-53197-8-git-send-email-wangnan0@huawei.com>
 <54869B1C.6050401@hitachi.com> <1418116450.3641.7.camel@linaro.org>
Message-ID: <5486CE02.5070808@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/12/09 18:14), Jon Medhurst (Tixy) wrote:
[...]
>>> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
>>> index 3a58db4..a4ec240 100644
>>> --- a/arch/arm/probes/kprobes/core.c
>>> +++ b/arch/arm/probes/kprobes/core.c
>>> @@ -163,19 +163,31 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
>>>   * memory. It is also needed to atomically set the two half-words of a 32-bit
>>>   * Thumb breakpoint.
>>>   */
>>> -int __kprobes __arch_disarm_kprobe(void *p)
>>> -{
>>> -	struct kprobe *kp = p;
>>> -	void *addr = (void *)((uintptr_t)kp->addr & ~1);
>>> -
>>> -	__patch_text(addr, kp->opcode);
>>> +struct patch {
>>> +	void *addr;
>>> +	unsigned int insn;
>>> +};
>>>  
>>> +static int __kprobes_remove_breakpoint(void *data)
>>> +{
>>> +	struct patch *p = data;
>>> +	__patch_text(p->addr, p->insn);
>>>  	return 0;
>>>  }
>>>  
>>> +void __kprobes kprobes_remove_breakpoint(void *addr, unsigned int insn)
>>> +{
>>> +	struct patch p = {
>>> +		.addr = addr,
>>> +		.insn = insn,
>>> +	};
>>> +	stop_machine(__kprobes_remove_breakpoint, &p, cpu_online_mask);
>>> +}
>>
>> Hmm, I think finally we should fix patch_text() in patch.c to forcibly use stop_machine
>> by adding "bool stop" parameter, instead of introducing new another patch_text()
>> implementation, because we'd better avoid two private "patch" data structures.
> 
> That was my first thought too, then I realised that breaks encapsulation
> of the patch_text implementation, because its use of stop_machine is an
> implementation detail and it could be rewritten to not use stop machine.
> (That is sort of on my long term todo list
> https://lkml.org/lkml/2014/9/4/188)

Indeed. OK, now let it goes. :)

> Whereas stop machine is used by kprobes to avoid race conditions with
> the undefined instruction exception handler and something like that
> would be needed even if patch_text didn't use stop_machine.

At this point, it's OK.

However, I'm not convinced completely. Perhaps, it depends on cache-coherent bus
implementation, but there may be some implementations which can allow us to
change one instruction atomically without stop_machine.

I'm actually interested in PREEMPT_RT on arm32, and this stop_machine() is a barrier
to apply kprobes on real-time systems.

Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
