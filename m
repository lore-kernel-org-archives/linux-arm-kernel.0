From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Mar 2013 07:48:34 +0000
Subject: [PATCH 14/29] arm64: KVM: guest one-reg interface
In-Reply-To: <513FA70B.2040600@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-15-git-send-email-marc.zyngier@arm.com>
 <513F6659.7060500@codeaurora.org> <513F6E86.4040902@arm.com>
 <513FA70B.2040600@codeaurora.org>
Message-ID: <51402F52.6020808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/13 22:07, Christopher Covington wrote:

Hi Christopher,

> On 03/12/2013 02:05 PM, Marc Zyngier wrote:
>> On 12/03/13 17:31, Christopher Covington wrote:
>>> Hi Marc,
>>>
>>> On 03/04/2013 10:47 PM, Marc Zyngier wrote:
>>>> Let userspace play with the guest registers.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm64/kvm/guest.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 240 insertions(+)
>>>>  create mode 100644 arch/arm64/kvm/guest.c
>>>
>>> [...]
>>>
>>>> +int __attribute_const__ kvm_target_cpu(void)
>>>> +{
>>>> +	unsigned long implementor = read_cpuid_implementor();
>>>> +	unsigned long part_number = read_cpuid_part_number();
>>>> +
>>>> +	if (implementor != ARM_CPU_IMP_ARM)
>>>> +		return -EINVAL;
>>>> +
>>>> +	switch (part_number) {
>>>> +	case ARM_CPU_PART_AEM_V8:
>>>> +	case ARM_CPU_PART_FOUNDATION:
>>>> +		/* Treat the models just as an A57 for the time being */
>>>> +	case ARM_CPU_PART_CORTEX_A57:
>>>> +		return KVM_ARM_TARGET_CORTEX_A57;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>
>>> What is the motivation behind these checks? Why not let any ARMv8 system that
>>> has EL2 host a virtualized Cortex A57 guest?
>>
>> The main reason is errata management. How do you deal with errata in the
>> guest when you hide the underlying host CPU? I don't have an answer to
>> that. So for the time being, we only allow the guest to see the same CPU
>> as the host, and require that new CPUs are added to this function.
> 
> Can you please elaborate on how this code ensures the guest is seeing the same
> CPU as the host? It looks rather unlike VPIDR = MIDR.

I was merely elaborating on the "why". For the how:
- vmidr_el2 is set in arch/arm64/kernel/head.S and never changed,
ensuring the guest sees the same thing as the kernel.
- Some additional code in guest.c ensures that both the host and the CPU
requested by userspace for the guest are the same
- KVM_ARM_TARGET_CORTEX_A57 is used in sys_regs_a57.c to register the
sys_reg/cp15 handlers.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
