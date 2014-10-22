From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Oct 2014 17:00:29 +0200
Subject: [PATCH v5 2/6] ARM: rockchip: add option to access the pmu via a
 phandle in smp_operations
In-Reply-To: <1413393785-26783-3-git-send-email-kever.yang@rock-chips.com>
References: <1413393785-26783-1-git-send-email-kever.yang@rock-chips.com>
 <1413393785-26783-3-git-send-email-kever.yang@rock-chips.com>
Message-ID: <31425128.N5J4K0nt32@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Mittwoch, 15. Oktober 2014, 10:23:01 schrieb Kever Yang:
> From: Heiko Stuebner <heiko@sntech.de>
> 
> Makes it possible to define a rockchip,pmu phandle in the cpus node directly
> referencing the pmu syscon instead of searching for specific compatible.
> 
> The old way of finding the pmu stays of course available.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

I've tested the series again on all our supported platforms - no regressions.

The series itself also looks nice and ready to go to me, but I think we'll 
need to give the devicetree maintainers some more days, if they want to 
complain about our new rockchip,pmu property.


Heiko


> ---
> 
> Changes in v5: None
> Changes in v4:
> - add rockchip,pmu property into cpus.txt
> 
> Changes in v3:
> - add this patch
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/arm/cpus.txt |  9 +++++++++
>  arch/arm/mach-rockchip/platsmp.c               | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> b/Documentation/devicetree/bindings/arm/cpus.txt index fc44634..b2aacbe
> 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -227,6 +227,15 @@ nodes to be present and contain the properties
> described below. # List of phandles to idle state nodes supported
>  			  by this cpu [3].
> 
> +	- rockchip,pmu
> +		Usage: optional for systems that have an "enable-method"
> +		       property value of "rockchip,rk3066-smp"
> +		       While optional, it is the preferred way to get access to
> +		       the cpu-core power-domains.
> +		Value type: <phandle>
> +		Definition: Specifies the syscon node controlling the cpu core
> +			    power domains.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
> 
>  	cpus {
> diff --git a/arch/arm/mach-rockchip/platsmp.c
> b/arch/arm/mach-rockchip/platsmp.c index 4c36fbf..57b53b3 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -155,6 +155,19 @@ static int __init rockchip_smp_prepare_pmu(void)
>  	struct device_node *node;
>  	void __iomem *pmu_base;
> 
> +	/*
> +	 * This function is only called via smp_ops->smp_prepare_cpu().
> +	 * That only happens if a "/cpus" device tree node exists
> +	 * and has an "enable-method" property that selects the SMP
> +	 * operations defined herein.
> +	 */
> +	node = of_find_node_by_path("/cpus");
> +
> +	pmu = syscon_regmap_lookup_by_phandle(node, "rockchip,pmu");
> +	of_node_put(node);
> +	if (!IS_ERR(pmu))
> +		return 0;
> +
>  	pmu = syscon_regmap_lookup_by_compatible("rockchip,rk3066-pmu");
>  	if (!IS_ERR(pmu))
>  		return 0;
