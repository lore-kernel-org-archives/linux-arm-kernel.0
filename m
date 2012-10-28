From: josh.coombs@gmail.com (Josh Coombs)
Date: Sun, 28 Oct 2012 10:31:27 -0400
Subject: [PATCH 6/9] ARM: Kirkwood: Convert GoFlex Net to pinctrl.
In-Reply-To: <1351090434-30499-7-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-7-git-send-email-andrew@lunn.ch>
Message-ID: <CAMW5UfZ8WsBPUhXY0+dcODV+hiJbz6u-7k78Xon3yKCC5PVZvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Joshua Coombs <josh.coombs@gmail.com>

On Wed, Oct 24, 2012 at 10:53 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-goflexnet.dts |   57 ++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-goflexnet.c |   18 ----------
>  2 files changed, 57 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> index 7c8238f..46d16a2 100644
> --- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
> +++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> @@ -16,6 +16,63 @@
>         };
>
>         ocp at f1000000 {
> +               pinctrl: pinctrl at 10000 {
> +                       compatible = "marvell,88f6281-pinctrl";
> +                       reg = <0x10000 0x20>;
> +
> +                       pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
> +                                     &pmx_led_left_cap_0 &pmx_led_left_cap_1
> +                                     &pmx_led_left_cap_2 &pmx_led_left_cap_3
> +                                     &pmx_led_right_cap_0 &pmx_led_right_cap_1
> +                                     &pmx_led_right_cap_2 &pmx_led_right_cap_3
> +                                   >;
> +                       pinctrl-names = "default";
> +
> +                       pmx_usb_power_enable: pmx-usb-power-enable {
> +                               marvell,pins = "mpp29";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_right_cap_0: pmx-led_right_cap_0 {
> +                               marvell,pins = "mpp38";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_right_cap_1: pmx-led_right_cap_1 {
> +                               marvell,pins = "mpp39";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_right_cap_2: pmx-led_right_cap_2 {
> +                               marvell,pins = "mpp40";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_right_cap_3: pmx-led_right_cap_3 {
> +                               marvell,pins = "mpp41";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_left_cap_0: pmx-led_left_cap_0 {
> +                               marvell,pins = "mpp42";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_left_cap_1: pmx-led_left_cap_1 {
> +                               marvell,pins = "mpp43";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_left_cap_2: pmx-led_left_cap_2 {
> +                               marvell,pins = "mpp44";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_left_cap_3: pmx-led_left_cap_3 {
> +                               marvell,pins = "mpp45";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_green: pmx-led_green {
> +                               marvell,pins = "mpp46";
> +                               marvell,function = "gpio";
> +                       };
> +                       pmx_led_orange: pmx-led_orange {
> +                               marvell,pins = "mpp47";
> +                               marvell,function = "gpio";
> +                       };
> +               };
>                 serial at 12000 {
>                         clock-frequency = <200000000>;
>                         status = "ok";
> diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
> index 001ca8c..9643f4b 100644
> --- a/arch/arm/mach-kirkwood/board-goflexnet.c
> +++ b/arch/arm/mach-kirkwood/board-goflexnet.c
> @@ -34,34 +34,16 @@
>  #include <mach/bridge-regs.h>
>  #include <linux/platform_data/mmc-mvsdio.h>
>  #include "common.h"
> -#include "mpp.h"
>
>  static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
>         .phy_addr       = MV643XX_ETH_PHY_ADDR(0),
>  };
>
> -static unsigned int goflexnet_mpp_config[] __initdata = {
> -       MPP29_GPIO,     /* USB Power Enable */
> -       MPP47_GPIO,     /* LED Orange */
> -       MPP46_GPIO,     /* LED Green */
> -       MPP45_GPIO,     /* LED Left Capacity 3 */
> -       MPP44_GPIO,     /* LED Left Capacity 2 */
> -       MPP43_GPIO,     /* LED Left Capacity 1 */
> -       MPP42_GPIO,     /* LED Left Capacity 0 */
> -       MPP41_GPIO,     /* LED Right Capacity 3 */
> -       MPP40_GPIO,     /* LED Right Capacity 2 */
> -       MPP39_GPIO,     /* LED Right Capacity 1 */
> -       MPP38_GPIO,     /* LED Right Capacity 0 */
> -       0
> -};
> -
>  void __init goflexnet_init(void)
>  {
>         /*
>          * Basic setup. Needs to be called early.
>          */
> -       kirkwood_mpp_conf(goflexnet_mpp_config);
> -
>         if (gpio_request(29, "USB Power Enable") != 0 ||
>             gpio_direction_output(29, 1) != 0)
>                 pr_err("can't setup GPIO 29 (USB Power Enable)\n");
> --
> 1.7.10.4
>
