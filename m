From: james.morse@arm.com (James Morse)
Date: Tue, 18 Sep 2018 18:46:25 +0100
Subject: [PATCH v5 02/27] arm64: cpufeature: Use alternatives for VHE
 cpu_enable
In-Reply-To: <85d74cec-2290-9e89-b155-f0f7c523b4a4@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
 <1d425320-aed3-b949-1ec5-f378248aac4d@arm.com>
 <85d74cec-2290-9e89-b155-f0f7c523b4a4@arm.com>
Message-ID: <afc7dcf8-7a10-ed8b-3dde-62c4710391c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 09/12/2018 01:03 PM, Julien Thierry wrote:
> On 12/09/18 11:28, James Morse wrote:
>> On 28/08/18 16:51, Julien Thierry wrote:
>>> The cpu_enable callback for VHE feature requires all alternatives to have
>>> been applied. This prevents applying VHE alternative separately from the
>>> rest.
>>>
>>> Use an alternative depending on VHE feature to know whether VHE
>>> alternatives have already been applied.

>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 1e433ac..3bc1c8b 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -1022,8 +1024,15 @@ static void cpu_copy_el2regs(const struct 
>>> arm64_cpu_capabilities *__unused)
>>> ?????? * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>>> ?????? * do anything here.
>>> ?????? */
>>> -??? if (!alternatives_applied)
>>> -??????? write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
>>> +??? asm volatile(ALTERNATIVE(
>>> +??????? "mrs??? %0, tpidr_el1\n"
>>> +??????? "msr??? tpidr_el2, %0",
>>> +??????? "nop\n"
>>> +??????? "nop",
>>> +??????? ARM64_HAS_VIRT_HOST_EXTN)
>>> +??????? : "+r" (tmp)
>>> +??????? :
>>> +??????? : "memory");
>>> ? }
>>> ? #endif
>>
>> Catalin's preference was to keep this all in C:
>> https://patchwork.kernel.org/patch/10007977/
>> , for which we need to know if 'the' alternative has been applied.
>>
>> I suspect there may be more registers in this list if we have to switch to
>> another EL2 register using alternatives. (but I don't have an example).
>>
>> Could we make 'alternatives_applied' a macro that takes the cap as an argument?

> I wanted to do this initially, the issue was that the alternatives framework works on 
> regions to patch rather than caps to apply. So I found it a bit odd to associate the 
> "code corresponding to cap was applied" with the alternative application.

I agree it looks funny, but for the kernel text, its can only be one region. If we 
ever had two we would still have to apply them at the same time as its not safe to 
run code with alternatives partially applied.

(modules should be fine too as we apply the same alternatives as the kernel has 
before we run any of the code)


I wonder if we can kill-off this function entirely... its only necessary because 
set_my_cpu_offset() sets the 'wrong' tpidr register, and we need to copy them before 
applying the alternatives.
... we only call set_my_cpu_offset() when we bring a cpu online, we could make it set 
both tpidr registers if we're running at EL2.


Thanks,

James
