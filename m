From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 21:26:52 +0200
Subject: [PATCH 20/22] ARM: sun8i: Add SMP support for the Allwinner A23
In-Reply-To: <1400831485-28576-21-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-21-git-send-email-wens@csie.org>
Message-ID: <20140525192652.GZ10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:23PM +0800, Chen-Yu Tsai wrote:
> The A23 is a dual Cortex-A7. Add the logic to use the IPs used to
> control the CPU configuration and the CPU power so that we can
> bring up secondary CPUs at boot.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/mach-sunxi/platsmp.c | 69 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
> index c53077b..688faaf 100644
> --- a/arch/arm/mach-sunxi/platsmp.c
> +++ b/arch/arm/mach-sunxi/platsmp.c
> @@ -121,3 +121,72 @@ struct smp_operations sun6i_smp_ops __initdata = {
>  	.smp_boot_secondary	= sun6i_smp_boot_secondary,
>  };
>  CPU_METHOD_OF_DECLARE(sun6i_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
> +
> +static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "allwinner,sun8i-a23-prcm");
> +	if (!node) {
> +		pr_err("Missing A23 PRCM node in the device tree\n");
> +		return;
> +	}
> +
> +	prcm_membase = of_iomap(node, 0);
> +	if (!prcm_membase) {
> +		pr_err("Couldn't map A23 PRCM registers\n");
> +		return;
> +	}
> +
> +	node = of_find_compatible_node(NULL, NULL,
> +				       "allwinner,sun8i-a23-cpuconfig");
> +	if (!node) {
> +		pr_err("Missing A23 CPU config node in the device tree\n");
> +		return;
> +	}
> +
> +	cpucfg_membase = of_iomap(node, 0);
> +	if (!cpucfg_membase)
> +		pr_err("Couldn't map A23 CPU config registers\n");
> +
> +}
> +
> +static int sun8i_smp_boot_secondary(unsigned int cpu,
> +				    struct task_struct *idle)
> +{
> +	u32 reg;
> +
> +	if (!(prcm_membase && cpucfg_membase))
> +		return -EFAULT;
> +
> +	spin_lock(&cpu_lock);
> +
> +	/* Set CPU boot address */
> +	writel(virt_to_phys(secondary_startup),
> +	       cpucfg_membase + CPUCFG_PRIVATE0_REG);
> +
> +	/* Assert the CPU core in reset */
> +	writel(0, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
> +
> +	/* Assert the L1 cache in reset */
> +	reg = readl(cpucfg_membase + CPUCFG_GEN_CTRL_REG);
> +	writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_GEN_CTRL_REG);
> +
> +	/* Clear CPU power-off gating */
> +	reg = readl(prcm_membase + PRCM_CPU_PWROFF_REG);
> +	writel(reg & ~BIT(cpu), prcm_membase + PRCM_CPU_PWROFF_REG);
> +	mdelay(1);
> +
> +	/* Deassert the CPU core reset */
> +	writel(3, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
> +
> +	spin_unlock(&cpu_lock);
> +
> +	return 0;
> +}
> +
> +struct smp_operations sun8i_smp_ops __initdata = {
> +	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
> +	.smp_boot_secondary	= sun8i_smp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(sun8i_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);

You forgot to document the new enable-method.

Also, is there any plan to hae a working u-boot? I'd much prefer to
use PSCI if possible.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/6a950130/attachment-0001.sig>
