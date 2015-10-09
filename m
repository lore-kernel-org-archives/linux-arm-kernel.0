From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 9 Oct 2015 11:56:14 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <56163D7F.4000003@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
 <56163D7F.4000003@arm.com>
Message-ID: <56179D4E.9030403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 10:55, Suzuki K. Poulose wrote:
> On 07/10/15 18:16, Catalin Marinas wrote:
>> On Mon, Oct 05, 2015 at 06:01:56PM +0100, Suzuki K. Poulose wrote:
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 1ae8b24..d42ad90 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -58,8 +58,442 @@ static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
>>>       mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);

>>> + * sys_reg() encoding.
>>> + *
>>> + * We track only the following space:
>>> + * Op0 = 3, Op1 = 0, CRn = 0, CRm = [1 - 7], Op2 = [0 - 7]
>>> + * Op0 = 3, Op1 = 3, CRn = 0, CRm = 0, Op2 = { 1, 7 }     (CTR, DCZID)
>>> + * Op0 = 3, Op1 = 3, CRn = 14, CRm = 0, Op2 = 0        (CNTFRQ)
>>> + *
>>> + * The space (3, 0, 0, {1-7}, {0-7}) is arranged in a 2D array op1_0,
>>> + * indexed by CRm and Op2. Since not all CRm's have fully allocated Op2's
>>> + * arm64_reg_table[CRm-1].n indicates the largest Op2 tracked for CRm.
>>> + *
>>> + * Since we have limited number of entries with Op1 = 3, we use linear search
>>> + * to find the reg.
>>> + *
>>> + */
>>> +static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)
>>> +{
>>> +    int i;
>>> +    u8 op2, crn, crm;
>>> +    u8 op1 = sys_reg_Op1(sys_id);
>>> +
>>> +    if (sys_reg_Op0(sys_id) != 3)
>>> +        return NULL;
>>> +    switch (op1) {
>>> +    case 0:
>>> +
>>> +        crm = sys_reg_CRm(sys_id);
>>> +        op2 = sys_reg_Op2(sys_id);
>>> +        crn = sys_reg_CRn(sys_id);
>>> +        if (crn || !crm || crm > 7)
>>> +            return NULL;
>>> +        if (op2 < op1_0[crm - 1].n &&
>>> +            op1_0[crm - 1].regs[op2].sys_id == sys_id)
>>> +            return &op1_0[crm - 1].regs[op2];
>>> +        return NULL;
>>> +    case 3:
>>> +        for (i = 0; i < ARRAY_SIZE(op1_3); i++)
>>> +            if (op1_3[i].sys_id == sys_id)
>>> +                return &op1_3[i];
>>> +    }
>>> +    return NULL;
>>> +}
>>
>> For this function, do we ever expect to be called with an invalid
>> sys_id? You could add a BUG_ON(!ret) here.
>>
>
> It could be called for an id which Reserved RAZ in the id range, we
> plan to emulate. i.e, (3, 0, 0, [0-7], [0-7]).
> See emulate_sys_reg(u32 id, u64 *valp) in Patch 20/22.
> Since we don't track them, we return NULL here..
> We could BUG_ON() all the other cases (e.g, MIDR and the other
> classes).
>
> Thanks for pointing that out.

Actually, the error handling is left to the users of the function.
We do a BUG_ON() in the caller. e.g, init/update_cpu_ftr_reg can't
accept a NULL and BUGs. While the emulate_sys_reg() issues the call
only for the emualted feature registers(excluding MIDR/REVIDR etc),
so a NULL is perfectly acceptable for them.

Thanks
Suzuki
