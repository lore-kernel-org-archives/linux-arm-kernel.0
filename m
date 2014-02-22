From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 15:11:45 -0500
Subject: [PATCH v4 10/22] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1393096504-11844-11-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
 <1393096504-11844-11-git-send-email-andrew@lunn.ch>
Message-ID: <20140222201145.GG7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Feb 22, 2014 at 08:14:52PM +0100, Andrew Lunn wrote:
> Instantiate the L2 cache from DT. Indicate in DT where the cache
> control register is so that it is possible to enable/disable write
> through on the CPU.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> cc: devicetree at vger.kernel.org
> ---
> v2:
> Change compatible strings to follow l2x0 convention
> Only expect register for kirkwood-cache.
> Default to write through if no DT node.
> Rename writethrough to wt-override to follow l2cc binding.
> Split kirkwood.dtsi change into a patch of its own.
> v3
> Remove wt-override from the binding
> Respect CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
> ---
>  .../devicetree/bindings/arm/mrvl/feroceon.txt      | 16 ++++++++
>  arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  2 +
>  arch/arm/mach-kirkwood/board-dt.c                  | 18 ++-------
>  arch/arm/mm/cache-feroceon-l2.c                    | 43 ++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/feroceon.txt

I've asked Andrew to place the other two patches into your patch
tracker.  The rest of the series depends on this one, though.  Could you
please Ack it so that we can keep it together through mvebu/arm-soc?

thx,

Jason.

> diff --git a/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt b/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
> new file mode 100644
> index 000000000000..0d244b999d10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
> @@ -0,0 +1,16 @@
> +* Marvell Feroceon Cache
> +
> +Required properties:
> +- compatible : Should be either "marvell,feroceon-cache" or
> +  	       "marvell,kirkwood-cache".
> +
> +Optional properties:
> +- reg        : Address of the L2 cache control register. Mandatory for
> +  	       "marvell,kirkwood-cache", not used by "marvell,feroceon-cache"
> +
> +
> +Example:
> +		l2: l2-cache at 20128 {
> +			compatible = "marvell,kirkwood-cache";
> +			reg = <0x20128 0x4>;
> +		};
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
> index 29c246858d5a..ec0702c02d6c 100644
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
> @@ -211,8 +198,9 @@ static void __init kirkwood_dt_init(void)
>  
>  	BUG_ON(mvebu_mbus_dt_init());
>  
> -	kirkwood_l2_init();
> -
> +#ifdef CONFIG_CACHE_FEROCEON_L2
> +	feroceon_of_init();
> +#endif
>  	kirkwood_cpufreq_init();
>  	kirkwood_cpuidle_init();
>  
> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index 898362e7972b..8dc1a2b5a8ed 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -13,11 +13,16 @@
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
> +#define L2_WRITETHROUGH_KIRKWOOD	BIT(4)
> +
>  /*
>   * Low-level cache maintenance operations.
>   *
> @@ -350,3 +355,41 @@ void __init feroceon_l2_init(int __l2_wt_override)
>  	printk(KERN_INFO "Feroceon L2: Cache support initialised%s.\n",
>  			 l2_wt_override ? ", in WT override mode" : "");
>  }
> +#ifdef CONFIG_OF
> +static const struct of_device_id feroceon_ids[] __initconst = {
> +	{ .compatible = "marvell,kirkwood-cache"},
> +	{ .compatible = "marvell,feroceon-cache"},
> +	{}
> +};
> +
> +int __init feroceon_of_init(void)
> +{
> +	struct device_node *node;
> +	void __iomem *base;
> +	bool l2_wt_override = false;
> +	struct resource res;
> +
> +#if defined(CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH)
> +	l2_wt_override = true;
> +#endif
> +
> +	node = of_find_matching_node(NULL, feroceon_ids);
> +	if (node && of_device_is_compatible(node, "marvell,kirkwood-cache")) {
> +		if (of_address_to_resource(node, 0, &res))
> +			return -ENODEV;
> +
> +		base = ioremap(res.start, resource_size(&res));
> +		if (!base)
> +			return -ENOMEM;
> +
> +		if (l2_wt_override)
> +			writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
> +		else
> +			writel(readl(base) & ~L2_WRITETHROUGH_KIRKWOOD, base);
> +	}
> +
> +	feroceon_l2_init(l2_wt_override);
> +
> +	return 0;
> +}
> +#endif
> -- 
> 1.8.5.3
> 
