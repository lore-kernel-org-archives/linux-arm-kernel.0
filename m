From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 15 Mar 2011 07:14:00 +0100
Subject: [PATCH 1/1] ARM: mx53_loco: Add GPIO Keypad support
In-Reply-To: <1300157900-21171-1-git-send-email-Frank.Li@freescale.com>
References: <1300157900-21171-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20110315061400.GA13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Tue, Mar 15, 2011 at 10:58:20AM +0800, Frank Li wrote:
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   44 +++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 0a18f8d..4f948bb 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,6 +23,7 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -36,6 +37,9 @@
>  #include "crm_regs.h"
>  #include "devices-imx53.h"
>  
> +#define LOCO_NONKEY			IMX_GPIO_NR(1, 8)
> +#define LOCO_UI1			IMX_GPIO_NR(2, 14)
> +#define LOCO_UI2			IMX_GPIO_NR(2, 15)
>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
> @@ -180,6 +184,45 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	MX53_PAD_GPIO_8__GPIO1_8,
>  };
>  
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
I prefer to register devices unconditionally.

> +#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)    \
> +{                                                               \
> +        .gpio           = gpio_num,                             \
Please use tabs consistently for indention.

> +	.type           = EV_KEY,                               \
> +	.code           = ev_code,                              \
> +	.active_low     = act_low,                              \
> +	.desc           = "btn " descr,                         \
> +	.wakeup         = wake,                                 \
> +}
> +
> +static struct gpio_keys_button loco_buttons[] = {
> +	GPIO_BUTTON(LOCO_NONKEY, KEY_POWER, 1, "power", 0),
> +	GPIO_BUTTON(LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
> +	GPIO_BUTTON(LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
I wonder about the names of your #defines. Why don't you use LOCO_POWER,
LOCO_VOLUMEUP etc?  Or for consistency better use MX53_LOCO_POWER etc.?
(Ditto for the other names introduced.)

> +};
> +
> +static struct gpio_keys_platform_data loco_button_data = {
> +	.buttons        = loco_buttons,
> +	.nbuttons       = ARRAY_SIZE(loco_buttons),
> +};
> +
> +static struct platform_device loco_button_device = {
> +	.name           = "gpio-keys",
> +	.id             = -1,
> +	.num_resources  = 0,
> +	.dev            = {
> +		.platform_data = &loco_button_data,
> +	}
> +};
There is a function imx_add_gpio_keys that you should use instead of
providing a local platform_device.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
