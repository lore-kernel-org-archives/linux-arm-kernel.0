From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Oct 2014 19:45:18 +0200
Subject: [PATCH v3 3/6] ARM: rockchip: add option to access the pmu via a
 phandle in smp_operations
In-Reply-To: <1412976370-14468-4-git-send-email-kever.yang@rock-chips.com>
References: <1412976370-14468-1-git-send-email-kever.yang@rock-chips.com>
 <1412976370-14468-4-git-send-email-kever.yang@rock-chips.com>
Message-ID: <3941764.AGbD0FWJxZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

again authorship please :-) .

Also my original patch did include a change to document the new rockchip,pmu 
property in Documentation/devicetree/bindings/arm/cpus.txt which should of 
course be again included here.


Heiko

Am Freitag, 10. Oktober 2014, 14:26:07 schrieb Kever Yang:
> Makes it possible to define a rockchip,pmu phandle in the cpus node directly
> referencing the pmu syscon instead of searching for specific compatible.
> 
> The old way of finding the pmu stays of course available.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - add this patch
> 
> Changes in v2: None
> 
>  arch/arm/mach-rockchip/platsmp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
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
