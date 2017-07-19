From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 19 Jul 2017 07:51:39 +0200
Subject: [PATCH] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-1-robh@kernel.org>
References: <20170718214339.7774-1-robh@kernel.org>
Message-ID: <20170719055139.GA6246@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:42:41PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> ---
>  arch/arm/kernel/cpuidle.c            | 4 ++--
>  arch/arm/kernel/devtree.c            | 6 +++---
>  arch/arm/kernel/topology.c           | 4 ++--
>  arch/arm/mach-exynos/suspend.c       | 8 ++++----
>  arch/arm/mach-imx/gpc.c              | 4 ++--
>  arch/arm/mach-mvebu/kirkwood.c       | 4 ++--
>  arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
>  arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
>  arch/arm/mach-rockchip/platsmp.c     | 4 ++--
>  arch/arm/mach-shmobile/pm-rmobile.c  | 8 ++++----
>  10 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index a3308ad1a024..fda5579123a8 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -101,8 +101,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
> 
>  	ops = arm_cpuidle_get_ops(enable_method);
>  	if (!ops) {
> -		pr_warn("%s: unsupported enable-method property: %s\n",
> -			dn->full_name, enable_method);
> +		pr_warn("%pOF: unsupported enable-method property: %s\n",
> +			dn, enable_method);
>  		return -EOPNOTSUPP;
>  	}
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f676febbb270..28174c9a94ac 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -95,7 +95,7 @@ void __init arm_dt_init_cpu_maps(void)
>  		if (of_node_cmp(cpu->type, "cpu"))
>  			continue;
> 
> -		pr_debug(" * %s...\n", cpu->full_name);
> +		pr_debug(" * %pOF...\n", cpu);
>  		/*
>  		 * A device tree containing CPU nodes with missing "reg"
>  		 * properties is considered invalid to build the
> @@ -103,8 +103,8 @@ void __init arm_dt_init_cpu_maps(void)
>  		 */
>  		cell = of_get_property(cpu, "reg", &prop_bytes);
>  		if (!cell || prop_bytes < sizeof(*cell)) {
> -			pr_debug(" * %s missing reg property\n",
> -				     cpu->full_name);
> +			pr_debug(" * %pOF missing reg property\n",
> +				     cpu);
>  			of_node_put(cpu);
>  			return;
>  		}
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index bf949a763dbe..e596c5b8f931 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -127,8 +127,8 @@ static void __init parse_dt_topology(void)
> 
>  		rate = of_get_property(cn, "clock-frequency", &len);
>  		if (!rate || len != 4) {
> -			pr_err("%s missing clock-frequency property\n",
> -				cn->full_name);
> +			pr_err("%pOF missing clock-frequency property\n",
> +				cn);
>  			continue;
>  		}
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 748cfb8d5212..3c7b66c22697 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -187,21 +187,21 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
>  	struct irq_domain *parent_domain, *domain;
> 
>  	if (!parent) {
> -		pr_err("%s: no parent, giving up\n", node->full_name);
> +		pr_err("%pOF: no parent, giving up\n", node);
>  		return -ENODEV;
>  	}
> 
>  	parent_domain = irq_find_host(parent);
>  	if (!parent_domain) {
> -		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		pr_err("%pOF: unable to obtain parent domain\n", node);
>  		return -ENXIO;
>  	}
> 
>  	pmu_base_addr = of_iomap(node, 0);
> 
>  	if (!pmu_base_addr) {
> -		pr_err("%s: failed to find exynos pmu register\n",
> -		       node->full_name);
> +		pr_err("%pOF: failed to find exynos pmu register\n",
> +		       node);

This could be one line now. Can you merge it?

Beside that, for Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
