From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 3 Mar 2016 18:27:37 +0000
Subject: [PATCH v2 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <56D87B74.1010306@codeaurora.org>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <1454684330-892-3-git-send-email-james.morse@arm.com>
 <56D87B74.1010306@codeaurora.org>
Message-ID: <56D88219.6040806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/16 17:59, Christopher Covington wrote:
> Hi James,
>
> This change breaks booting linux-next for me.
>
> On 02/05/2016 09:58 AM, James Morse wrote:
>> ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
>> cpu feature boiler plate used by the actual features in later patches.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpu.h    |  1 +
>>   arch/arm64/include/asm/sysreg.h |  4 ++++
>>   arch/arm64/kernel/cpufeature.c  | 10 ++++++++++
>>   arch/arm64/kernel/cpuinfo.c     |  1 +
>>   4 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
>> index b5e9cee4b5f8..13a6103130cd 100644
>> --- a/arch/arm64/include/asm/cpu.h
>> +++ b/arch/arm64/include/asm/cpu.h
>> @@ -36,6 +36,7 @@ struct cpuinfo_arm64 {
>>   	u64		reg_id_aa64isar1;
>>   	u64		reg_id_aa64mmfr0;
>>   	u64		reg_id_aa64mmfr1;
>> +	u64		reg_id_aa64mmfr2;
>>   	u64		reg_id_aa64pfr0;
>>   	u64		reg_id_aa64pfr1;
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 4aeebec3d882..4ef294ec49cc 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -72,6 +72,7 @@
>>
>>   #define SYS_ID_AA64MMFR0_EL1		sys_reg(3, 0, 0, 7, 0)
>>   #define SYS_ID_AA64MMFR1_EL1		sys_reg(3, 0, 0, 7, 1)
>> +#define SYS_ID_AA64MMFR2_EL1		sys_reg(3, 0, 0, 7, 2)
>>
>>   #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
>>   #define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
>> @@ -137,6 +138,9 @@
>>   #define ID_AA64MMFR1_VMIDBITS_SHIFT	4
>>   #define ID_AA64MMFR1_HADBS_SHIFT	0
>>
>> +/* id_aa64mmfr2 */
>> +#define ID_AA64MMFR2_UAO_SHIFT		4
>> +
>>   /* id_aa64dfr0 */
>>   #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
>>   #define ID_AA64DFR0_WRPS_SHIFT		20
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index a84febc40db2..5b8bc98105c1 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -123,6 +123,11 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>>   	ARM64_FTR_END,
>>   };
>>
>> +static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
>> +	ARM64_FTR_END,
>> +};
>> +
>>   static struct arm64_ftr_bits ftr_ctr[] = {
>>   	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
>>   	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
>> @@ -284,6 +289,7 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
>>   	/* Op1 = 0, CRn = 0, CRm = 7 */
>>   	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
>>   	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
>> +	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
>>
>>   	/* Op1 = 3, CRn = 0, CRm = 0 */
>>   	ARM64_FTR_REG(SYS_CTR_EL0, ftr_ctr),
>> @@ -408,6 +414,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>>   	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
>>   	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
>>   	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
>> +	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
>>   	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
>>   	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
>>   	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
>> @@ -517,6 +524,8 @@ void update_cpu_features(int cpu,
>>   				      info->reg_id_aa64mmfr0, boot->reg_id_aa64mmfr0);
>>   	taint |= check_update_ftr_reg(SYS_ID_AA64MMFR1_EL1, cpu,
>>   				      info->reg_id_aa64mmfr1, boot->reg_id_aa64mmfr1);
>> +	taint |= check_update_ftr_reg(SYS_ID_AA64MMFR2_EL1, cpu,
>> +				      info->reg_id_aa64mmfr2, boot->reg_id_aa64mmfr2);
>>
>>   	/*
>>   	 * EL3 is not our concern.
>> @@ -814,6 +823,7 @@ static u64 __raw_read_system_reg(u32 sys_id)
>>   	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(SYS_ID_AA64DFR0_EL1);
>>   	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(SYS_ID_AA64MMFR0_EL1);
>>   	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(SYS_ID_AA64MMFR1_EL1);
>> +	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(SYS_ID_AA64MMFR2_EL1);
>>   	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(SYS_ID_AA64ISAR0_EL1);
>>   	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(SYS_ID_AA64ISAR1_EL1);
>>
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 76df22272804..966fbd52550b 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -210,6 +210,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>>   	info->reg_id_aa64isar1 = read_cpuid(SYS_ID_AA64ISAR1_EL1);
>>   	info->reg_id_aa64mmfr0 = read_cpuid(SYS_ID_AA64MMFR0_EL1);
>>   	info->reg_id_aa64mmfr1 = read_cpuid(SYS_ID_AA64MMFR1_EL1);
>> +	info->reg_id_aa64mmfr2 = read_cpuid(SYS_ID_AA64MMFR2_EL1);
>>   	info->reg_id_aa64pfr0 = read_cpuid(SYS_ID_AA64PFR0_EL1);
>>   	info->reg_id_aa64pfr1 = read_cpuid(SYS_ID_AA64PFR1_EL1);
>
> swapper[0]: undefined instruction: pc=ffffff800808d730
> Code: d5380702 d5380721 f9017c02 f9018001 (d5380742)
> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc6-next-20160303 #1
> Hardware name: (null) (DT)
> task: ffffff8008b2d980 ti: ffffff8008b20000 task.ti: ffffff8008b20000
> PC is at __cpuinfo_store_cpu+0x68/0x198
> LR is at cpuinfo_store_boot_cpu+0x28/0x50
>
> ffffff800808d730:       d5380742        mrs     x2, s3_0_c0_c7_2

Hmm, per table C5-6 in the ARMv8 ARM (issue i), that's specifically a 
reserved encoding, rather than an unallocated one, so it should read as 
zero, not undef. What are you running on?

Robin.

>
> Thanks,
> Christopher Covington
>
