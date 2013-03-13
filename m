From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 13 Mar 2013 16:34:08 -0400
Subject: [PATCH 14/29] arm64: KVM: guest one-reg interface
In-Reply-To: <51402F52.6020808@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-15-git-send-email-marc.zyngier@arm.com>
 <513F6659.7060500@codeaurora.org> <513F6E86.4040902@arm.com>
 <513FA70B.2040600@codeaurora.org> <51402F52.6020808@arm.com>
Message-ID: <5140E2C0.7010009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/13/2013 03:48 AM, Marc Zyngier wrote:
> On 12/03/13 22:07, Christopher Covington wrote:
> 
> Hi Christopher,
> 
>> On 03/12/2013 02:05 PM, Marc Zyngier wrote:
>>> On 12/03/13 17:31, Christopher Covington wrote:
>>>> Hi Marc,
>>>>
>>>> On 03/04/2013 10:47 PM, Marc Zyngier wrote:
>>>>> Let userspace play with the guest registers.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> ---
>>>>>  arch/arm64/kvm/guest.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 240 insertions(+)
>>>>>  create mode 100644 arch/arm64/kvm/guest.c
>>>>
>>>> [...]
>>>>
>>>>> +int __attribute_const__ kvm_target_cpu(void)
>>>>> +{
>>>>> +	unsigned long implementor = read_cpuid_implementor();
>>>>> +	unsigned long part_number = read_cpuid_part_number();
>>>>> +
>>>>> +	if (implementor != ARM_CPU_IMP_ARM)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	switch (part_number) {
>>>>> +	case ARM_CPU_PART_AEM_V8:
>>>>> +	case ARM_CPU_PART_FOUNDATION:
>>>>> +		/* Treat the models just as an A57 for the time being */
>>>>> +	case ARM_CPU_PART_CORTEX_A57:
>>>>> +		return KVM_ARM_TARGET_CORTEX_A57;
>>>>> +	default:
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +}
>>>>
>>>> What is the motivation behind these checks? Why not let any ARMv8 system that
>>>> has EL2 host a virtualized Cortex A57 guest?
>>>
>>> The main reason is errata management. How do you deal with errata in the
>>> guest when you hide the underlying host CPU? I don't have an answer to
>>> that. So for the time being, we only allow the guest to see the same CPU
>>> as the host, and require that new CPUs are added to this function.
>>
>> Can you please elaborate on how this code ensures the guest is seeing the same
>> CPU as the host? It looks rather unlike VPIDR = MIDR.
> 
> I was merely elaborating on the "why". For the how:
> - vmidr_el2 is set in arch/arm64/kernel/head.S and never changed,
> ensuring the guest sees the same thing as the kernel.
> - Some additional code in guest.c ensures that both the host and the CPU
> requested by userspace for the guest are the same
> - KVM_ARM_TARGET_CORTEX_A57 is used in sys_regs_a57.c to register the
> sys_reg/cp15 handlers.

As I believe your response indicates, the code cited above in this email isn't
ensuring that the host is the same as the guest. That's done elsewhere. The
code here is doing something different, something that seems to me is going to
make building upon the ARM64 KVM infrastructure more of a hassle than it
should be.

My guess at the goal of the code cited above in this email is that it's trying
to sanity check that virtualization will work. Rather than taking a default
deny approach with a hand-maintained white list of virtualization-supporting
machine identifiers, why not check that EL2 is implemented on the current
system and if it's not implied by that, that the timer and interrupt
controller are suitable as well?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
