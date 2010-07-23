From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Jul 2010 12:50:18 +0200
Subject: [PATCH v3 1/2] eukrea_mbimxsd: factorize motherboard support
In-Reply-To: <1279816734-26094-1-git-send-email-eric@eukrea.com>
References: <1279816734-26094-1-git-send-email-eric@eukrea.com>
Message-ID: <20100723105018.GP14113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Thu, Jul 22, 2010 at 06:38:53PM +0200, Eric B?nard wrote:
> This motherboard is used for both an i.MX25 and an i.MX35 machines
> so we can have only one file to support it in plat-mxc.
> 
> This also fixes the following KConfig warning:
> "arch/arm/mach-mx25/Kconfig:18:warning: choice value used outside its
> choice group"

Reading this patch more closely I don't think this patch is a step
forward. Of course it's always a good idea to share common code instead
of duplicating it, but to me it seems that baseboard support for i.MX35
and i.MX25 do not share much code. The main thing that's common is the
description of the display, but the devices are different, the platform
data is different and the iomux setup is different aswell. The
#include <../mach-mx*/ looks quite ugly. How about splitting the really
common part (display description, more?) to third file and leaving the
basboard files where they are?
The Kconfig warning could be fixed by prefixing the baseboard variable
with MX?5_ or by just moving the option to plat-mxc like you already did
in this patch.

Sascha

> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v3 : added comment avoir Kconfig's warning and changed define name in .h
> 	as per Uwe's comments
> v2 : rebased against last imx-for-2.6.36 branch
>  arch/arm/mach-mx25/Kconfig                         |   14 -
>  arch/arm/mach-mx25/Makefile                        |    1 -
>  arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |  261 --------------------
>  arch/arm/mach-mx25/mach-cpuimx25.c                 |    2 +-
>  arch/arm/mach-mx3/Kconfig                          |   14 -
>  arch/arm/mach-mx3/Makefile                         |    1 -
>  arch/arm/mach-mx3/mach-cpuimx35.c                  |    2 +-
>  arch/arm/plat-mxc/Kconfig                          |    8 +
>  arch/arm/plat-mxc/Makefile                         |    1 +
>  .../eukrea_mbimxsd-baseboard.c                     |  184 +++++++++++---
>  .../plat-mxc/include/mach/board-eukrea_cpuimx35.h  |   40 ---
>  ...d-eukrea_cpuimx25.h => board-eukrea_cpuimxsd.h} |   10 +-
>  12 files changed, 163 insertions(+), 375 deletions(-)
>  delete mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
>  rename arch/arm/{mach-mx3 => plat-mxc}/eukrea_mbimxsd-baseboard.c (69%)
>  delete mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
>  rename arch/arm/plat-mxc/include/mach/{board-eukrea_cpuimx25.h => board-eukrea_cpuimxsd.h} (84%)
> 
> diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
> index 67e0b54..5f72318 100644
> --- a/arch/arm/mach-mx25/Kconfig
> +++ b/arch/arm/mach-mx25/Kconfig
> @@ -14,18 +14,4 @@ config MACH_EUKREA_CPUIMX25
>  	select IMX_HAVE_PLATFORM_MXC_NAND
>  	select MXC_ULPI if USB_ULPI
>  
> -choice
> -	prompt "Baseboard"
> -	depends on MACH_EUKREA_CPUIMX25
> -	default MACH_EUKREA_MBIMXSD_BASEBOARD
> -
> -config MACH_EUKREA_MBIMXSD_BASEBOARD
> -	prompt "Eukrea MBIMXSD development board"
> -	bool
> -	help
> -	  This adds board specific devices that can be found on Eukrea's
> -	  MBIMXSD evaluation board.
> -
> -endchoice
> -
>  endif
> diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
> index 87ffb9c..6ba07b6 100644
> --- a/arch/arm/mach-mx25/Makefile
> +++ b/arch/arm/mach-mx25/Makefile
> @@ -2,4 +2,3 @@ obj-y				:= mm.o devices.o
>  obj-$(CONFIG_ARCH_MX25)		+= clock.o
>  obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
> -obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
> diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
> deleted file mode 100644
> index f07b1f9..0000000
> --- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
> +++ /dev/null
> @@ -1,261 +0,0 @@
> -/*
> - * Copyright (C) 2010 Eric Benard - eric at eukrea.com
> - *
> - * Based on pcm970-baseboard.c which is :
> - * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> - * MA 02110-1301, USA.
> - */
> -
> -#include <linux/gpio.h>
> -#include <linux/leds.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <video/platform_lcd.h>
> -
> -#include <mach/board-eukrea_cpuimx25.h>
> -#include <mach/hardware.h>
> -#include <mach/iomux-mx25.h>
> -#include <mach/common.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <mach/mx25.h>
> -#include <mach/imx-uart.h>
> -#include <mach/imxfb.h>
> -#include <mach/ssi.h>
> -#include <mach/audmux.h>
> -
> -#include "devices-imx25.h"
> -#include "devices.h"
> -
> -static struct pad_desc eukrea_mbimxsd_pads[] = {
> -	/* LCD */
> -	MX25_PAD_LD0__LD0,
> -	MX25_PAD_LD1__LD1,
> -	MX25_PAD_LD2__LD2,
> -	MX25_PAD_LD3__LD3,
> -	MX25_PAD_LD4__LD4,
> -	MX25_PAD_LD5__LD5,
> -	MX25_PAD_LD6__LD6,
> -	MX25_PAD_LD7__LD7,
> -	MX25_PAD_LD8__LD8,
> -	MX25_PAD_LD9__LD9,
> -	MX25_PAD_LD10__LD10,
> -	MX25_PAD_LD11__LD11,
> -	MX25_PAD_LD12__LD12,
> -	MX25_PAD_LD13__LD13,
> -	MX25_PAD_LD14__LD14,
> -	MX25_PAD_LD15__LD15,
> -	MX25_PAD_GPIO_E__LD16,
> -	MX25_PAD_GPIO_F__LD17,
> -	MX25_PAD_HSYNC__HSYNC,
> -	MX25_PAD_VSYNC__VSYNC,
> -	MX25_PAD_LSCLK__LSCLK,
> -	MX25_PAD_OE_ACD__OE_ACD,
> -	MX25_PAD_CONTRAST__CONTRAST,
> -	/* LCD_PWR */
> -	MX25_PAD_PWM__GPIO_1_26,
> -	/* LED */
> -	MX25_PAD_POWER_FAIL__GPIO_3_19,
> -	/* SWITCH */
> -	MX25_PAD_VSTBY_ACK__GPIO_3_18,
> -	/* UART2 */
> -	MX25_PAD_UART2_RTS__UART2_RTS,
> -	MX25_PAD_UART2_CTS__UART2_CTS,
> -	MX25_PAD_UART2_TXD__UART2_TXD,
> -	MX25_PAD_UART2_RXD__UART2_RXD,
> -	/* SD1 */
> -	MX25_PAD_SD1_CMD__SD1_CMD,
> -	MX25_PAD_SD1_CLK__SD1_CLK,
> -	MX25_PAD_SD1_DATA0__SD1_DATA0,
> -	MX25_PAD_SD1_DATA1__SD1_DATA1,
> -	MX25_PAD_SD1_DATA2__SD1_DATA2,
> -	MX25_PAD_SD1_DATA3__SD1_DATA3,
> -	/* SD1 CD */
> -	MX25_PAD_DE_B__GPIO_2_20,
> -	/* I2S */
> -	MX25_PAD_KPP_COL3__AUD5_TXFS,
> -	MX25_PAD_KPP_COL2__AUD5_TXC,
> -	MX25_PAD_KPP_COL1__AUD5_RXD,
> -	MX25_PAD_KPP_COL0__AUD5_TXD,
> -};
> -
> -#define GPIO_LED1	83
> -#define GPIO_SWITCH1	82
> -#define GPIO_SD1CD	52
> -#define GPIO_LCDPWR	26
> -
> -static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
> -	{
> -		.mode	= {
> -			.name		= "CMO-QVGA",
> -			.refresh	= 60,
> -			.xres		= 320,
> -			.yres		= 240,
> -			.pixclock	= KHZ2PICOS(6500),
> -			.left_margin	= 30,
> -			.right_margin	= 38,
> -			.upper_margin	= 20,
> -			.lower_margin	= 3,
> -			.hsync_len	= 15,
> -			.vsync_len	= 4,
> -		},
> -		.bpp	= 16,
> -		.pcr	= 0xCAD08B80,
> -	},
> -};
> -
> -static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
> -	.mode		= eukrea_mximxsd_modes,
> -	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
> -	.pwmr		= 0x00A903FF,
> -	.lscr1		= 0x00120300,
> -	.dmacr		= 0x00040060,
> -};
> -
> -static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
> -				   unsigned int power)
> -{
> -	if (power)
> -		gpio_direction_output(GPIO_LCDPWR, 1);
> -	else
> -		gpio_direction_output(GPIO_LCDPWR, 0);
> -}
> -
> -static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
> -	.set_power		= eukrea_mbimxsd_lcd_power_set,
> -};
> -
> -static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
> -	.name			= "platform-lcd",
> -	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
> -};
> -
> -static struct gpio_led eukrea_mbimxsd_leds[] = {
> -	{
> -		.name			= "led1",
> -		.default_trigger	= "heartbeat",
> -		.active_low		= 1,
> -		.gpio			= GPIO_LED1,
> -	},
> -};
> -
> -static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
> -	.leds		= eukrea_mbimxsd_leds,
> -	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
> -};
> -
> -static struct platform_device eukrea_mbimxsd_leds_gpio = {
> -	.name	= "leds-gpio",
> -	.id	= -1,
> -	.dev	= {
> -		.platform_data	= &eukrea_mbimxsd_led_info,
> -	},
> -};
> -
> -static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
> -	{
> -		.gpio		= GPIO_SWITCH1,
> -		.code		= BTN_0,
> -		.desc		= "BP1",
> -		.active_low	= 1,
> -		.wakeup		= 1,
> -	},
> -};
> -
> -static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
> -	.buttons	= eukrea_mbimxsd_gpio_buttons,
> -	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
> -};
> -
> -static struct platform_device eukrea_mbimxsd_button_device = {
> -	.name		= "gpio-keys",
> -	.id		= -1,
> -	.num_resources	= 0,
> -	.dev		= {
> -		.platform_data	= &eukrea_mbimxsd_button_data,
> -	}
> -};
> -
> -static struct platform_device *platform_devices[] __initdata = {
> -	&eukrea_mbimxsd_leds_gpio,
> -	&eukrea_mbimxsd_button_device,
> -	&eukrea_mbimxsd_lcd_powerdev,
> -};
> -
> -static const struct imxuart_platform_data uart_pdata __initconst = {
> -	.flags = IMXUART_HAVE_RTSCTS,
> -};
> -
> -static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
> -	{
> -		I2C_BOARD_INFO("tlv320aic23", 0x1a),
> -	},
> -};
> -
> -struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
> -	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
> -};
> -
> -/*
> - * system init for baseboard usage. Will be called by cpuimx25 init.
> - *
> - * Add platform devices present on this baseboard and init
> - * them from CPU side as far as required to use them later on
> - */
> -void __init eukrea_mbimxsd_baseboard_init(void)
> -{
> -	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
> -			ARRAY_SIZE(eukrea_mbimxsd_pads)))
> -		printk(KERN_ERR "error setting mbimxsd pads !\n");
> -
> -#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
> -	/* SSI unit master I2S codec connected to SSI_AUD5*/
> -	mxc_audmux_v2_configure_port(0,
> -			MXC_AUDMUX_V2_PTCR_SYN |
> -			MXC_AUDMUX_V2_PTCR_TFSDIR |
> -			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
> -			MXC_AUDMUX_V2_PTCR_TCLKDIR |
> -			MXC_AUDMUX_V2_PTCR_TCSEL(4),
> -			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
> -	);
> -	mxc_audmux_v2_configure_port(4,
> -			MXC_AUDMUX_V2_PTCR_SYN,
> -			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
> -	);
> -#endif
> -
> -	imx25_add_imx_uart1(&uart_pdata);
> -	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
> -	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
> -
> -	gpio_request(GPIO_LED1, "LED1");
> -	gpio_direction_output(GPIO_LED1, 1);
> -	gpio_free(GPIO_LED1);
> -
> -	gpio_request(GPIO_SWITCH1, "SWITCH1");
> -	gpio_direction_input(GPIO_SWITCH1);
> -	gpio_free(GPIO_SWITCH1);
> -
> -	gpio_request(GPIO_LCDPWR, "LCDPWR");
> -	gpio_direction_output(GPIO_LCDPWR, 1);
> -	gpio_free(GPIO_SWITCH1);
> -
> -	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
> -				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
> -
> -	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
> -}
> diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
> index d39f9cc..526928f 100644
> --- a/arch/arm/mach-mx25/mach-cpuimx25.c
> +++ b/arch/arm/mach-mx25/mach-cpuimx25.c
> @@ -29,7 +29,7 @@
>  #include <linux/usb/ulpi.h>
>  #include <linux/fsl_devices.h>
>  
> -#include <mach/board-eukrea_cpuimx25.h>
> +#include <mach/board-eukrea_cpuimxsd.h>
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index e063657..68b841e 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -163,18 +163,4 @@ config MACH_EUKREA_CPUIMX35
>  	  Include support for Eukrea CPUIMX35 platform. This includes
>  	  specific configurations for the board and its peripherals.
>  
> -choice
> -	prompt "Baseboard"
> -	depends on MACH_EUKREA_CPUIMX35
> -	default MACH_EUKREA_MBIMXSD_BASEBOARD
> -
> -config MACH_EUKREA_MBIMXSD_BASEBOARD
> -	prompt "Eukrea MBIMXSD development board"
> -	bool
> -	help
> -	  This adds board specific devices that can be found on Eukrea's
> -	  MBIMXSD evaluation board.
> -
> -endchoice
> -
>  endif
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index 54bc935..28fa1f2 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -25,4 +25,3 @@ obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
>  obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
>  obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
> -obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
> diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
> index 4f6146d..a7ecd7b 100644
> --- a/arch/arm/mach-mx3/mach-cpuimx35.c
> +++ b/arch/arm/mach-mx3/mach-cpuimx35.c
> @@ -37,7 +37,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/mach/map.h>
>  
> -#include <mach/board-eukrea_cpuimx35.h>
> +#include <mach/board-eukrea_cpuimxsd.h>
>  #include <mach/hardware.h>
>  #include <mach/common.h>
>  #include <mach/iomux-mx35.h>
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 0527e65..26708b0 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -91,6 +91,14 @@ config MXC_DEBUG_BOARD
>  	  data/address de-multiplexing and decode, signal level shift,
>  	  interrupt control and various board functions.
>  
> +config MACH_EUKREA_MBIMXSD_BASEBOARD
> +	prompt "Eukrea MBIMXSD development board"
> +	depends on MACH_EUKREA_CPUIMX25 || MACH_EUKREA_CPUIMX35
> +	bool
> +	help
> +	  This adds board specific devices that can be found on Eukrea's
> +	  MBIMXSD evaluation board.
> +
>  config MXC_ULPI
>  	bool
>  
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 78d405e..2d31132 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> +obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
>  ifdef CONFIG_SND_IMX_SOC
>  obj-y += ssi-fiq.o
>  obj-y += ssi-fiq-ksym.o
> diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
> similarity index 69%
> rename from arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> rename to arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
> index 368a603..57e8e7b 100644
> --- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
> @@ -36,49 +36,119 @@
>  #include <asm/mach/time.h>
>  #include <asm/mach/map.h>
>  
> -#include <mach/board-eukrea_cpuimx35.h>
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> -#include <mach/imx-uart.h>
> +#include <mach/board-eukrea_cpuimxsd.h>
> +
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
> +#include <mach/iomux-mx25.h>
> +#include <mach/mx25.h>
> +#include <mach/imxfb.h>
> +#include "../mach-mx25/devices-imx25.h"
> +#include "../mach-mx25/devices.h"
> +#endif
> +
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
>  #include <mach/iomux-mx35.h>
>  #include <mach/ipu.h>
>  #include <mach/mx3fb.h>
> -#include <mach/audmux.h>
> +#include "../mach-mx3/devices-imx35.h"
> +#include "../mach-mx3/devices.h"
> +#endif
> +
> +#include <mach/imx-uart.h>
>  #include <mach/ssi.h>
> +#include <mach/audmux.h>
>  
> -#include "devices-imx35.h"
> -#include "devices.h"
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
> +static struct pad_desc eukrea_mbimxsd_pads[] = {
> +	/* LCD */
> +	MX25_PAD_LD0__LD0,
> +	MX25_PAD_LD1__LD1,
> +	MX25_PAD_LD2__LD2,
> +	MX25_PAD_LD3__LD3,
> +	MX25_PAD_LD4__LD4,
> +	MX25_PAD_LD5__LD5,
> +	MX25_PAD_LD6__LD6,
> +	MX25_PAD_LD7__LD7,
> +	MX25_PAD_LD8__LD8,
> +	MX25_PAD_LD9__LD9,
> +	MX25_PAD_LD10__LD10,
> +	MX25_PAD_LD11__LD11,
> +	MX25_PAD_LD12__LD12,
> +	MX25_PAD_LD13__LD13,
> +	MX25_PAD_LD14__LD14,
> +	MX25_PAD_LD15__LD15,
> +	MX25_PAD_GPIO_E__LD16,
> +	MX25_PAD_GPIO_F__LD17,
> +	MX25_PAD_HSYNC__HSYNC,
> +	MX25_PAD_VSYNC__VSYNC,
> +	MX25_PAD_LSCLK__LSCLK,
> +	MX25_PAD_OE_ACD__OE_ACD,
> +	MX25_PAD_CONTRAST__CONTRAST,
> +	/* LCD_PWR */
> +	MX25_PAD_PWM__GPIO_1_26,
> +	/* LED */
> +	MX25_PAD_POWER_FAIL__GPIO_3_19,
> +	/* SWITCH */
> +	MX25_PAD_VSTBY_ACK__GPIO_3_18,
> +	/* UART2 */
> +	MX25_PAD_UART2_RTS__UART2_RTS,
> +	MX25_PAD_UART2_CTS__UART2_CTS,
> +	MX25_PAD_UART2_TXD__UART2_TXD,
> +	MX25_PAD_UART2_RXD__UART2_RXD,
> +	/* SD1 */
> +	MX25_PAD_SD1_CMD__SD1_CMD,
> +	MX25_PAD_SD1_CLK__SD1_CLK,
> +	MX25_PAD_SD1_DATA0__SD1_DATA0,
> +	MX25_PAD_SD1_DATA1__SD1_DATA1,
> +	MX25_PAD_SD1_DATA2__SD1_DATA2,
> +	MX25_PAD_SD1_DATA3__SD1_DATA3,
> +	/* SD1 CD */
> +	MX25_PAD_DE_B__GPIO_2_20,
> +	/* I2S */
> +	MX25_PAD_KPP_COL3__AUD5_TXFS,
> +	MX25_PAD_KPP_COL2__AUD5_TXC,
> +	MX25_PAD_KPP_COL1__AUD5_RXD,
> +	MX25_PAD_KPP_COL0__AUD5_TXD,
> +};
>  
> -static const struct fb_videomode fb_modedb[] = {
> +#define GPIO_LED1	83
> +#define GPIO_SWITCH1	82
> +#define GPIO_SD1CD	52
> +#define GPIO_LCDPWR	26
> +#define SSI_PORT	4
> +
> +static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
>  	{
> -		.name		= "CMO_QVGA",
> -		.refresh	= 60,
> -		.xres		= 320,
> -		.yres		= 240,
> -		.pixclock	= KHZ2PICOS(6500),
> -		.left_margin	= 68,
> -		.right_margin	= 20,
> -		.upper_margin	= 15,
> -		.lower_margin	= 4,
> -		.hsync_len	= 30,
> -		.vsync_len	= 3,
> -		.sync		= 0,
> -		.vmode		= FB_VMODE_NONINTERLACED,
> -		.flag		= 0,
> +		.mode	= {
> +			.name		= "CMO-QVGA",
> +			.refresh	= 60,
> +			.xres		= 320,
> +			.yres		= 240,
> +			.pixclock	= KHZ2PICOS(6500),
> +			.left_margin	= 30,
> +			.right_margin	= 38,
> +			.upper_margin	= 20,
> +			.lower_margin	= 3,
> +			.hsync_len	= 15,
> +			.vsync_len	= 4,
> +		},
> +		.bpp	= 16,
> +		.pcr	= 0xCAD08B80,
>  	},
>  };
>  
> -static struct ipu_platform_data mx3_ipu_data = {
> -	.irq_base = MXC_IPU_IRQ_START,
> -};
> -
> -static struct mx3fb_platform_data mx3fb_pdata = {
> -	.dma_dev	= &mx3_ipu.dev,
> -	.name		= "CMO_QVGA",
> -	.mode		= fb_modedb,
> -	.num_modes	= ARRAY_SIZE(fb_modedb),
> +static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
> +	.mode		= eukrea_mximxsd_modes,
> +	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
> +	.pwmr		= 0x00A903FF,
> +	.lscr1		= 0x00120300,
> +	.dmacr		= 0x00040060,
>  };
> +#endif
>  
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
>  static struct pad_desc eukrea_mbimxsd_pads[] = {
>  	/* LCD */
>  	MX35_PAD_LD0__IPU_DISPB_DAT_0,
> @@ -126,6 +196,38 @@ static struct pad_desc eukrea_mbimxsd_pads[] = {
>  #define GPIO_LED1	(2 * 32 + 29)
>  #define GPIO_SWITCH1	(2 * 32 + 25)
>  #define GPIO_LCDPWR	(4)
> +#define SSI_PORT	(3)
> +
> +static const struct fb_videomode fb_modedb[] = {
> +	{
> +		.name		= "CMO_QVGA",
> +		.refresh	= 60,
> +		.xres		= 320,
> +		.yres		= 240,
> +		.pixclock	= KHZ2PICOS(6500),
> +		.left_margin	= 68,
> +		.right_margin	= 20,
> +		.upper_margin	= 15,
> +		.lower_margin	= 4,
> +		.hsync_len	= 30,
> +		.vsync_len	= 3,
> +		.sync		= 0,
> +		.vmode		= FB_VMODE_NONINTERLACED,
> +		.flag		= 0,
> +	},
> +};
> +
> +static struct ipu_platform_data mx3_ipu_data = {
> +	.irq_base = MXC_IPU_IRQ_START,
> +};
> +
> +static struct mx3fb_platform_data mx3fb_pdata = {
> +	.dma_dev	= &mx3_ipu.dev,
> +	.name		= "CMO_QVGA",
> +	.mode		= fb_modedb,
> +	.num_modes	= ARRAY_SIZE(fb_modedb),
> +};
> +#endif
>  
>  static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
>  				   unsigned int power)
> @@ -207,12 +309,14 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
>  	},
>  };
>  
> +#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
>  struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
>  	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
>  };
> +#endif
>  
>  /*
> - * system init for baseboard usage. Will be called by cpuimx35 init.
> + * system init for baseboard usage. Will be called by cpuimxX5 init.
>   *
>   * Add platform devices present on this baseboard and init
>   * them from CPU side as far as required to use them later on
> @@ -224,26 +328,32 @@ void __init eukrea_mbimxsd_baseboard_init(void)
>  		printk(KERN_ERR "error setting mbimxsd pads !\n");
>  
>  #if defined(CONFIG_SND_SOC_EUKREA_TLV320)
> -	/* SSI unit master I2S codec connected to SSI_AUD4 */
> +	/* SSI unit master I2S codec connected to SSI_AUD */
>  	mxc_audmux_v2_configure_port(0,
>  			MXC_AUDMUX_V2_PTCR_SYN |
>  			MXC_AUDMUX_V2_PTCR_TFSDIR |
> -			MXC_AUDMUX_V2_PTCR_TFSEL(3) |
> +			MXC_AUDMUX_V2_PTCR_TFSEL(SSI_PORT) |
>  			MXC_AUDMUX_V2_PTCR_TCLKDIR |
> -			MXC_AUDMUX_V2_PTCR_TCSEL(3),
> -			MXC_AUDMUX_V2_PDCR_RXDSEL(3)
> +			MXC_AUDMUX_V2_PTCR_TCSEL(SSI_PORT),
> +			MXC_AUDMUX_V2_PDCR_RXDSEL(SSI_PORT)
>  	);
> -	mxc_audmux_v2_configure_port(3,
> +	mxc_audmux_v2_configure_port(SSI_PORT,
>  			MXC_AUDMUX_V2_PTCR_SYN,
>  			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
>  	);
> +	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
>  #endif
>  
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX25)
> +	imx25_add_imx_uart1(&uart_pdata);
> +	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
> +#endif
> +
> +#if defined(CONFIG_MACH_EUKREA_CPUIMX35)
>  	imx35_add_imx_uart1(&uart_pdata);
>  	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
>  	mxc_register_device(&mx3_fb, &mx3fb_pdata);
> -
> -	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
> +#endif
>  
>  	gpio_request(GPIO_LED1, "LED1");
>  	gpio_direction_output(GPIO_LED1, 1);
> diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
> deleted file mode 100644
> index 116eee7..0000000
> --- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/*
> - * Copyright (C) 2010 Eric Benard - eric at eukrea.com
> - *
> - * Based on board-pcm038.h which is :
> - * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> - * MA 02110-1301, USA.
> - */
> -
> -#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
> -#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
> -
> -#ifndef __ASSEMBLY__
> -/*
> - * This CPU module needs a baseboard to work. After basic initializing
> - * its own devices, it calls baseboard's init function.
> - * TODO: Add your own baseboard init function and call it from
> - * inside eukrea_cpuimx25_init().
> - *
> - * This example here is for the development board. Refer
> - * eukrea_mbimx25-baseboard.c
> - */
> -
> -extern void eukrea_mbimxsd_baseboard_init(void);
> -
> -#endif
> -
> -#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__ */
> diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
> similarity index 84%
> rename from arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
> rename to arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
> index 5c9901e..35f9583 100644
> --- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
> +++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
> @@ -19,22 +19,22 @@
>   * MA 02110-1301, USA.
>   */
>  
> -#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
> -#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
> +#ifndef __MACH_BOARD_EUKREA_CPUIMXSD_H__
> +#define __MACH_BOARD_EUKREA_CPUIMXSD_H__
>  
>  #ifndef __ASSEMBLY__
>  /*
>   * This CPU module needs a baseboard to work. After basic initializing
>   * its own devices, it calls baseboard's init function.
>   * TODO: Add your own baseboard init function and call it from
> - * inside eukrea_cpuimx25_init().
> + * inside eukrea_cpuimx25_init() or eukrea_cpuimx35_init().
>   *
>   * This example here is for the development board. Refer
> - * eukrea_mbimx25-baseboard.c
> + * eukrea_mbimxsd-baseboard.c
>   */
>  
>  extern void eukrea_mbimxsd_baseboard_init(void);
>  
>  #endif
>  
> -#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__ */
> +#endif /* __MACH_BOARD_EUKREA_CPUIMXSD_H__ */
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
