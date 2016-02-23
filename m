From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Feb 2016 08:33:13 +0000
Subject: [PATCH v12 03/21] KVM: ARM64: Add offset defines for PMU registers
In-Reply-To: <56CBBA06.4040902@huawei.com>
References: <1456133877-9584-1-git-send-email-zhaoshenglong@huawei.com>
 <1456133877-9584-4-git-send-email-zhaoshenglong@huawei.com>
 <56CB4A98.2020403@arm.com> <56CBBA06.4040902@huawei.com>
Message-ID: <56CC1949.2020907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/16 01:46, Shannon Zhao wrote:
> 
> 
> On 2016/2/23 1:51, Marc Zyngier wrote:
>> On 22/02/16 09:37, Shannon Zhao wrote:
>>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>>
>>> We are about to trap and emulate accesses to each PMU register
>>> individually. This adds the context offsets for the AArch64 PMU
>>> registers.
>>>
>>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 6f0241f..6bab7fb 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -115,6 +115,21 @@ enum vcpu_sysreg {
>>>  	MDSCR_EL1,	/* Monitor Debug System Control Register */
>>>  	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
>>>  
>>> +	/* Performance Monitors Registers */
>>> +	PMCR_EL0,	/* Control Register */
>>> +	PMOVSSET_EL0,	/* Overflow Flag Status Set Register */
>>> +	PMSELR_EL0,	/* Event Counter Selection Register */
>>> +	PMEVCNTR0_EL0,	/* Event Counter Register (0-30) */
>>> +	PMEVCNTR30_EL0 = PMEVCNTR0_EL0 + 30,
>>> +	PMCCNTR_EL0,	/* Cycle Counter Register */
>>> +	PMEVTYPER0_EL0,	/* Event Type Register (0-30) */
>>> +	PMEVTYPER30_EL0 = PMEVTYPER0_EL0 + 30,
>>> +	PMCCFILTR_EL0,	/* Cycle Count Filter Register */
>>> +	PMCNTENSET_EL0,	/* Count Enable Set Register */
>>> +	PMINTENSET_EL1,	/* Interrupt Enable Set Register */
>>> +	PMUSERENR_EL0,	/* User Enable Register */
>>> +	PMSWINC_EL0,	/* Software Increment Register */
>>> +
>>
>> I've just noticed a rather fundamental issue with this: this makes it
>> impossible to bisect the whole series.
>>
> Ah, sorry. Will fix this.

Thanks.

> 
>> I was trying to pinpoint a performance regression with this series, and
>> started bisecting.
> You mean this series introduce a performance regression? Is there any
> method to measure that? Then I can have a look too.

I'm not quite sure this is related to this series. What I'm observing is
that hackbench runs faster in a VM spawned with kvmtool than the same VM
run with qemu. As in significantly faster (62 vs 55 seconds - 2 vcpus,
1GB memory).

Given that hackbench doesn't do any IO, I don't really see why we should
see a difference. I'll add support for the PMU to kvmtool today, and
I'll be able to see if that has any impact.

	M.
-- 
Jazz is not dead. It just smells funny...
