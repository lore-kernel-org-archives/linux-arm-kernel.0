From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Mar 2016 12:38:20 +0100
Subject: [RFC PATCH 3/3] arm64: Expose cpu vender id and model name
 through cpuinfo
In-Reply-To: <1458898209-7486-4-git-send-email-wangkefeng.wang@huawei.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458898209-7486-4-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160329113820.GD26574@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 05:30:09PM +0800, Kefeng Wang wrote:
> It is helpful to show the name of chip vendor and CPU model
> to customers in cpuinfo, identify them by using CPU implementer
> and CPU part is not intuitive(compared with x86).

On x86 these strings are acquired from the CPU itself, via CPUID
instructions, which means that it works for future CPUs. For ARM
systems, we have no consistent way of acquiring a model name from a CPU
itself. Given the rate at which implementations are appearing, and
recent experience [1] with issues mapping MIDRs to human-readable names,
this is going to be very problematic.

We already expose the raw field values from MIDR_EL1, which are
sufficient for a userspace application to identify a particular
processor regardless of whether the kernel recognises it, and regardless
of what firmware told the kernel. GCC for instance identifies CPUs based
on MIDR_EL1 fields.

We also don't do this for arch/arm, and the two should look the same.

> We are complained for this several times, so expose them.

If you which to have human-readable strings for a CPU, a better approach
would be to teach some userspace tool to map MIDR_EL1 values to vendor
strings. It would be possible to update that tool when new CPUs appear,
completely independently of the kernel.

NAK for this approach. It is not scalable, and there are other
approaches which work today for the set of problems this tries to
address.

Thanks,
Mark.

[1] https://community.arm.com/groups/processors/blog/2014/09/30/arm-cortex-a17-cortex-a12-processor-update

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/cpu.h |  2 ++
>  arch/arm64/kernel/cpuinfo.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 13a6103..b8c3d79 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -25,6 +25,8 @@
>   */
>  struct cpuinfo_arm64 {
>  	struct cpu	cpu;
> +	char		vendor[16];
> +	char		model_name[16];
>  	u32		reg_ctr;
>  	u32		reg_cntfrq;
>  	u32		reg_dczid;
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 488d49a..da5f7df 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -19,6 +19,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpufeature.h>
> +#include <asm/elf.h>
>  
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
> @@ -100,6 +101,62 @@ static const char *const compat_hwcap2_str[] = {
>  };
>  #endif /* CONFIG_COMPAT */
>  
> +static void cpuinfo_get_vendor_model(struct cpuinfo_arm64 *info)
> +{
> +	char *vendor = info->vendor;
> +	char *name = info->model_name;
> +	u32 midr = info->reg_midr;
> +	u32 impl = MIDR_IMPLEMENTOR(midr);
> +	u32 part = MIDR_PARTNUM(midr);
> +
> +	switch (impl) {
> +	case ARM_CPU_IMP_ARM:
> +		strcpy(vendor, "ARM");
> +		switch (part) {
> +		case ARM_CPU_PART_AEM_V8:
> +			strcpy(name, "AEM-V8");
> +			break;
> +		case ARM_CPU_PART_FOUNDATION:
> +			strcpy(name, "Foundation");
> +			break;
> +		case ARM_CPU_PART_CORTEX_A53:
> +			strcpy(name, "Cortex-A53");
> +			break;
> +		case ARM_CPU_PART_CORTEX_A57:
> +			strcpy(name, "Cortex-A57");
> +			break;
> +		};
> +		break;
> +	case ARM_CPU_IMP_APM:
> +		strcpy(vendor, "APM");
> +		switch (part) {
> +		case APM_CPU_PART_POTENZA:
> +			strcpy(name, "Potenza");
> +			break;
> +		};
> +		break;
> +	case ARM_CPU_IMP_CAVIUM:
> +		strcpy(vendor, "CAVIUM");
> +		switch (part) {
> +		case CAVIUM_CPU_PART_THUNDERX:
> +			strcpy(name, "Thunderx");
> +			break;
> +		};
> +		break;
> +	case ARM_CPU_IMP_BRCM:
> +		strcpy(vendor, "BROADCOM");
> +		switch (part) {
> +		case BRCM_CPU_PART_VULCAN:
> +			strcpy(name, "Vulcan");
> +			break;
> +		};
> +		break;
> +	default:
> +		strcpy(vendor, "Unknown");
> +		strcpy(name, "Unknown");
> +	}
> +}
> +
>  static int c_show(struct seq_file *m, void *v)
>  {
>  	int i, j;
> @@ -116,6 +173,9 @@ static int c_show(struct seq_file *m, void *v)
>  		 * "processor".  Give glibc what it expects.
>  		 */
>  		seq_printf(m, "processor\t: %d\n", i);
> +		seq_printf(m, "vendor_id\t: %s\n", cpuinfo->vendor);
> +		seq_printf(m, "model name\t: %s rev %d (%s)\n", cpuinfo->model_name,
> +			   MIDR_REVISION(midr), ELF_PLATFORM);
>  
>  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
>  			   loops_per_jiffy / (500000UL/HZ),
> @@ -238,6 +298,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>  	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
>  	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
>  
> +	cpuinfo_get_vendor_model(info);
> +
>  	cpuinfo_detect_icache_policy(info);
>  
>  	check_local_cpu_errata();
> -- 
> 1.7.12.4
> 
