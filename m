From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 16:18:48 +0900
Subject: [PATCH v3 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <1372652755-16948-3-git-send-email-horms+renesas@verge.net.au>
References: <1372652755-16948-1-git-send-email-horms+renesas@verge.net.au>
 <1372652755-16948-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130701071848.GT14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 01:25:54PM +0900, Simon Horman wrote:
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> This patch has a build-time dependency on "sh_eth: add support for gpio reset".
> This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".
> 
> v3
> * Rebase
> 
> v2
> * As suggested by Laurent Pinchart
>   - Do not manipilate sh_eth reset GPIO directly,
>     rather, do so through newly proposed support for this in
>     the sh_eth driver.
> * A suggested by Sergei Shtylyov
>   - Move DTS portion into a separate patch
> ---
>  arch/arm/mach-shmobile/board-lager.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 0b4a1f9..4fecaf6 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -71,6 +71,17 @@ static __initdata struct gpio_keys_platform_data lager_keys_pdata = {
>  	.nbuttons	= ARRAY_SIZE(gpio_buttons),
>  };
>  
> +/* Ether */
> +static struct sh_eth_plat_data ether_platdata = {

This should be annotated as __initdata, I will re-post.

> +	.phy			= 0x1,
> +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> +	.register_type		= SH_ETH_REG_FAST_RCAR,
> +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
> +	.ether_link_active_low	= 1,
> +	.needs_gpio_reset	= 1,
> +	.reset_gpio		= RCAR_GP_PIN(5, 31),
> +};
> +
>  static const struct pinctrl_map lager_pinctrl_map[] = {
>  	/* SCIF0 (CN19: DEBUG SERIAL0) */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> @@ -78,6 +89,17 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
>  	/* SCIF1 (CN20: DEBUG SERIAL1) */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
>  				  "scif1_data", "scif1"),
> +	/* Ether */
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> +				  "eth_link", "eth"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> +				  "eth_magic", "eth"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> +				  "eth_mdio", "eth"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> +				  "eth_rmii", "eth"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> +				  "intc_irq0", "intc"),
>  };
>  
>  static void __init lager_add_standard_devices(void)
> @@ -89,6 +111,8 @@ static void __init lager_add_standard_devices(void)
>  	r8a7790_pinmux_init();
>  
>  	r8a7790_add_standard_devices();
> +	r8a7790_add_ether_device(&ether_platdata);
> +
>  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
>  				      &lager_leds_pdata,
>  				      sizeof(lager_leds_pdata));
> -- 
> 1.8.2.1
> 
