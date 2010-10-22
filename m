From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 22 Oct 2010 20:51:55 +0300
Subject: [PATCHv5 1/3] ARM: mx5: Add gpio-keys to mx51 babbage board
In-Reply-To: <1287766575-4092-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287766575-4092-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101022175155.GH17631@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the interest of bisectability, Patch 1 and 2 should've been reversed since
imx51_add_gpio_keys() is only defined in patch 2.

On 10 Oct 22, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Add functionality for the power button on MX51 Babbage board.
> 
> This patch is based on Sascha Hauer's imx/linux-2.6 for-rmk tree.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/configs/mx51_defconfig        |    1 +
>  arch/arm/mach-mx5/board-mx51_babbage.c |   22 ++++++++++++++++++++++
>  arch/arm/mach-mx5/devices-imx51.h      |    2 ++
>  3 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
> index 163cfee..5c7a872 100644
> --- a/arch/arm/configs/mx51_defconfig
> +++ b/arch/arm/configs/mx51_defconfig
> @@ -82,6 +82,7 @@ CONFIG_FEC=y
>  CONFIG_INPUT_FF_MEMLESS=m
>  # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_GPIO=y
>  CONFIG_INPUT_EVBUG=m
>  CONFIG_MOUSE_PS2=m
>  CONFIG_MOUSE_PS2_ELANTECH=y
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 23ee4a4..8458852 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -18,6 +18,8 @@
>  #include <linux/io.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/fec.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -37,6 +39,7 @@
>  #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
>  #define BABBAGE_PHY_RESET	(1*32 + 5)	/* GPIO_2_5 */
>  #define BABBAGE_FEC_PHY_RESET	(1*32 + 14)	/* GPIO_2_14 */
> +#define BABBAGE_POWER_KEY	(1*32 + 21)	/* GPIO_2_21 */
>  
>  /* USB_CTRL_1 */
>  #define MX51_USB_CTRL_1_OFFSET			0x10
> @@ -46,6 +49,21 @@
>  #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
>  #define	MX51_USB_PLL_DIV_24_MHZ	0x02
>  
> +static struct gpio_keys_button babbage_buttons[] = {
> +	{
> +		.gpio		= BABBAGE_POWER_KEY,
> +		.code		= BTN_0,
> +		.desc		= "PWR",
> +		.active_low	= 1,
> +		.wakeup		= 1,
> +	},
> +};
> +
> +static const struct gpio_keys_platform_data imx_button_data __initconst = {
> +	.buttons	= babbage_buttons,
> +	.nbuttons	= ARRAY_SIZE(babbage_buttons),
> +};
> +
>  static struct pad_desc mx51babbage_pads[] = {
>  	/* UART1 */
>  	MX51_PAD_UART1_RXD__UART1_RXD,
> @@ -112,6 +130,9 @@ static struct pad_desc mx51babbage_pads[] = {
>  
>  	/* FEC PHY reset line */
>  	MX51_PAD_EIM_A20__GPIO_2_14,
> +
> +	/* Power Key */
> +	MX51_PAD_EIM_A27__GPIO_2_21,
>  };
>  
>  /* Serial ports */
> @@ -287,6 +308,7 @@ static void __init mxc_board_init(void)
>  	mxc_init_imx_uart();
>  	babbage_fec_reset();
>  	imx51_add_fec(NULL);
> +	imx51_add_gpio_keys(&imx_button_data);
>  
>  	imx51_add_imx_i2c(0, &babbage_i2c_data);
>  	imx51_add_imx_i2c(1, &babbage_i2c_data);
> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
> index 5cc910e..8c50cb5 100644
> --- a/arch/arm/mach-mx5/devices-imx51.h
> +++ b/arch/arm/mach-mx5/devices-imx51.h
> @@ -13,6 +13,8 @@ extern const struct imx_fec_data imx51_fec_data __initconst;
>  #define imx51_add_fec(pdata)	\
>  	imx_add_fec(&imx51_fec_data, pdata)
>  
> +#define imx51_add_gpio_keys(pdata) imx_add_gpio_keys(pdata)
> +
>  extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
>  #define imx51_add_imx_i2c(id, pdata)	\
>  	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
> -- 
> 1.6.0.4
> 
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
