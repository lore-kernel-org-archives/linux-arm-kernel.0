From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Feb 2014 20:27:52 -0500
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1391730137-14814-11-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
Message-ID: <20140207012752.GO8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 12:42:06AM +0100, Andrew Lunn wrote:
> Instantiate the L2 cache from DT. Indicate in DT where the cache
> control register is and if write through should be made.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/arm/mrvl/foroceon.txt      | 19 +++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |  5 +++
>  arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  2 +
>  arch/arm/mach-kirkwood/board-dt.c                  | 15 +------
>  arch/arm/mm/cache-feroceon-l2.c                    | 46 ++++++++++++++++++++++
>  5 files changed, 73 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/foroceon.txt

for the next revision, please split out the dtsi changes into a separate
patch.

> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> new file mode 100644
> index 000000000000..8058676d1476
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt

name typo.

> @@ -0,0 +1,19 @@
> +* Marvell Feroceon Cache
> +
> +Required properties:
> +- compatible : Should be "marvell,feroceon-kirkwood".

This is a little ambiguous, I'd like to see 'l2' in the compatible string.

> +- reg        : Address of the L2 cache control register
> +
> +Optional properties:
> +- writethrough : only if present, the cache will be used in write through mode.
> +
> +Example:
> +		l2: l2-cache at 20128 {
> +			compatible = "marvell,marvell,feroceon-kirkwood";

only need a single 'marvell'.

> +			reg = <0x20128 0x4>;
> +		};
> +
> +There are at least two variants of the Feroceon, differing in how
> +write through is enabled or not. If mv78xx0 support is added, it is
> +expected to have a different compatibility string.
> +
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 6abf44d257df..1d8129ac2672 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -161,6 +161,11 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		l2: l2-cache at 20128 {
> +			compatible = "marvell,feroceon-kirkwood";
> +			reg = <0x20128 0x4>;
> +		};
> +
>  		intc: main-interrupt-ctrl at 20200 {
>  			compatible = "marvell,orion-intc";
>  			interrupt-controller;
> diff --git a/arch/arm/include/asm/hardware/cache-feroceon-l2.h b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
> index 8edd330aabf6..12e1588dc4f1 100644
> --- a/arch/arm/include/asm/hardware/cache-feroceon-l2.h
> +++ b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
> @@ -9,3 +9,5 @@
>   */
>  
>  extern void __init feroceon_l2_init(int l2_wt_override);
> +extern int __init feroceon_of_init(void);
> +
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 34c35510fd17..2ef59ee2182d 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -42,19 +42,6 @@ static void __init kirkwood_map_io(void)
>  	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
>  }
>  
> -static void __init kirkwood_l2_init(void)
> -{
> -#ifdef CONFIG_CACHE_FEROCEON_L2
> -#ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
> -	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
> -	feroceon_l2_init(1);
> -#else
> -	writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
> -	feroceon_l2_init(0);
> -#endif
> -#endif
> -}
> -
>  static struct resource kirkwood_cpufreq_resources[] = {
>  	[0] = {
>  		.start  = CPU_CONTROL_PHYS,
> @@ -211,7 +198,7 @@ static void __init kirkwood_dt_init(void)
>  
>  	BUG_ON(mvebu_mbus_dt_init());
>  
> -	kirkwood_l2_init();
> +	feroceon_of_init();
>  
>  	kirkwood_cpufreq_init();
>  	kirkwood_cpuidle_init();
> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index 898362e7972b..193fe7dbdb12 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -13,11 +13,17 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/highmem.h>
> +#include <linux/io.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
>  #include <asm/hardware/cache-feroceon-l2.h>
>  
> +#define L2_WRITETHROUGH_KIRKWOOD	0x00000010
> +
> +
>  /*
>   * Low-level cache maintenance operations.
>   *
> @@ -350,3 +356,43 @@ void __init feroceon_l2_init(int __l2_wt_override)
>  	printk(KERN_INFO "Feroceon L2: Cache support initialised%s.\n",
>  			 l2_wt_override ? ", in WT override mode" : "");
>  }
> +#ifdef CONFIG_OF
> +static const struct of_device_id feroceon_ids[] __initconst = {
> +	{ .compatible = "marvell,feroceon-kirkwood"},
> +	{}
> +};
> +
> +int __init feroceon_of_init(void)
> +{
> +	struct device_node *node;
> +	void __iomem *base;
> +	bool writethrough = false;
> +	struct resource res;
> +
> +	node = of_find_matching_node(NULL, feroceon_ids);
> +	if (!node) {
> +		pr_info("Didn't find marvell,feroceon-*, not enabling it\n");
> +		return -ENODEV;
> +	}

I'd prefer to fallback to hardcoded register address here.  We know
we're on kirkwood at this point.

thx,

Jason.

> +
> +	if (of_property_read_bool(node, "writethrough"))
> +		writethrough = true;
> +
> +	if (of_address_to_resource(node, 0, &res))
> +		return -ENODEV;
> +
> +	base = ioremap(res.start, resource_size(&res));
> +	if (!base)
> +		return -ENOMEM;
> +
> +	if (writethrough) {
> +		writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
> +		feroceon_l2_init(1);
> +	} else {
> +		writel(readl(base) & ~L2_WRITETHROUGH_KIRKWOOD, base);
> +	feroceon_l2_init(0);
> +	}
> +
> +	return 0;
> +}
> +#endif
> -- 
> 1.8.5.3
> 
