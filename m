From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Sep 2018 14:30:38 +0100
Subject: [PATCH RESEND 2/6] arm64: add sysfs vulnerability show for
 meltdown
In-Reply-To: <20180827143310.641-3-ykaukab@suse.de>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-3-ykaukab@suse.de>
Message-ID: <20180917133037.GB23040@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 04:33:06PM +0200, Mian Yousaf Kaukab wrote:
> Checking CSV3 support directly in case CONFIG_UNMAP_KERNEL_AT_EL0
> is not enabled.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index dec10898d688..996edb4e18ad 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -22,6 +22,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpufeature.h>
> +#include <asm/mmu.h>
>  
>  static bool __maybe_unused
>  is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
> @@ -683,3 +684,26 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	{
>  	}
>  };
> +
> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> +
> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	u64 pfr0;
> +	u32 csv3;
> +
> +	if (arm64_kernel_unmapped_at_el0())
> +		return sprintf(buf, "Mitigation: KPTI\n");
> +
> +	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> +	csv3 = cpuid_feature_extract_unsigned_field(pfr0,
> +			ID_AA64PFR0_CSV3_SHIFT);
> +
> +	if (csv3 || is_cpu_meltdown_safe())
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Vulnerable\n");

This should say something like "Unknown", since we don't actually have a
reliable way to determine that a CPU is vulnerable. That's also a large
part of the reason why we haven't bothered implementing the sysfs interface
so far.

Will
