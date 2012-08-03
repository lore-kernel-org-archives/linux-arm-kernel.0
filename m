From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Aug 2012 21:12:32 +0800
Subject: [PATCH 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120803131230.GB23791@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 05:56:25PM +0200, Uwe Kleine-K?nig wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> This patch adds basic support for imx35-based devices to the kernel.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx35.dtsi            |  246 +++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig    |    1 +
>  arch/arm/mach-imx/Kconfig               |   13 ++
>  arch/arm/mach-imx/Makefile              |    1 +
>  arch/arm/mach-imx/imx35-dt.c            |  119 +++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    2 +
>  6 files changed, 382 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx35.dtsi
>  create mode 100644 arch/arm/mach-imx/imx35-dt.c
> 
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> new file mode 100644
> index 0000000..d0c6456
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -0,0 +1,246 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27.dtsi
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +	};
> +
> +	avic: avic-interrupt-controller at 68000000 {
> +		compatible = "fsl,imx35-avic", "fsl,avic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x68000000 0x10000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ckil {
> +			compatible = "fsl,imx-ckil", "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		osc {
> +			compatible = "fsl,imx-osc", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu at 0 {
> +			device_type = "cpu";

This is not really necessary, IIRC.

> +			compatible = "fsl,imx35", "arm,arm1136jfs";
> +			reg = <0>;
> +			d-cache-size = <0x4000>;	// L1, 16K
> +			i-cache-size = <0x4000>;	// L1, 16K

Are these two common bindings?  Documented in
Documentation/devicetree/bindings for somewhere?

> +			bus-frequency = <0>;		// from bootloader

Ditto.  I'm not even sure how this works.  Does your bootloader
really populates this property?  Which bus?

> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&avic>;
> +		ranges;
> +
> +		aips at 40000000 { /* AIPS1 */
> +			compatible = "fsl,aips", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40000000 0x100000>;
> +			ranges;
> +
> +			i2c1: i2c at 43f80000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
> +				reg = <0x43f80000 0x4000>;
> +				interrupts = <10>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c at 43f84000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
> +				reg = <0x43f84000 0x4000>;
> +				interrupts = <3>;
> +				status = "disabled";
> +			};
> +
> +			uart1: uart at 43f90000 {

Name the node "serial".

> +				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
> +				reg = <0x43f90000 0x4000>;
> +				interrupts = <45>;
> +				status = "disabled";
> +			};
> +
> +			uart2: uart at 43f94000 {
> +				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
> +				reg = <0x43f94000 0x4000>;
> +				interrupts = <32>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c at 43f98000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx35-i2c", "fsl,imx1-i2c";
> +				reg = <0x43f98000 0x4000>;
> +				interrupts = <4>;
> +				status = "disabled";
> +			};

We generally have a new line between nodes.

> +			iomuxc at 43fac000 {
> +				compatible = "fsl,imx35-iomuxc";
> +				reg = <0x43fac000 0x4000>;
> +
> +				i2c3 {
> +					pinctrl_i2c3_1: i2c3grp-1 {
> +						fsl,pins = <773 0x1c0 /* MX35_PAD_ATA_DATA12__I2C3_SCL */
> +							777 0x1c0>; /* MX35_PAD_ATA_DATA13__I2C3_SDA */
> +					};
> +				};
> +
> +				can1 {
> +					pinctrl_can1_1: can1grp-1 {
> +						fsl,pins = <223 0x1c0 /* MX35_PAD_I2C2_CLK__CAN1_TXCAN */
> +							228 0x1c0>; /* MX35_PAD_I2C2_DAT__CAN1_RXCAN */
> +					};
> +				};
> +				can2 {
> +					pinctrl_can2_1: can2grp-1 {
> +						fsl,pins = <291 0x1c0 /* MX35_PAD_TX5_RX0__CAN2_TXCAN */
> +							298 0x1c0>; /* MX35_PAD_TX4_RX1__CAN2_RXCAN */
> +					};
> +				};
> +
> +			};
> +		};
> +
> +		spba at 50000000 {
> +			compatible = "fsl,spba-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x50000000 0x100000>;
> +			ranges;
> +
> +			uart3: uart at 5000c000 {
> +				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
> +				reg = <0x5000c000 0x4000>;
> +				interrupts = <18>;
> +				status = "disabled";
> +			};
> +
> +			fec: fec at 50038000 {
> +				compatible = "fsl,imx35-fec", "fsl,imx27-fec";
> +				reg = <0x50038000 0x4000>;
> +				interrupts = <57>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		aips at 53f00000 { /* AIPS2 */
> +			compatible = "fsl,aips", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x53f00000 0xffc0000>;
> +			ranges;
> +
> +			gpio3: gpio at 0x53fa4000 {
> +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";

compatible = "fsl,imx35-gpio";

> +				reg = <0x53fa4000 0x4000>;
> +				interrupts = <56>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;

It should be 2 now.

> +			};
> +
> +			esdhc1: esdhc at 53fb4000 {
> +				compatible = "fsl,mx35-sdhc", "fsl,esdhc";

compatible = "fsl,imx35-esdhc";

> +				reg = <0x53fb4000 0x4000>;
> +				interrupts = <7>;
> +				status = "disabled";
> +			};
> +
> +			esdhc2: esdhc at 53fb8000 {
> +				compatible = "fsl,mx35-sdhc", "fsl,esdhc";
> +				reg = <0x53fb8000 0x4000>;
> +				interrupts = <8>;
> +				status = "disabled";
> +			};
> +
> +			esdhc3: esdhc at 53fbc000 {
> +				compatible = "fsl,mx35-sdhc", "fsl,esdhc";
> +				reg = <0x53fbc000 0x4000>;
> +				interrupts = <9>;
> +				status = "disabled";
> +			};
> +
> +			gpio1: gpio at 0x53fcc000 {
> +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
> +				reg = <0x53fcc000 0x4000>;
> +				interrupts = <52>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +
> +			gpio2: gpio at 0x53fd0000 {
> +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
> +				reg = <0x53fd0000 0x4000>;
> +				interrupts = <51>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +
> +			wdog at 53fdc000 {
> +				compatible = "fsl,imx35-wdt", "fsl,imx2-wdt";
> +				reg = <0x53fdc000 0x4000>;
> +				interrupts = <55>;
> +				status = "disabled";

Drop status to have wdog such completely SoC internal stuff enabled by
default.

> +			};
> +
> +			can at 53fe4000 {
> +				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
> +				reg = <0x53fe4000 0x1000>;
> +				interrupts = <43>;
> +				status = "disabled";
> +			};
> +			can at 53fe8000 {
> +				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
> +				reg = <0x53fe8000 0x1000>;
> +				interrupts = <44>;
> +				status = "disabled";
> +			};
> +		};
> +		nand at bb000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			compatible = "fsl,imx35-nand", "fsl,imx25-nand";
> +			reg = <0xbb000000 0x2000>;
> +			interrupts = <33>;
> +			status = "disabled";
> +		};

Why nand device isn't under any bus but soc directly?

> +	};
> +};
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index b1d3675..9389ab6 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -26,6 +26,7 @@ CONFIG_MACH_ARMADILLO5X0=y
>  CONFIG_MACH_KZM_ARM11_01=y
>  CONFIG_MACH_PCM043=y
>  CONFIG_MACH_MX35_3DS=y
> +CONFIG_MACH_IMX35_DT=y
>  CONFIG_MACH_VPR200=y
>  CONFIG_MACH_IMX51_DT=y
>  CONFIG_MACH_MX51_3DS=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index eff4db5..95f9d6a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -644,6 +644,19 @@ config MACH_VPR200
>  	  Include support for VPR200 platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_IMX35_DT
> +	bool "Support i.MX35 platforms from device tree"
> +	select SOC_IMX35
> +	select USE_OF

USE_OF is selected by ARCH_MXC now.

> +	select HAVE_CAN_FLEXCAN if CAN

Move it to "config SOC_IMX35".

> +	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select IMX_HAVE_PLATFORM_SPI_IMX
> +	select IMX_HAVE_PLATFORM_IMX2_WDT

These are unreasonable.

> +	select PINCTRL

Need to select PINCTRL_IMX35 also?

And they should be under "config SOC_IMX35".

> +	help
> +	  Include support for Freescale i.MX35 based platforms
> +	  using the device tree for discovery
> +
>  comment "i.MX5 platforms:"
>  
>  config MACH_MX50_RDP
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index ff29421..97d01b5 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
>  obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
> +obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
>  
>  obj-$(CONFIG_DEBUG_LL) += lluart.o
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
> new file mode 100644
> index 0000000..8b9cc84
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27-dt.c
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/machine.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +#include <mach/mx35.h>
> +
> +static const struct of_dev_auxdata imx35_auxdata_lookup[] __initconst = {
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART1_BASE_ADDR, "imx21-uart.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART2_BASE_ADDR, "imx21-uart.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART3_BASE_ADDR, "imx21-uart.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-fec", MX35_FEC_BASE_ADDR, "imx27-fec.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-wdt", MX35_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C3_BASE_ADDR, "imx-i2c.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx35.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx35.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx35.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-nand", MX35_NFC_BASE_ADDR, "mxc_nand.0", NULL),
> +	{ /* sentinel */ }
> +};

If these auxdata are here only for clk lookup, we can save them by
having DT specific clkdev lookup in clock driver.

> +
> +static int __init imx35_avic_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> +	return 0;
> +}
> +
> +static int __init imx35_gpio_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +
> +	gpio_irq_base -= 32;
> +	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops,
> +				NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx35_irq_match[] __initconst = {
> +	{ .compatible = "fsl,imx35-avic", .data = imx35_avic_add_irq_domain, },
> +	{ .compatible = "fsl,imx35-gpio", .data = imx35_gpio_add_irq_domain, },
> +	{ /* sentinel */ }
> +};

All these are not needed now.

> +
> +static const struct of_device_id imx35_of_mixed_devices_match[] __initconst = {
> +	{ /* END OF LIST */ }
> +};
> +
> +static void __init of_mixed_device_hook(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *of_id;
> +
> +	np = of_find_matching_node(NULL, imx35_of_mixed_devices_match);
> +	if (np) {
> +		void (*func)(void);
> +
> +		of_id = of_match_node(imx35_of_mixed_devices_match, np);
> +		func = of_id->data;
> +		func();
> +	}
> +}

We have this on other imx DT machines for hooking the IOMUX setup done
in non-DT board files.  Since you have imx35 pinctrl support in place.
What is above hook for then?

> +
> +static void __init imx35_dt_init(void)
> +{
> +	of_irq_init(imx35_irq_match);
> +
> +	/* Some mx35 have problems when the cache is not initialized
> +	 * FIXME: ultimatly this belongs in the oftree definition
> +	 */
> +	imx3_init_l2x0();
> +	pinctrl_provide_dummies();
> +
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			     imx35_auxdata_lookup, NULL);
> +
> +	of_mixed_device_hook();
> +}
> +
> +static void __init imx35_timer_init(void)
> +{
> +	mx35_clocks_init();
> +}
> +
> +static struct sys_timer imx35_timer = {
> +	.init = imx35_timer_init,
> +};
> +
> +static const char *imx35_dt_board_compat[] __initdata = {
> +	"fsl,imx35",
> +	NULL
> +};
> +
> +DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
> +	.map_io		= mx35_map_io,
> +	.init_early	= imx35_init_early,
> +	.init_irq	= mx35_init_irq,
> +	.handle_irq	= imx35_handle_irq,
> +	.timer		= &imx35_timer,
> +	.init_machine	= imx35_dt_init,
> +	.dt_compat	= imx35_dt_board_compat,
> +	.restart	= mxc_restart,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index e429ca1..643b0aa 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -50,6 +50,7 @@ extern void imx25_soc_init(void);
>  extern void imx27_soc_init(void);
>  extern void imx31_soc_init(void);
>  extern void imx35_soc_init(void);
> +extern void imx3_init_l2x0(void);
>  extern void imx50_soc_init(void);
>  extern void imx51_soc_init(void);
>  extern void imx53_soc_init(void);
> @@ -67,6 +68,7 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  			unsigned long ckih1, unsigned long ckih2);
>  extern int mx27_clocks_init_dt(void);
> +extern int mx35_clocks_init_dt(void);

It does not necessarily belong this driver.

Regards,
Shawn

>  extern int mx51_clocks_init_dt(void);
>  extern int mx53_clocks_init_dt(void);
>  extern int mx6q_clocks_init(void);
> -- 
> 1.7.10.4
> 
