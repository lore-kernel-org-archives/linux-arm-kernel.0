From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 14:59:22 +0100
Subject: [PATCH v2 03/21] arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
In-Reply-To: <1453737235-16522-4-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201135922.GO1478@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:37PM +0000, Marc Zyngier wrote:
> Add a new ARM64_HAS_VIRT_HOST_EXTN features to indicate that the
> CPU has the ARMv8.1 VHE capability.
> 
> This will be used to trigger kernel patching in KVM.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c      | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8f271b8..c705d6a 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -30,8 +30,9 @@
>  #define ARM64_HAS_LSE_ATOMICS			5
>  #define ARM64_WORKAROUND_CAVIUM_23154		6
>  #define ARM64_WORKAROUND_834220			7
> +#define ARM64_HAS_VIRT_HOST_EXTN		8
>  
> -#define ARM64_NCAPS				8
> +#define ARM64_NCAPS				9
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 5c90aa4..8d3961e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -26,6 +26,9 @@
>  #include <asm/cpu_ops.h>
>  #include <asm/processor.h>
>  #include <asm/sysreg.h>
> +#include <asm/virt.h>
> +
> +#include <linux/irqchip/arm-gic-v3.h>
>  
>  unsigned long elf_hwcap __read_mostly;
>  EXPORT_SYMBOL_GPL(elf_hwcap);
> @@ -587,8 +590,6 @@ u64 read_system_reg(u32 id)
>  	return regp->sys_val;
>  }
>  
> -#include <linux/irqchip/arm-gic-v3.h>
> -

unrelated change?

>  static bool
>  feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
>  {
> @@ -621,6 +622,11 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
>  	return has_sre;
>  }
>  
> +static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
> +{
> +	return is_kernel_in_hyp_mode();
> +}
> +
>  static const struct arm64_cpu_capabilities arm64_features[] = {
>  	{
>  		.desc = "GIC system register CPU interface",
> @@ -651,6 +657,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.min_field_value = 2,
>  	},
>  #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
> +	{
> +		.desc = "Virtualization Host Extensions",
> +		.capability = ARM64_HAS_VIRT_HOST_EXTN,
> +		.matches = runs_at_el2,
> +	},
>  	{},
>  };
>  
> -- 
> 2.1.4
> 

Otherwise:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
