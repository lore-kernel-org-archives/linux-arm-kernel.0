From: zhichao.huang@linaro.org (zichao)
Date: Mon, 15 Jun 2015 00:17:23 +0800
Subject: [PATCH v2 04/11] KVM: arm: common infrastructure for handling
 AArch32 CP14/CP15
In-Reply-To: <87y4jt6tyw.fsf@linaro.org>
References: <1433046432-1824-1-git-send-email-zhichao.huang@linaro.org>
 <1433046432-1824-5-git-send-email-zhichao.huang@linaro.org>
 <87y4jt6tyw.fsf@linaro.org>
Message-ID: <557DA913.5030205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/6/9 18:45, Alex Benn?e wrote:
> 
> Zhichao Huang <zhichao.huang@linaro.org> writes:
> 
>> As we're about to trap a bunch of CP14 registers, let's rework
>> the CP15 handling so it can be generalized and work with multiple
>> tables.
>>
>> Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
>> ---
>>  arch/arm/kvm/coproc.c          | 176 ++++++++++++++++++++++++++---------------
>>  arch/arm/kvm/interrupts_head.S |   2 +-
>>  2 files changed, 112 insertions(+), 66 deletions(-)
>>
>> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
>> index 9d283d9..d23395b 100644
>> --- a/arch/arm/kvm/coproc.c
>> +++ b/arch/arm/kvm/coproc.c
>> @@ -375,6 +375,9 @@ static const struct coproc_reg cp15_regs[] = {
>>  	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
>>  };
>>  
>> +static const struct coproc_reg cp14_regs[] = {
>> +};
>> +
>>  /* Target specific emulation tables */
>>  static struct kvm_coproc_target_table *target_tables[KVM_ARM_NUM_TARGETS];
>>  
>> @@ -424,47 +427,75 @@ static const struct coproc_reg *find_reg(const struct coproc_params *params,
>>  	return NULL;
>>  }
>>  
>> -static int emulate_cp15(struct kvm_vcpu *vcpu,
>> -			const struct coproc_params *params)
>> +/*
>> + * emulate_cp --  tries to match a cp14/cp15 access in a handling table,
>> + *                and call the corresponding trap handler.
>> + *
>> + * @params: pointer to the descriptor of the access
>> + * @table: array of trap descriptors
>> + * @num: size of the trap descriptor array
>> + *
>> + * Return 0 if the access has been handled, and -1 if not.
>> + */
>> +static int emulate_cp(struct kvm_vcpu *vcpu,
>> +			const struct coproc_params *params,
>> +			const struct coproc_reg *table,
>> +			size_t num)
>>  {
>> -	size_t num;
>> -	const struct coproc_reg *table, *r;
>> -
>> -	trace_kvm_emulate_cp15_imp(params->Op1, params->Rt1, params->CRn,
>> -				   params->CRm, params->Op2,
>> params->is_write);
> 
> Where has this trace gone? We still want to be able to view register
> traps when debugging.
> 

OK, I will add it in v3 patches.

> 
