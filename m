From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Sep 2015 15:42:52 +0200
Subject: [PATCH 1/2] ARM: mvebu: add support to clear shared L2 bit on
 Armada XP
In-Reply-To: <1436364561-20958-2-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 8 Jul 2015 16:09:20 +0200")
References: <1436364561-20958-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436364561-20958-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <877fn9s5nn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., juil. 08 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> For optimal performance, in a HW I/O coherency context such as the one
> used on Armada XP, the shared L2 bit of the CPU configuration register
> should be cleared.
>
> This commit adjusts the coherency fabric code used by Marvell EBU
> processors to clear this bit on Armada XP. Since it's a per-CPU
> register, it's cleared in set_cpu_coherent() for the boot CPU, and
> through a CPU notifier for the non-boot CPUs.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/soc with a conflict resolution due to the rebase on 4.3-rc1

Thanks,

Gregory
> ---
>  .../devicetree/bindings/arm/mvebu-cpu-config.txt   | 20 +++++++
>  arch/arm/mach-mvebu/coherency.c                    | 61 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt b/Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt
> new file mode 100644
> index 0000000..2cdcd71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt
> @@ -0,0 +1,20 @@
> +MVEBU CPU Config registers
> +--------------------------
> +
> +MVEBU (Marvell SOCs: Armada 370/XP)
> +
> +Required properties:
> +
> +- compatible: one of:
> +	- "marvell,armada-370-cpu-config"
> +	- "marvell,armada-xp-cpu-config"
> +
> +- reg: Should contain CPU config registers location and length, in
> +  their per-CPU variant
> +
> +Example:
> +
> +	cpu-config at 21000 {
> +		compatible = "marvell,armada-xp-cpu-config";
> +		reg = <0x21000 0x8>;
> +	};
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index e46e9ea..48655f8 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -40,6 +40,7 @@
>  unsigned long coherency_phys_base;
>  void __iomem *coherency_base;
>  static void __iomem *coherency_cpu_base;
> +static void __iomem *cpu_config_base;
>  
>  /* Coherency fabric registers */
>  #define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
> @@ -65,6 +66,31 @@ static const struct of_device_id of_coherency_table[] = {
>  int ll_enable_coherency(void);
>  void ll_add_cpu_to_smp_group(void);
>  
> +#define CPU_CONFIG_SHARED_L2 BIT(16)
> +
> +/*
> + * Disable the "Shared L2 Present" bit in CPU Configuration register
> + * on Armada XP.
> + *
> + * The "Shared L2 Present" bit affects the "level of coherence" value
> + * in the clidr CP15 register.  Cache operation functions such as
> + * "flush all" and "invalidate all" operate on all the cache levels
> + * that included in the defined level of coherence. When HW I/O
> + * coherency is used, this bit causes unnecessary flushes of the L2
> + * cache.
> + */
> +static void armada_xp_clear_shared_l2(void)
> +{
> +	u32 reg;
> +
> +	if (!cpu_config_base)
> +		return;
> +
> +	reg = readl(cpu_config_base);
> +	reg &= ~CPU_CONFIG_SHARED_L2;
> +	writel(reg, cpu_config_base);
> +}
> +
>  int set_cpu_coherent(void)
>  {
>  	if (!coherency_base) {
> @@ -73,10 +99,13 @@ int set_cpu_coherent(void)
>  		return 1;
>  	}
>  
> +	armada_xp_clear_shared_l2();
>  	ll_add_cpu_to_smp_group();
>  	return ll_enable_coherency();
>  }
>  
> +
> +
>  static int mvebu_hwcc_notifier(struct notifier_block *nb,
>  			       unsigned long event, void *__dev)
>  {
> @@ -97,9 +126,24 @@ static struct notifier_block mvebu_hwcc_pci_nb = {
>  	.notifier_call = mvebu_hwcc_notifier,
>  };
>  
> +static int armada_xp_clear_shared_l2_notifier_func(struct notifier_block *nfb,
> +						   unsigned long action, void *hcpu)
> +{
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +		armada_xp_clear_shared_l2();
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block armada_xp_clear_shared_l2_notifier = {
> +	.notifier_call = armada_xp_clear_shared_l2_notifier_func,
> +	.priority = 100,
> +};
> +
>  static void __init armada_370_coherency_init(struct device_node *np)
>  {
>  	struct resource res;
> +	struct device_node *cpu_config_np;
>  
>  	of_address_to_resource(np, 0, &res);
>  	coherency_phys_base = res.start;
> @@ -112,6 +156,23 @@ static void __init armada_370_coherency_init(struct device_node *np)
>  	sync_cache_w(&coherency_phys_base);
>  	coherency_base = of_iomap(np, 0);
>  	coherency_cpu_base = of_iomap(np, 1);
> +
> +	cpu_config_np = of_find_compatible_node(NULL, NULL,
> +						"marvell,armada-xp-cpu-config");
> +	if (!cpu_config_np)
> +		goto exit;
> +
> +	cpu_config_base = of_iomap(cpu_config_np, 0);
> +	if (!cpu_config_base) {
> +		of_node_put(cpu_config_np);
> +		goto exit;
> +	}
> +
> +	of_node_put(cpu_config_np);
> +
> +	register_cpu_notifier(&armada_xp_clear_shared_l2_notifier);
> +
> +exit:
>  	set_cpu_coherent();
>  }

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
