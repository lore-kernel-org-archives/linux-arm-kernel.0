From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 21 Oct 2015 14:48:13 +0800
Subject: [PATCH v3 10/20] KVM: ARM64: Add reset and access handlers for
 PMCCNTR register
In-Reply-To: <5621127B.8070704@redhat.com>
References: <1443133885-3366-1-git-send-email-shannon.zhao@linaro.org>
 <1443133885-3366-11-git-send-email-shannon.zhao@linaro.org>
 <5621127B.8070704@redhat.com>
Message-ID: <5627352D.7010607@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/10/16 23:06, Wei Huang wrote:
> 
> 
> On 09/24/2015 05:31 PM, Shannon Zhao wrote:
>> Since the reset value of PMCCNTR is UNKNOWN, use reset_unknown for its
>> reset handler. Add a new case to emulate reading to PMCCNTR register.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index e7f6058..c38c2de 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -518,6 +518,12 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
>>  		}
>>  	} else {
>>  		switch (r->reg) {
>> +		case PMCCNTR_EL0: {
>> +			val = kvm_pmu_get_counter_value(vcpu,
>> +							ARMV8_MAX_COUNTERS - 1);
>> +			*vcpu_reg(vcpu, p->Rt) = val;
>> +			break;
>> +		}
>>  		case PMXEVCNTR_EL0: {
>>  			val = kvm_pmu_get_counter_value(vcpu,
>>  						vcpu_sys_reg(vcpu, PMSELR_EL0));
>> @@ -748,7 +754,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  	  access_pmu_regs, reset_pmceid, PMCEID1_EL0 },
>>  	/* PMCCNTR_EL0 */
>>  	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
>> -	  trap_raz_wi },
>> +	  access_pmu_regs, reset_unknown, PMCCNTR_EL0 },
>>  	/* PMXEVTYPER_EL0 */
>>  	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
>>  	  access_pmu_regs, reset_unknown, PMXEVTYPER_EL0 },
>> @@ -997,6 +1003,12 @@ static bool access_pmu_cp15_regs(struct kvm_vcpu *vcpu,
>>  		}
>>  	} else {
>>  		switch (r->reg) {
>> +		case c9_PMCCNTR: {
>> +			val = kvm_pmu_get_counter_value(vcpu,
>> +							ARMV8_MAX_COUNTERS - 1);
> 
> PMCCNTR is for cycle counter. There is a filter register, PMCCFILTR_EL0,
> associated with it. When kvm_pmu_set_counter_event_type() is called, I
> didn't see this filter config been used in perf_event_attr when
> perf_event is created.

According to the spec, to PMXEVTYPER_EL0 it says "When PMSELR_EL0.SEL
selects the cycle counter, this accesses PMCCFILTR_EL0." So within
kvm_pmu_set_counter_event_type, I configure the perf_event_attr based on
the bits of PMXEVTYPER_EL0 and only handle bit P for EL0 and bit U for
EL1 since KVM guest doesn't see EL2 and EL3.

See patch 07/20 :
+	attr.exclude_user = data & ARMV8_EXCLUDE_EL0 ? 1 : 0;
+	attr.exclude_kernel = data & ARMV8_EXCLUDE_EL1 ? 1 : 0;


-- 
Shannon
