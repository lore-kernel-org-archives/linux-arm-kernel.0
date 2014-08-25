From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Aug 2014 10:26:32 -0700
Subject: [PATCH 3/3] pinctrl: single: AM437x: Add pinctrl compatibility
In-Reply-To: <1408716062-26055-4-git-send-email-nm@ti.com>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
 <1408716062-26055-4-git-send-email-nm@ti.com>
Message-ID: <20140825172632.GO17254@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140822 07:03]:
> From: Keerthy <j-keerthy@ti.com>
> 
> AM437x pinctrl definitions now differ from traditional 16 bit OMAP pin
> ctrl definitions, in that all 32 bits are used to describe a single pin
> 
> Also the location of wakeupenable and event bits have changed.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [nm at ti.com: minor updates]
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  .../bindings/pinctrl/ti,omap-pinctrl.txt           |    1 +
>  drivers/pinctrl/pinctrl-single.c                   |    7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> index d45386d..af225fe 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> @@ -6,5 +6,6 @@ Required properties:
>    "ti,omap4-padconf" - OMAP4 compatible pinctrl
>    "ti,omap5-padconf" - OMAP5 compatible pinctrl
>    "ti,dra7-padconf" - DRA7 compatible pinctrl
> +  "ti,am437-padconf" - AM437x compatible pinctrl
>  
>  See Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt for further details.
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 598d600..784de13 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1987,6 +1987,12 @@ static const struct pcs_soc_data pinctrl_single_dra7 = {
>  	.irq_status_mask = (1 << 25),	/* WAKEUPEVENT */
>  };
>  
> +static const struct pcs_soc_data pinctrl_single_am437x = {
> +	.flags = PCS_QUIRK_SHARED_IRQ,
> +	.irq_enable_mask = (1 << 29),   /* OMAP_WAKEUP_EN */
> +	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
> +};
> +
>  static const struct pcs_soc_data pinctrl_single = {
>  };
>  
> @@ -1999,6 +2005,7 @@ static struct of_device_id pcs_of_match[] = {
>  	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
>  	{ .compatible = "ti,dra7-padconf", .data = &pinctrl_single_dra7 },
> +	{ .compatible = "ti,am437-padconf", .data = &pinctrl_single_am437x },
>  	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
>  	{ .compatible = "pinconf-single", .data = &pinconf_single },
>  	{ },
> -- 
> 1.7.9.5
> 
