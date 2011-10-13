From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 13 Oct 2011 22:34:33 +0800
Subject: [PATCH] ARM imx51: Add Armadeus systems APF51 support
In-Reply-To: <1318512796-8126-1-git-send-email-julien.boibessot@free.fr>
References: <1318512796-8126-1-git-send-email-julien.boibessot@free.fr>
Message-ID: <20111013143432.GB27048@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 03:33:16PM +0200, julien.boibessot at free.fr wrote:
> From: Julien Boibessot <julien.boibessot@armadeus.com>
> 
> The APF51 is an i.M51 based System On Module that can be plugged on
> several docking/development boards. Here only basic module support
> is added (Ethernet, Serial, I2C & PMIC (Wolfson's WM8311)).
> 
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> Signed-off-by: Nicolas Colombain <nicolas.colombain@armadeus.com>

NAK.

It makes no sense to add yet another non-dt board file for imx51 at
this point.  Why not starting using device tree?

Regards,
Shawn

> ---
>  arch/arm/mach-mx5/Kconfig                   |   10 ++
>  arch/arm/mach-mx5/Makefile                  |    1 +
>  arch/arm/mach-mx5/board-apf51.c             |  195 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    4 +
>  4 files changed, 210 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-apf51.c
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 3d4c313..91400f3 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -169,6 +169,16 @@ config MACH_MX51_EFIKASB
>  	  Include support for Genesi Efika Smartbook. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_APF51
> +	bool "Support Armadeus APF51 System On Module"
> +	select SOC_IMX51
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX_I2C
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
> +	help
> +	  Include support for Armadeus systems APF51 System On Module. This
> +	  includes specific configurations for the board and its peripherals.
> +
>  comment "i.MX53 machines:"
>  
>  config MACH_MX53_EVK
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 9565304..1415913 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
>  obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
>  obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
>  obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
> +obj-$(CONFIG_MACH_APF51) += board-apf51.o
> diff --git a/arch/arm/mach-mx5/board-apf51.c b/arch/arm/mach-mx5/board-apf51.c
> new file mode 100644
> index 0000000..f3f22da
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-apf51.c
> @@ -0,0 +1,195 @@
> +/*
> + * Support for APF51 System On Module
> + * Copyright (C) 2010-2011 Armadeus systems <support@armadeus.com>
> + *
> + * Based on code which is:
> + * Copyright 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/wm831x/core.h>
> +#include <linux/mfd/wm831x/pdata.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/common.h>
> +#include <mach/iomux-mx51.h>
> +
> +#include "devices-imx51.h"
> +
> +static iomux_v3_cfg_t apf51_pads[] = {
> +	/* UART3 (Console) */
> +	MX51_PAD_UART3_RXD__UART3_RXD,
> +	MX51_PAD_UART3_TXD__UART3_TXD,
> +
> +	/* FEC */
> +	MX51_PAD_DI_GP3__FEC_TX_ER,
> +	MX51_PAD_DI2_PIN4__FEC_CRS,
> +	MX51_PAD_DI2_PIN2__FEC_MDC,
> +	MX51_PAD_DI2_PIN3__FEC_MDIO,
> +	MX51_PAD_DI2_DISP_CLK__FEC_RDATA1,
> +	MX51_PAD_DI_GP4__FEC_RDATA2,
> +	MX51_PAD_DISP2_DAT0__FEC_RDATA3,
> +	MX51_PAD_DISP2_DAT1__FEC_RX_ER,
> +	MX51_PAD_DISP2_DAT6__FEC_TDATA1,
> +	MX51_PAD_DISP2_DAT7__FEC_TDATA2,
> +	MX51_PAD_DISP2_DAT8__FEC_TDATA3,
> +	MX51_PAD_DISP2_DAT9__FEC_TX_EN,
> +	MX51_PAD_DISP2_DAT10__FEC_COL,
> +	MX51_PAD_DISP2_DAT11__FEC_RX_CLK,
> +	MX51_PAD_DISP2_DAT12__FEC_RX_DV,
> +	MX51_PAD_DISP2_DAT13__FEC_TX_CLK,
> +	MX51_PAD_DISP2_DAT14__FEC_RDATA0,
> +	MX51_PAD_DISP2_DAT15__FEC_TDATA0,
> +	MX51_PAD_DI1_PIN11__GPIO3_0,	/* FEC PHY reset line */
> +
> +	/* I2C2 */
> +	MX51_PAD_EIM_D24__I2C2_SDA,
> +	MX51_PAD_EIM_D27__I2C2_SCL,
> +
> +	/* PMIC */
> +	MX51_PAD_GPIO1_4__GPIO1_4,	/* WM8311 TOUCH_DETECT */
> +	MX51_PAD_GPIO1_6__GPIO1_6,	/* WM8311 TOUCH_EOC */
> +	MX51_PAD_GPIO1_7__GPIO1_7,	/* WM8311 IRQ */
> +};
> +
> +#ifdef CONFIG_MFD_WM831X_I2C
> +/* APF51 has a Wolfson PMIC on I2C2 */
> +
> +#define APF51_WM8311_TOUCH_DETECT_GPIO	IMX_GPIO_NR(1, 4)
> +#define APF51_WM8311_TOUCH_EOC_GPIO	IMX_GPIO_NR(1, 6)
> +#define APF51_WM8311_IRQ_GPIO		IMX_GPIO_NR(1, 7)
> +
> +static struct gpio apf51_wm8311_gpios[] = {
> +	{ APF51_WM8311_IRQ_GPIO, GPIOF_IN, "wm8311_irq" },
> +	{ APF51_WM8311_TOUCH_DETECT_GPIO, GPIOF_IN, "wm8311_touch_detect" },
> +	{ APF51_WM8311_TOUCH_EOC_GPIO, GPIOF_IN, "wm8311_touch_eoc" },
> +};
> +
> +static int apf51_wm8311_pre_init(struct wm831x *wm831x)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(apf51_wm8311_gpios,
> +					ARRAY_SIZE(apf51_wm8311_gpios));
> +	if (ret) {
> +		pr_err("failed to get WM8311 GPIOs: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_IRQ_GPIO),
> +					IRQF_TRIGGER_FALLING);
> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_TOUCH_DETECT_GPIO),
> +					IRQF_TRIGGER_FALLING);
> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_TOUCH_EOC_GPIO),
> +					IRQF_TRIGGER_FALLING);
> +
> +	return 0;
> +}
> +
> +static int apf51_wm8311_post_init(struct wm831x *wm831x)
> +{
> +	/* Configure GPIO6: input, pwdmn 0, inverted, CMOS, enable, pullup */
> +	wm831x_reg_write(wm831x, WM831X_GPIO6_CONTROL, 0xc080);
> +
> +	return 0;
> +}
> +
> +static struct wm831x_status_pdata apf51_wm8311_led1_pdata = {
> +	.default_src = WM831X_STATUS_PRESERVE,
> +	.name = "LED1:red:",
> +};
> +
> +static struct wm831x_status_pdata apf51_wm8311_led2_pdata = {
> +	.default_src = WM831X_STATUS_PRESERVE,
> +	.name = "LED2:green:",
> +};
> +
> +static struct wm831x_touch_pdata apf51_wm8311_touch_pdata = {
> +	.fivewire = 0,
> +	.pressure = 1,
> +	.data_irq = IMX_GPIO_TO_IRQ(APF51_WM8311_TOUCH_EOC_GPIO),
> +	.pd_irq = IMX_GPIO_TO_IRQ(APF51_WM8311_TOUCH_DETECT_GPIO),
> +};
> +
> +static struct wm831x_pdata apf51_wm8311_pdata = {
> +	.pre_init = apf51_wm8311_pre_init,
> +	.post_init = apf51_wm8311_post_init,
> +	.irq_cmos = 1,
> +	.irq_base = MXC_BOARD_IRQ_START,
> +	.status = {
> +		&apf51_wm8311_led1_pdata,
> +		&apf51_wm8311_led2_pdata,
> +	},
> +	.touch = &apf51_wm8311_touch_pdata,
> +};
> +#endif /* CONFIG_MFD_WM831X_I2C */
> +
> +static const struct imxi2c_platform_data apf51_i2c1_data __initconst = {
> +	.bitrate = 400000,
> +};
> +
> +static struct i2c_board_info apf51_i2c1_devices[] __initdata = {
> +#ifdef CONFIG_MFD_WM831X_I2C
> +	{
> +		I2C_BOARD_INFO("wm8311", 0x36),
> +		.platform_data = &apf51_wm8311_pdata,
> +		.irq = IMX_GPIO_TO_IRQ(APF51_WM8311_IRQ_GPIO),
> +	},
> +#endif
> +};
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init apf51_board_init(void)
> +{
> +	imx51_soc_init();
> +
> +#if defined(CONFIG_CPU_FREQ_IMX)
> +	get_cpu_op = mx51_get_cpu_op;
> +#endif
> +	mxc_iomux_v3_setup_multiple_pads(apf51_pads,
> +					ARRAY_SIZE(apf51_pads));
> +
> +	imx51_add_imx_uart(2, NULL);
> +
> +	imx51_add_imx_i2c(1, &apf51_i2c1_data);
> +	i2c_register_board_info(1, apf51_i2c1_devices,
> +					ARRAY_SIZE(apf51_i2c1_devices));
> +
> +	imx51_add_fec(NULL);
> +
> +	imx51_add_imx2_wdt(0, NULL);
> +}
> +
> +static void __init apf51_timer_init(void)
> +{
> +	mx51_clocks_init(32768, 32768*1024, 0, 0);
> +}
> +
> +static struct sys_timer apf51_timer = {
> +	.init = apf51_timer_init,
> +};
> +
> +MACHINE_START(APF51, "Armadeus APF51")
> +	/* Maintainer: Julien Boibessot <julien.boibessot@armadeus.com> */
> +	.map_io = mx51_map_io,
> +	.init_early = imx51_init_early,
> +	.init_irq = mx51_init_irq,
> +	.timer = &apf51_timer,
> +	.init_machine = apf51_board_init,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> index 88fd404..09ac3ea 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -64,6 +64,7 @@ static inline void flush(void)
>  #define MX3X_UART2_BASE_ADDR	0x43F94000
>  #define MX3X_UART5_BASE_ADDR	0x43FB4000
>  #define MX51_UART1_BASE_ADDR	0x73fbc000
> +#define MX51_UART3_BASE_ADDR	0x7000c000
>  #define MX50_UART1_BASE_ADDR	0x53fbc000
>  #define MX53_UART1_BASE_ADDR	0x53fbc000
>  
> @@ -111,6 +112,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  	case MACH_TYPE_MX51_3DS:
>  		uart_base = MX51_UART1_BASE_ADDR;
>  		break;
> +	case MACH_TYPE_APF51:
> +		uart_base = MX51_UART3_BASE_ADDR;
> +		break;
>  	case MACH_TYPE_MX50_RDP:
>  		uart_base = MX50_UART1_BASE_ADDR;
>  		break;
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
