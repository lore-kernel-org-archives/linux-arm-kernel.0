From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 24 Aug 2016 14:23:02 +0100
Subject: [PATCH 8/8] arm64: Work around systems with mismatched cache line
 sizes
In-Reply-To: <20160822130205.GF14680@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-9-git-send-email-suzuki.poulose@arm.com>
 <20160822130205.GF14680@arm.com>
Message-ID: <dcad8307-48e7-dd7e-2fef-eed07d2dcd06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 14:02, Will Deacon wrote:
> On Thu, Aug 18, 2016 at 02:10:32PM +0100, Suzuki K Poulose wrote:
>> Systems with differing CPU i-cache/d-cache line sizes can cause
>> problems with the cache management by software when the execution
>> is migrated from one to another. Usually, the application reads
>> the cache size on a CPU and then uses that length to perform cache
>> operations. However, if it gets migrated to another CPU with a smaller
>> cache line size, things could go completely wrong. To prevent such
>> cases, always use the smallest cache line size among the CPUs. The
>> kernel CPU feature infrastructure already keeps track of the safe
>> value for all CPUID registers including CTR. This patch works around
>> the problem by :
>>
>> For kernel, dynamically patch the kernel to read the cache size
>> from the system wide copy of CTR_EL0.
>
> Is it only CTR that is mismatched in practice, or do we need to worry
> about DCZID_EL0 too?

A mismatched DCZID_EL0 is quite possible. However, there is no way to
trap accesses to DCZID_EL0. Rather, we can trap DC ZVA if we clear
SCTLR_EL1.DZE. But then clearing the SCTLR_EL1.DZE implies reading DCZID.DZP
returns 1, indicating DC ZVA is not supported. So if a proper application
checks the DZP before issuing a DC ZVA, we may never be able to emulate it.
Or in other words, if there is a mismatch, the work around is to disable
the DC ZVA operations (which could possibly affect existing (incorrect) userspace
applications assuming DC ZVA is supported without checking the DZP bit).
  
>>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 93c5287..db2d6cb 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -480,6 +480,14 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
>>  		regs->pc += 4;
>>  }
>>
>> +static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
>> +{
>> +	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
>> +
>> +	regs->regs[rt] = sys_ctr_ftr->sys_val;
>> +	regs->pc += 4;
>> +}
>
> Whilst this is correct, I wonder if there's any advantage in reporting a
> *larger* size to userspace and avoid incurring additional trap overhead?

Combining the trapping of user space dc operations for Errata work around for
clean cache, we could possibly report a larger size and emulate it properly
in the kernel. But I think that can be a enhancement on top of this series.

>
> Any idea what sort of size typical JITs are using?

I have no clue about it. I have Cc-ed Rodolph and Stuart, who may have better
idea about the JIT's usage.

Suzuki
