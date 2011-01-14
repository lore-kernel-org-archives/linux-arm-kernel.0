From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 09:34:08 +0100
Subject: [PATCH] Introduce VPR200 board.
In-Reply-To: <1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
References: <1294962532-15790-1-git-send-email-marc@cpdesign.com.au>
	<1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20110114083408.GD24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Jan 14, 2011 at 10:48:52AM +1100, Marc Reilly wrote:
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  arch/arm/mach-mx3/Kconfig       |   15 ++
>  arch/arm/mach-mx3/Makefile      |    1 +
>  arch/arm/mach-mx3/mach-vpr200.c |  404 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 420 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx3/mach-vpr200.c
> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 0717f88..ca63c35 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -229,4 +229,19 @@ config MACH_EUKREA_MBIMXSD35_BASEBOARD
>  
>  endchoice
>  
> +config MACH_VPR200
> +	bool "Support VPR200 platform"
> +	select SOC_IMX35
> +	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX_I2C
> +	select IMX_HAVE_PLATFORM_MXC_EHCI
> +	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> +	select IMX_HAVE_PLATFORM_MXC_PWM
> +	help
> +	  Include support for VPR200 platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
>  endif
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index 8db1329..bc7294f 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
>  obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
> +obj-$(CONFIG_MACH_VPR200)	+= mach-vpr200.o
> diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
> new file mode 100644
> index 0000000..a4f0514
> --- /dev/null
> +++ b/arch/arm/mach-mx3/mach-vpr200.c
> @@ -0,0 +1,404 @@
> +/*
> + * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2009 Marc Kleine-Budde, Pengutronix
> + * Copyright 2010 Creative Product Design
> + *
> + * Derived from mx35 3stack.
> + * Original author: Fabio Estevam <fabio.estevam@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/memory.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/iomux-mx35.h>
> +#include <mach/irqs.h>
> +#include <mach/ipu.h>
> +#include <mach/mx3fb.h>
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/mfd/mc13xxx.h>
> +#include <video/platform_lcd.h>
> +
> +#include "devices-imx35.h"
> +#include "devices.h"
> +
> +#define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
> +#define GPIO_PMIC_INT	IMX_GPIO_NR(2, 0)
> +
> +#define GPIO_BUTTON1	IMX_GPIO_NR(1, 4)
> +#define GPIO_BUTTON2	IMX_GPIO_NR(1, 5)
> +#define GPIO_BUTTON3	IMX_GPIO_NR(1, 7)
> +#define GPIO_BUTTON4	IMX_GPIO_NR(1, 8)
> +#define GPIO_BUTTON5	IMX_GPIO_NR(1, 9)
> +#define GPIO_BUTTON6	IMX_GPIO_NR(1, 10)
> +#define GPIO_BUTTON7	IMX_GPIO_NR(1, 11)
> +#define GPIO_BUTTON8	IMX_GPIO_NR(1, 12)
> +
> +static const struct fb_videomode fb_modedb[] = {
> +	{
> +	/* 800x480 @ 60 Hz */
> +	.name		= "PT0708048",
> +	.refresh	= 60,
> +	.xres		= 800,
> +	.yres		= 480,
> +	.pixclock	= KHZ2PICOS(33260),
> +	.left_margin	= 50,
> +	.right_margin	= 156,
> +	.upper_margin	= 10,
> +	.lower_margin	= 10,
> +	.hsync_len	= 1,	/* note: DE only display */
> +	.vsync_len	= 1,	/* note: DE only display */
> +	.sync		= FB_SYNC_CLK_IDLE_EN | FB_SYNC_OE_ACT_HIGH,
> +	.vmode		= FB_VMODE_NONINTERLACED,
> +	.flag		= 0,
> +	}, {
> +	/* 800x480 @ 60 Hz */
> +	.name		= "CTP-CLAA070LC0ACW",
> +	.refresh	= 60,
> +	.xres		= 800,
> +	.yres		= 480,
> +	.pixclock	= KHZ2PICOS(27000),
> +	.left_margin	= 50,
> +	.right_margin	= 50,	/* whole line should have 900 clocks */
> +	.upper_margin	= 10,
> +	.lower_margin	= 10,	/* whole frame should have 500 lines */
> +	.hsync_len	= 1,	/* note: DE only display */
> +	.vsync_len	= 1,	/* note: DE only display */
> +	.sync		= FB_SYNC_CLK_IDLE_EN | FB_SYNC_OE_ACT_HIGH,
> +	.vmode		= FB_VMODE_NONINTERLACED,
> +	.flag		= 0,
> +	}
> +};
> +
> +static struct ipu_platform_data mx3_ipu_data = {
> +	.irq_base = MXC_IPU_IRQ_START,
> +};
> +
> +static struct mx3fb_platform_data mx3fb_pdata = {
> +	.dma_dev	= &mx3_ipu.dev,
> +	.name		= "PT0708048",
> +	.mode		= fb_modedb,
> +	.num_modes	= ARRAY_SIZE(fb_modedb),
> +};
> +
> +static struct physmap_flash_data vpr200_flash_data = {
> +	.width  = 2,
> +};
> +
> +static struct resource vpr200_flash_resource = {
> +	.start	= MX35_CS0_BASE_ADDR,
> +	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device vpr200_flash = {
> +	.name	= "physmap-flash",
> +	.id	= 0,
> +	.dev	= {
> +		.platform_data  = &vpr200_flash_data,
> +	},
> +	.resource = &vpr200_flash_resource,
> +	.num_resources = 1,
> +};
> +
> +static const struct mxc_nand_platform_data
> +		vpr200_nand_board_info __initconst = {
> +	.width = 1,
> +	.hw_ecc = 1,
> +	.flash_bbt = 1,
> +};
> +
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
I'd prefer to have unconditional device registration.

> +#include <linux/gpio_keys.h>
> +#define VPR_KEY_DEBOUNCE	500
> +
> +static struct gpio_keys_button vpr200_gpio_keys_table[] = {
> +	{KEY_F2, GPIO_BUTTON1, 1, "vpr-keys: F2", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F3, GPIO_BUTTON2, 1, "vpr-keys: F3", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F4, GPIO_BUTTON3, 1, "vpr-keys: F4", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F5, GPIO_BUTTON4, 1, "vpr-keys: F5", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F6, GPIO_BUTTON5, 1, "vpr-keys: F6", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F7, GPIO_BUTTON6, 1, "vpr-keys: F7", 0, VPR_KEY_DEBOUNCE},
> +	{KEY_F8, GPIO_BUTTON7, 1, "vpr-keys: F8", 1, VPR_KEY_DEBOUNCE},
> +	{KEY_F9, GPIO_BUTTON8, 1, "vpr-keys: F9", 1, VPR_KEY_DEBOUNCE},
> +};
> +
> +static struct gpio_keys_platform_data vpr200_gpio_keys_data = {
> +	.buttons = vpr200_gpio_keys_table,
> +	.nbuttons = ARRAY_SIZE(vpr200_gpio_keys_table),
> +};
> +
> +static struct platform_device vpr200_device_gpiokeys = {
> +	.name = "gpio-keys",
> +	.dev = {
> +		.platform_data = &vpr200_gpio_keys_data,
> +	}
> +};
> +
> +static void vpr200_init_keys(void)
> +{
> +	gpio_request(GPIO_BUTTON1, "BUTTON1");
> +	gpio_direction_input(GPIO_BUTTON1);
> +	gpio_free(GPIO_BUTTON1);
> +
> +	gpio_request(GPIO_BUTTON2, "BUTTON2");
> +	gpio_direction_input(GPIO_BUTTON2);
> +	gpio_free(GPIO_BUTTON2);
> +
> +	gpio_request(GPIO_BUTTON3, "BUTTON3");
> +	gpio_direction_input(GPIO_BUTTON3);
> +	gpio_free(GPIO_BUTTON3);
> +
> +	gpio_request(GPIO_BUTTON4, "BUTTON4");
> +	gpio_direction_input(GPIO_BUTTON4);
> +	gpio_free(GPIO_BUTTON4);
> +
> +	gpio_request(GPIO_BUTTON5, "BUTTON5");
> +	gpio_direction_input(GPIO_BUTTON5);
> +	gpio_free(GPIO_BUTTON5);
> +
> +	gpio_request(GPIO_BUTTON6, "BUTTON6");
> +	gpio_direction_input(GPIO_BUTTON6);
> +	gpio_free(GPIO_BUTTON6);
> +
> +	gpio_request(GPIO_BUTTON7, "BUTTON7");
> +	gpio_direction_input(GPIO_BUTTON7);
> +	gpio_free(GPIO_BUTTON7);
> +
> +	gpio_request(GPIO_BUTTON8, "BUTTON8");
> +	gpio_direction_input(GPIO_BUTTON8);
> +	gpio_free(GPIO_BUTTON8);
Hmm, doesn't the gpio-keys driver does that already?

And to do it really correct, you need to check for errors returned by
gpio_request and gpio_direction_input.

Provided you really need it, I'd do it as follows:

	int ret;

	#define setup_for_gpiokey(nr)					\
		ret = gpio_request(GPIO_BUTTON ## nr, "BUTTON" #nr);	\
		if (ret)						\
			return ret;					\
		ret = gpio_direction_input(GPIO_BUTTON ## nr);		\
		if (ret)						\
			return ret;					\
		gpio_free(GPIO_BUTTON ## nr);

	setup_for_gpiokey(1);
	setup_for_gpiokey(2);
	setup_for_gpiokey(3);
	setup_for_gpiokey(4);
	...
	
	return platform_device_register(&vpr200_device_gpiokeys);

> +
> +	platform_device_register(&vpr200_device_gpiokeys);
> +}
> +#else
> +
> +static void vpr200_init_keys(void)
> +{
> +}
> +#endif
> +
> +static struct mc13xxx_platform_data board_pmic = {
> +	.flags = MC13XXX_USE_ADC | MC13XXX_USE_TOUCHSCREEN,
> +};
if you make device registration conditional, then please #ifdef
board_pmic away, too.

> +#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
> +static const struct imxi2c_platform_data vpr200_i2c0_data __initconst = {
> +	.bitrate = 50000,
> +};
> +
> +static struct at24_platform_data board_eeprom = {
> +	.byte_len = 2048 / 8,
> +	.page_size = 1,
> +};
> +
> +static struct i2c_board_info vpr200_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("at24", 0x50), /* E0=0, E1=0, E2=0 */
> +		.platform_data = &board_eeprom,
> +	}, {
> +		I2C_BOARD_INFO("mc13892", 0x08),
> +		.platform_data = &board_pmic,
> +		.irq = gpio_to_irq(GPIO_PMIC_INT),
> +	}
> +};
> +#endif
> +
> +static iomux_v3_cfg_t vpr200_pads[] = {
> +	/* UART1 */
> +	MX35_PAD_CTS1__UART1_CTS,
> +	MX35_PAD_RTS1__UART1_RTS,
> +	MX35_PAD_TXD1__UART1_TXD_MUX,
> +	MX35_PAD_RXD1__UART1_RXD_MUX,
> +	/* UART3 */
> +	MX35_PAD_ATA_DATA10__UART3_RXD_MUX,
> +	MX35_PAD_ATA_DATA11__UART3_TXD_MUX,
> +	/* FEC */
> +	MX35_PAD_FEC_TX_CLK__FEC_TX_CLK,
> +	MX35_PAD_FEC_RX_CLK__FEC_RX_CLK,
> +	MX35_PAD_FEC_RX_DV__FEC_RX_DV,
> +	MX35_PAD_FEC_COL__FEC_COL,
> +	MX35_PAD_FEC_RDATA0__FEC_RDATA_0,
> +	MX35_PAD_FEC_TDATA0__FEC_TDATA_0,
> +	MX35_PAD_FEC_TX_EN__FEC_TX_EN,
> +	MX35_PAD_FEC_MDC__FEC_MDC,
> +	MX35_PAD_FEC_MDIO__FEC_MDIO,
> +	MX35_PAD_FEC_TX_ERR__FEC_TX_ERR,
> +	MX35_PAD_FEC_RX_ERR__FEC_RX_ERR,
> +	MX35_PAD_FEC_CRS__FEC_CRS,
> +	MX35_PAD_FEC_RDATA1__FEC_RDATA_1,
> +	MX35_PAD_FEC_TDATA1__FEC_TDATA_1,
> +	MX35_PAD_FEC_RDATA2__FEC_RDATA_2,
> +	MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
> +	MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
> +	MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
> +	/* Display */
> +	MX35_PAD_LD0__IPU_DISPB_DAT_0,
> +	MX35_PAD_LD1__IPU_DISPB_DAT_1,
> +	MX35_PAD_LD2__IPU_DISPB_DAT_2,
> +	MX35_PAD_LD3__IPU_DISPB_DAT_3,
> +	MX35_PAD_LD4__IPU_DISPB_DAT_4,
> +	MX35_PAD_LD5__IPU_DISPB_DAT_5,
> +	MX35_PAD_LD6__IPU_DISPB_DAT_6,
> +	MX35_PAD_LD7__IPU_DISPB_DAT_7,
> +	MX35_PAD_LD8__IPU_DISPB_DAT_8,
> +	MX35_PAD_LD9__IPU_DISPB_DAT_9,
> +	MX35_PAD_LD10__IPU_DISPB_DAT_10,
> +	MX35_PAD_LD11__IPU_DISPB_DAT_11,
> +	MX35_PAD_LD12__IPU_DISPB_DAT_12,
> +	MX35_PAD_LD13__IPU_DISPB_DAT_13,
> +	MX35_PAD_LD14__IPU_DISPB_DAT_14,
> +	MX35_PAD_LD15__IPU_DISPB_DAT_15,
> +	MX35_PAD_LD16__IPU_DISPB_DAT_16,
> +	MX35_PAD_LD17__IPU_DISPB_DAT_17,
> +	MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
> +	MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
> +	MX35_PAD_CONTRAST__IPU_DISPB_CONTR,
> +	/* LCD Enable */
> +	MX35_PAD_D3_VSYNC__GPIO1_2,
> +	/* USBOTG */
> +	MX35_PAD_USBOTG_PWR__USB_TOP_USBOTG_PWR,
> +	MX35_PAD_USBOTG_OC__USB_TOP_USBOTG_OC,
> +	/* SDCARD */
> +	MX35_PAD_SD1_CMD__ESDHC1_CMD,
> +	MX35_PAD_SD1_CLK__ESDHC1_CLK,
> +	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
> +	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
> +	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
> +	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
> +	/* PMIC */
> +	MX35_PAD_GPIO2_0__GPIO2_0,
> +	/* GPIO keys */
> +	MX35_PAD_SCKR__GPIO1_4,
> +	MX35_PAD_COMPARE__GPIO1_5,
> +	MX35_PAD_SCKT__GPIO1_7,
> +	MX35_PAD_FST__GPIO1_8,
> +	MX35_PAD_HCKT__GPIO1_9,
> +	MX35_PAD_TX5_RX0__GPIO1_10,
> +	MX35_PAD_TX4_RX1__GPIO1_11,
> +	MX35_PAD_TX3_RX2__GPIO1_12,
> +};
> +static void vpr200_lcd_power_set(struct plat_lcd_data *pd,
> +				   unsigned int power)
> +{
> +	if (power)
> +		gpio_direction_output(GPIO_LCDPWR, 0);
> +	else
> +		gpio_direction_output(GPIO_LCDPWR, 1);
calling gpio_set_value is cheaper than gpio_direction_output.  And you
can do

	gpio_set_value(GPIO_LCDPWR, !power)

(provided that you called gpio_direction_output once before as you do
below in the init function).

> +}
> +
> +static struct plat_lcd_data vpr200_lcd_power_data = {
> +	.set_power		= vpr200_lcd_power_set,
> +};
> +
> +static struct platform_device vpr200_lcd_powerdev = {
> +	.name			= "platform-lcd",
> +	.dev.platform_data	= &vpr200_lcd_power_data,
> +};
> +
> +/* USB Device config */
> +static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
> +	.operating_mode	= FSL_USB2_DR_DEVICE,
> +	.phy_mode	= FSL_USB2_PHY_UTMI,
> +	.workaround	= FLS_USB2_WORKAROUND_ENGCM09152,
> +};
> +
> +#if defined(CONFIG_USB_ULPI)
> +/* USB HOST config */
> +static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
> +	.portsc		= MXC_EHCI_MODE_SERIAL,
> +	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
> +			  MXC_EHCI_INTERNAL_PHY,
> +};
> +#endif
> +
> +static struct platform_device *devices[] __initdata = {
> +	&vpr200_flash,
> +	&vpr200_lcd_powerdev,
> +};
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
can you please call that vpr200_init or similar?

> +{
> +	mxc_iomux_v3_setup_multiple_pads(vpr200_pads, ARRAY_SIZE(vpr200_pads));
> +
> +	imx35_add_fec(NULL);
> +	imx35_add_imx2_wdt(NULL);
> +
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +
> +	gpio_request(GPIO_LCDPWR, "LCDPWR");
> +	gpio_direction_output(GPIO_LCDPWR, 0);
> +	gpio_free(GPIO_LCDPWR);
Are you sure this gpio_free is correct?
> +
> +	gpio_request(GPIO_PMIC_INT, "PMIC_INT");
> +	gpio_direction_input(GPIO_PMIC_INT);
> +	gpio_free(GPIO_PMIC_INT);
ditto.

And as above, error checking please.

> +
> +	imx35_add_imx_uart0(NULL);
> +	imx35_add_imx_uart2(NULL);
> +
> +	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
> +	mxc_register_device(&mx3_fb, &mx3fb_pdata);
> +
> +	imx35_add_fsl_usb2_udc(&otg_device_pdata);
> +
> +#if defined(CONFIG_USB_ULPI)
> +	imx35_add_mxc_ehci_hs(&usb_host_pdata);
> +#endif
> +
> +	imx35_add_mxc_nand(&vpr200_nand_board_info);
> +	imx35_add_sdhci_esdhc_imx(0, NULL);
> +
> +#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
> +	i2c_register_board_info(0, vpr200_i2c_devices,
> +			ARRAY_SIZE(vpr200_i2c_devices));
> +
> +	imx35_add_imx_i2c0(&vpr200_i2c0_data);
> +#endif
> +
> +	vpr200_init_keys();
> +}
> +
> +static void __init vpr200_timer_init(void)
> +{
> +	mx35_clocks_init();
> +}
> +
> +struct sys_timer vpr200_timer = {
> +	.init	= vpr200_timer_init,
> +};
> +
> +MACHINE_START(VPR200, "VPR200")
> +	/* Maintainer: Creative Product Design */
> +	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
I hope you don't need this line.

> +	.map_io         = mx35_map_io,
> +	.init_irq       = mx35_init_irq,
> +	.init_machine   = mxc_board_init,
> +	.timer          = &vpr200_timer,
> +MACHINE_END
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
