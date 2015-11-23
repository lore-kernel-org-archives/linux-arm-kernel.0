From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 17:29:20 +0000
Subject: [PATCH 5/5] arm64: Ensure the secondary CPUs have safe ASIDBits
 size
In-Reply-To: <1447866540-23207-5-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151123172920.GB1702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 05:09:00PM +0000, Suzuki K. Poulose wrote:
> The ID_AA64MMFR0_EL1:ASIDBits determines the size of the mm context
> id and is used in the early boot to make decisions. The value is
> picked up from the Boot CPU and cannot be delayed until other CPUs
> are up. If a secondary CPU has a smaller size than that of the Boot
> CPU, things will break horribly and the usual SANITY check is not good
> enough to prevent the system from crashing. Prevent this by failing CPUs with
> ASID smaller than that of the boot CPU.
> 
> Also moves the fail_incapable_cpu() out of the CONFIG_HOTPLUG_CPU.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c |   81 +++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 5629f2c..769782a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -293,6 +293,28 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
>  	ARM64_FTR_REG(SYS_CNTFRQ_EL0, ftr_generic32),
>  };
>  
> +/*
> + * Park the calling CPU which doesn't have the capability
> + * as advertised by the system.
> + */
> +static void fail_incapable_cpu(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	pr_crit("CPU%d: will not boot\n", cpu);

This is less informative than the current message (whcih describes the
missing capability).

> +
> +	/* Mark this CPU absent */
> +	set_cpu_present(cpu, 0);
> +
> +	/* Check if we can park ourselves */
> +	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
> +		cpu_ops[cpu]->cpu_die(cpu);
> +	asm(
> +	"1:	wfe\n"
> +	"	wfi\n"
> +	"	b	1b");
> +}
> +
>  static int search_cmp_ftr_reg(const void *id, const void *regp)
>  {
>  	return (int)(unsigned long)id - (int)((const struct arm64_ftr_reg *)regp)->sys_id;
> @@ -459,6 +481,40 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
>  }
>  
>  /*
> + * The asid_bits, which determine the width of the mm context
> + * id, is based on the boot CPU value. If the new CPU doesn't
> + * have an ASID >= boot CPU, we are in trouble. Fail this CPU.
> + */
> +static void check_cpu_asid_bits(int cpu,
> +				struct cpuinfo_arm64 *info,
> +				struct cpuinfo_arm64 *boot)
> +{
> +	u32 asid_boot = cpuid_feature_extract_unsigned_field(boot->reg_id_aa64mmfr0,
> +							ID_AA64MMFR0_ASID_SHIFT);
> +	u32 asid_cur = cpuid_feature_extract_unsigned_field(info->reg_id_aa64mmfr0,
> +							ID_AA64MMFR0_ASID_SHIFT);
> +	if (asid_cur < asid_boot) {
> +		pr_crit("CPU%d: has incompatible ASIDBits: %u vs Boot CPU:%u\n",
> +				cpu, asid_cur, asid_boot);
> +		fail_incapable_cpu();
> +	}

Hmm. Whilst we want to ensure that secondary CPUs don't have a smaller
ASID size than the boot CPU, can we actually guarantee that a smaller
value for ID_AA64MMFR0.ASIDBits corresponds to fewer bits? We're
probably better off assuming 8-bit ASIDs unless ASIDBits == 2 (which is
what the ASID allocator does).

Will
