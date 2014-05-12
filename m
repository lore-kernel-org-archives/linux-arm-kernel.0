From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 May 2014 16:11:14 +0100
Subject: [PATCH 3/3] arm64: add runtime system sanity checks
In-Reply-To: <1399905470-26500-4-git-send-email-mark.rutland@arm.com>
References: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
 <1399905470-26500-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20140512151114.GE18960@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 03:37:50PM +0100, Mark Rutland wrote:
> Unexpected variation in certain system register values across CPUs is an
> indicator of potential problems with a system. The kernel expects CPUs
> to be mostly identical in terms of supported features, even in systems
> with homogeneous CPUs, with uniform instruction set support being

You mean heterogeneous, right?

> critical for the correct operation of userspace.
> 
> To help detect issues early where hardware violates the expectations of
> the kernel, this patch adds simple runtime sanity checks on important ID
> registers in the bring up path of each CPU.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h | 21 +++++++++-
>  arch/arm64/kernel/cpuinfo.c  | 97 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 74bf9bb..33a0e70 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -16,11 +16,30 @@
>  /*
>   * Records attributes of an individual CPU.
>   *
> - * This is used to cache data for /proc/cpuinfo.
> + * This is used to cache data for /proc/cpuinfo and run-time sanity checks.
>   */
>  struct cpuinfo_arm64 {
>  	struct cpu	cpu;
> +	u32		reg_ctr;
> +	u32		reg_cntfrq;
>  	u32		reg_midr;
> +
> +	u64		reg_id_aa64isar0;
> +	u64		reg_id_aa64mmfr0;
> +	u64		reg_id_aa64pfr0;
> +
> +	u32		reg_id_isar0;
> +	u32		reg_id_isar1;
> +	u32		reg_id_isar2;
> +	u32		reg_id_isar3;
> +	u32		reg_id_isar4;
> +	u32		reg_id_isar5;
> +	u32		reg_id_mmfr0;
> +	u32		reg_id_mmfr1;
> +	u32		reg_id_mmfr2;
> +	u32		reg_id_mmfr3;
> +	u32		reg_id_pfr0;
> +	u32		reg_id_pfr1;
>  };
>  
>  DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index b9e18c5..bccee60 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -1,5 +1,6 @@
>  /*
> - * Record CPU attributes for later retrieval
> + * Record CPU attributes for later retrieval, and sanity-check that processor
> + * features do not vary unexpectedly.
>   *
>   * Copyright (C) 2014 ARM Ltd.
>   * This program is free software; you can redistribute it and/or modify
> @@ -15,16 +16,110 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  #include <asm/cpu.h>
> +#include <asm/arch_timer.h>
>  
> +#include <linux/printk.h>
>  #include <linux/smp.h>
> +#include <linux/types.h>
>  
>  DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  
> +static void check_reg_mask(char *name, u64 mask, u64 boot, u64 cur, int cpu)
> +{
> +	if ((boot & mask) == (cur & mask))
> +		return;
> +
> +	pr_warn("SANITY CHECK: Unexpected variation in %s. cpu0: %#016lx, cpu%d: %#016lx\n",
> +		name, (unsigned long)boot, cpu, (unsigned long)cur);

Use could use pr_fmt for the prefix.

> +}
> +
> +#define	CHECK_MASK(field, mask, boot, cur, cpu)	\
> +	check_reg_mask(#field, mask, (boot)->reg_ ## field, (cur)->reg_ ## field, cpu)
> +
> +#define CHECK(field, boot, cur, cpu)	\
> +	CHECK_MASK(field, (u64)-1, boot, cur, cpu)
> +
> +/*
> + * Verify that CPUs don't have unexpected differences that will cause problems.
> + */
> +void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
> +{
> +	struct cpuinfo_arm64 *boot = &per_cpu(cpu_data, 0);
> +	int cpu = smp_processor_id();
> +
> +	/*
> +	 * The kernel can handle differing I-cache policies, but otherwise
> +	 * caches should look identical. Userspace JITs will make use of
> +	 * *minLine.
> +	 */
> +	CHECK_MASK(ctr, 0xffff3fff, boot, cur, cpu);

Actually, if we have different I-cache policies we need to make sure that
icache_is_aliasing reports true on all CPUs, otherwise GDB will break
(via flush_ptrace_access).

Otherwise, looks like a good series to me.

Will
