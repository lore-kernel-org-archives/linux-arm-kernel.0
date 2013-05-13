From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 14 May 2013 00:31:48 +0200
Subject: [PATCH 2/2] ARM: shmobile: lager: enable Ether
In-Reply-To: <1368173119-27345-3-git-send-email-horms+renesas@verge.net.au>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
 <1368173119-27345-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <18756824.MCbTJbYVOF@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Friday 10 May 2013 17:05:19 Simon Horman wrote:
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> This patch has a run-time dependency on "sh_eth: add support for r8a7790
> SoC". ---
>  arch/arm/boot/dts/r8a7790-lager.dts  |  2 +-
>  arch/arm/mach-shmobile/board-lager.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> b/arch/arm/boot/dts/r8a7790-lager.dts index 09a84fc..b2f61f0 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -16,7 +16,7 @@
>  	compatible = "renesas,lager", "renesas,r8a7790";
> 
>  	chosen {
> -		bootargs = "console=ttySC6,115200 ignore_loglevel";
> +		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs 
ip=dhcp
> nfsroot=,rsize=4096,wsize=4096 rw"; };
> 
>  	memory at 40000000 {
> diff --git a/arch/arm/mach-shmobile/board-lager.c
> b/arch/arm/mach-shmobile/board-lager.c index 6a1ba38..0b8112d 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -18,6 +18,7 @@
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA */
> 
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/kernel.h>
> @@ -52,6 +53,15 @@ static struct gpio_led_platform_data lager_leds_pdata = {
> .num_leds	= ARRAY_SIZE(lager_leds),
>  };
> 
> +/* Ether */
> +static struct sh_eth_plat_data ether_platdata = {
> +	.phy			= 0x1,
> +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
> +	.register_type		= SH_ETH_REG_FAST_RCAR,
> +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
> +	.ether_link_active_low	= 1,
> +};
> +
>  static const struct pinctrl_map lager_pinctrl_map[] = {
>  	/* SCIF0 (CN19: DEBUG SERIAL0) */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> @@ -59,6 +69,17 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
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
> @@ -73,6 +94,11 @@ static void __init lager_add_standard_devices(void)
>  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
>  				      &lager_leds_pdata,
>  				      sizeof(lager_leds_pdata));
> +
> +	/* Ether RESET */
> +	gpio_request_one(RCAR_GP_PIN(5, 31), GPIOF_OUT_INIT_HIGH, NULL);

Please don't touch GPIOs directly from board files. The reset GPIO number 
should be passed to the related device through platform data (and/or DT), and 
GPIO handling should be moved to the driver.

> +	r8a7790_add_ether_device(&ether_platdata);
>  }
> 
>  static const char *lager_boards_compat_dt[] __initdata = {
-- 
Regards,

Laurent Pinchart
