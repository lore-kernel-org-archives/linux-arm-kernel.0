From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Dec 2012 08:00:46 -0600
Subject: [PATCH 4/4] ARM: tegra: Set SCU base address dynamically from DT
In-Reply-To: <1355725087-11363-4-git-send-email-hdoyu@nvidia.com>
References: <1355725087-11363-1-git-send-email-hdoyu@nvidia.com>
 <1355725087-11363-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <50CF258E.2080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 12:18 AM, Hiroshi Doyu wrote:
> Set Snoop Control Unit(SCU) register base address dynamically from DT.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mach-tegra/platsmp.c |   23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 1b926df..45c0b79 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -18,6 +18,8 @@
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/gic.h>
> @@ -36,7 +38,7 @@
>  
>  extern void tegra_secondary_startup(void);
>  
> -static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
> +static void __iomem *scu_base;
>  
>  #define EVP_CPU_RESET_VECTOR \
>  	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
> @@ -143,14 +145,28 @@ done:
>  	return status;
>  }
>  
> +static const struct of_device_id cortex_a9_scu_match[] __initconst = {
> +	{ .compatible = "arm,cortex-a9-scu", },
> +	{}
> +};
> +
>  /*
>   * Initialise the CPU possible map early - this describes the CPUs
>   * which may be present or become present in the system.
>   */
>  static void __init tegra_smp_init_cpus(void)
>  {
> -	unsigned int i, ncores = scu_get_core_count(scu_base);
> +	struct device_node *np;
> +	unsigned int i, ncores = 1;
> +
> +	np = of_find_matching_node(NULL, cortex_a9_scu_match);
> +	if (!np)
> +		return;
> +	scu_base = of_iomap(np, 0);

Did you actually test this? Unless something changed, ioremap does not
work this early. The only reason to have it mapped this early is to get
the core count, but that doesn't work on A15 or A7. So we really need to
get core count/mask in a standard way. At least some work to get core
count from DT went into 3.8.

BTW, you can get the scu address on the A9 by reading cp15 register:

	/* Get SCU base */
	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));

It's still probably good to have the DT node, but the reg property can
be optional in this case.

We need to move away from having the DT matching code within the
platforms. This should all be moved to the scu code in a scu_of_init
function that could be called from common code.

Rob

> +	if (!scu_base)
> +		return;
>  
> +	ncores = scu_get_core_count(scu_base);
>  	if (ncores > nr_cpu_ids) {
>  		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
>  			ncores, nr_cpu_ids);
> @@ -166,7 +182,8 @@ static void __init tegra_smp_init_cpus(void)
>  static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	tegra_cpu_reset_handler_init();
> -	scu_enable(scu_base);
> +	if (scu_base)
> +		scu_enable(scu_base);
>  }
>  
>  struct smp_operations tegra_smp_ops __initdata = {
> 
