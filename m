From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 19:03:08 -0500
Subject: [PATCH 2/6] dt-bindings: ti, omap-hsmmc: Add 66AK2G mmc controller
In-Reply-To: <20170801044119.16201-3-lokeshvutla@ti.com>
References: <20170801044119.16201-1-lokeshvutla@ti.com>
 <20170801044119.16201-3-lokeshvutla@ti.com>
Message-ID: <20170810000308.45bhcka2z4vk4yhm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:11:15AM +0530, Lokesh Vutla wrote:
> Update the ti,omap-hsmmc.txt to include information about
> 66AK2G specific mmc controller. Also cleanup the entries
> under optional properties to look a bit nicer.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      | 52 +++++++++++++++-------
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 0e026c151c1c..016741402e37 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -1,33 +1,55 @@
> -* TI Highspeed MMC host controller for OMAP
> +* TI Highspeed MMC host controller for OMAP and 66AK2G family.
>  
> -The Highspeed MMC Host Controller on TI OMAP family
> +The Highspeed MMC Host Controller on TI OMAP and 66AK2G family
>  provides an interface for MMC, SD, and SDIO types of memory cards.
>  
>  This file documents differences between the core properties described
>  by mmc.txt and the properties used by the omap_hsmmc driver.
>  
>  Required properties:
> +--------------------
>  - compatible:
>   Should be "ti,omap2-hsmmc", for OMAP2 controllers
>   Should be "ti,omap3-hsmmc", for OMAP3 controllers
>   Should be "ti,omap3-pre-es3-hsmmc" for OMAP3 controllers pre ES3.0
>   Should be "ti,omap4-hsmmc", for OMAP4 controllers
>   Should be "ti,am33xx-hsmmc", for AM335x controllers
> -- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
> + Should be "ti,k2g-hsmmc", "ti,omap4-hsmmc" for 66AK2G controllers.

Same comment here.

> +
> +SoC specific required properties:
> +---------------------------------
> +The following are mandatory properties for OMAPs, AM33xx and AM43xx SoCs only:
> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1.
> +
> +The following are mandatory properties for 66AK2G SoCs only:
> +- power-domains:Should contain a phandle to a PM domain provider node
> +		and an args specifier containing the MMC device id
> +		value. This property is as per the binding,
> +		Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +- clocks:	Must contain an entry for each entry in clock-names. Should
> +		be defined as per the he appropriate clock bindings consumer
> +		usage in Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> +- clock-names:	Shall be "fck" for the functional clock,
> +		and "mmchsdb_fck" for the debounce clock.
> +
>  
>  Optional properties:
> -ti,dual-volt: boolean, supports dual voltage cards
> -<supply-name>-supply: phandle to the regulator device tree node
> -"supply-name" examples are "vmmc", "vmmc_aux"(deprecated)/"vqmmc" etc
> -ti,non-removable: non-removable slot (like eMMC)
> -ti,needs-special-reset: Requires a special softreset sequence
> -ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
> -dmas: List of DMA specifiers with the controller specific format
> -as described in the generic DMA client binding. A tx and rx
> -specifier is required.
> -dma-names: List of DMA request names. These strings correspond
> -1:1 with the DMA specifiers listed in dmas. The string naming is
> -to be "rx" and "tx" for RX and TX DMA requests, respectively.
> +--------------------
> +- ti,dual-volt:		boolean, supports dual voltage cards
> +- <supply-name>-supply:	phandle to the regulator device tree node
> +			  "supply-name" examples are "vmmc",
> +			  "vmmc_aux"(deprecated)/"vqmmc" etc
> +- ti,non-removable:	non-removable slot (like eMMC)
> +- ti,needs-special-reset:	Requires a special softreset sequence
> +- ti,needs-special-hs-handling:	HSMMC IP needs special setting
> +				  for handling High Speed
> +- dmas:			List of DMA specifiers with the controller specific
> +			format as described in the generic DMA client
> +			binding. A tx and rx specifier is required.
> +- dma-names:		List of DMA request names. These strings correspond
> +			1:1 with the DMA specifiers listed in dmas.
> +			The string naming is to be "rx" and "tx" for
> +			RX and TX DMA requests, respectively.

Is there some change here or just reformatting? Please make reformatting 
a separate patch.

Rob
