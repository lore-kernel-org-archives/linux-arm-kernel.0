From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 15 Mar 2011 09:35:24 +0100
Subject: [PATCH 1/1 v2] ARM: mx53_loco: Add GPIO Keypad support
In-Reply-To: <1300176915-16647-1-git-send-email-Frank.Li@freescale.com>
References: <1300176915-16647-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20110315083524.GB13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 04:15:15PM +0800, Frank Li wrote:
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
> 
> Replace space with tab.
> use imx_add_gpio_keys
> 
>  arch/arm/mach-mx5/Kconfig           |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |   26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 83ee088..159340d 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -165,6 +165,7 @@ config MACH_MX53_LOCO
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> +	select IMX_HAVE_PLATFORM_GPIO_KEYS
>  	help
>  	  Include support for MX53 LOCO platform. This includes specific
>  	  configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 0a18f8d..e4c2ddf 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,6 +23,7 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
You don't need that.
 
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -36,6 +37,9 @@
>  #include "crm_regs.h"
>  #include "devices-imx53.h"
>  
> +#define MX53_LOCO_POWER			IMX_GPIO_NR(1, 8)
> +#define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
> +#define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
You didn't choose to use VOLUMEUP (or similar) instead of UI1? Is this
the name in the schematic? Then it's OK for me.

>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
> @@ -180,6 +184,27 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	MX53_PAD_GPIO_8__GPIO1_8,
>  };
>  
> +#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
> +{								\
> +	.gpio		= gpio_num,				\
> +	.type		= EV_KEY,				\
> +	.code		= ev_code,				\
> +	.active_low	= act_low,				\
> +	.desc		= "btn " descr,				\
> +	.wakeup		= wake,					\
> +}
> +
> +static struct gpio_keys_button loco_buttons[] = {
> +	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 0),
> +	GPIO_BUTTON(MX53_LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
> +	GPIO_BUTTON(MX53_LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
> +};
> +
> +static struct gpio_keys_platform_data loco_button_data = {
> +	.buttons        = loco_buttons,
> +	.nbuttons       = ARRAY_SIZE(loco_buttons),
> +};
This can and should be const __initconst.  s/loco/mx53_loco/?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
