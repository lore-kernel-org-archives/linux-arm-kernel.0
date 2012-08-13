From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 16:15:21 +0800
Subject: [PATCH v2 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120813081518.GA27480@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 11:32:49AM +0200, Uwe Kleine-K?nig wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> This patch adds basic support for imx35-based devices to the kernel.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> --
> Changes since implict v1
> (id:1343922986-32469-1-git-send-email-u.kleine-koenig at pengutronix.de)
> 
>  - add aliases for gpio devices
>  - drop calling irq_domain_add_legacy
>  - drop soc/cpus from device tree
>  - rename uart entries to serial
>  - drop "status = "disabled"" from watchdog node
>  - drop fallback compatibility entries for fsl,mx35-sdhc
>  - put nand below a new emi node
>  - fix register range for aips1
>  - add ssi1
>  - gpio controllers have two interrupt cells
>  - register additional clklookups instead of using auxdata lookup
> 
>  arch/arm/boot/dts/imx35.dtsi            |  253 +++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig    |    1 +
>  arch/arm/mach-imx/Kconfig               |   12 ++
>  arch/arm/mach-imx/Makefile              |    1 +
>  arch/arm/mach-imx/clk-imx35.c           |   14 ++
>  arch/arm/mach-imx/imx35-dt.c            |   56 +++++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  7 files changed, 338 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx35.dtsi
>  create mode 100644 arch/arm/mach-imx/imx35-dt.c
> 
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> new file mode 100644
> index 0000000..05f906f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -0,0 +1,253 @@
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
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
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
> +			reg = <0x43f00000 0x100000>;

The address in "reg" property should match the one in node name.

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
> +			uart1: serial at 43f90000 {
> +				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
> +				reg = <0x43f90000 0x4000>;
> +				interrupts = <45>;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial at 43f94000 {
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
> +
> +			ssi1: ssi at 43fa0000 {
> +				compatible = "fsl,imx35-ssi", "fsl,imx21-ssi";
> +				reg = <0x43fa0000 0x4000>;
> +				interrupts = <11>;
> +				fsl,ssi-dma-events = <29 28 27 26>;
> +				status = "disabled";
> +			};

New line.

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
> +
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

SPBA bus should not be at the same level as AIPS bus.  Instead, it's
under AIPS, as core accesses SPBA blocks through AIPS too.

> +			compatible = "fsl,spba-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x50000000 0x100000>;
> +			ranges;
> +
> +			uart3: serial at 5000c000 {
> +				compatible = "fsl,imx35-uart", "fsl,imx21-uart";
> +				reg = <0x5000c000 0x4000>;
> +				interrupts = <18>;
> +				status = "disabled";
> +			};
> +
> +			fec: fec at 50038000 {

Nit: The label is quite pointless here.  No one refers to this node,
and it does not document the block instance like some other labels do.

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

Again, this should just be "fsl,imx35-gpio"

> +				reg = <0x53fa4000 0x4000>;
> +				interrupts = <56>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			esdhc1: esdhc at 53fb4000 {
> +				compatible = "fsl,mx35-sdhc";

Again, this should be compatible = "fsl,imx35-esdhc"

I'm wondering if I'm actually looking at the v2 :)

> +				reg = <0x53fb4000 0x4000>;
> +				interrupts = <7>;
> +				status = "disabled";
> +			};
> +
> +			esdhc2: esdhc at 53fb8000 {
> +				compatible = "fsl,mx35-sdhc";
> +				reg = <0x53fb8000 0x4000>;
> +				interrupts = <8>;
> +				status = "disabled";
> +			};
> +
> +			esdhc3: esdhc at 53fbc000 {
> +				compatible = "fsl,mx35-sdhc";
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
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio2: gpio at 0x53fd0000 {
> +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
> +				reg = <0x53fd0000 0x4000>;
> +				interrupts = <51>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			wdog at 53fdc000 {
> +				compatible = "fsl,imx35-wdt", "fsl,imx2-wdt";
> +				reg = <0x53fdc000 0x4000>;
> +				interrupts = <55>;
> +			};
> +
> +			can at 53fe4000 {
> +				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
> +				reg = <0x53fe4000 0x1000>;
> +				interrupts = <43>;
> +				status = "disabled";
> +			};

New line.

> +			can at 53fe8000 {
> +				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
> +				reg = <0x53fe8000 0x1000>;
> +				interrupts = <44>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		emi at 80000000 { /* External Memory Interface */
> +			compatible = "fsl,emi", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x80000000 0x40000000>;
> +			ranges;
> +
> +			nand at bb000000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
These should not be needed, until you will have sub-nodes with "reg"
property.

> +				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
> +				reg = <0xbb000000 0x2000>;
> +				interrupts = <33>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index f725b96..d27a3e2 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -28,6 +28,7 @@ CONFIG_MACH_ARMADILLO5X0=y
>  CONFIG_MACH_KZM_ARM11_01=y
>  CONFIG_MACH_PCM043=y
>  CONFIG_MACH_MX35_3DS=y
> +CONFIG_MACH_IMX35_DT=y
>  CONFIG_MACH_VPR200=y
>  CONFIG_MACH_IMX51_DT=y
>  CONFIG_MACH_MX51_3DS=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 156c986..0d9bf22 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -653,6 +653,18 @@ config MACH_VPR200
>  	  Include support for VPR200 platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_IMX35_DT
> +	bool "Support i.MX35 platforms from device tree"
> +	select SOC_IMX35
> +	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select IMX_HAVE_PLATFORM_SPI_IMX
> +	select IMX_HAVE_PLATFORM_IMX2_WDT

At least put a comment saying why these are needed for DT?

> +	select PINCTRL
> +	select PINCTRL_IMX35
> +	help
> +	  Include support for Freescale i.MX35 based platforms
> +	  using the device tree for discovery
> +
>  comment "i.MX5 platforms:"
>  
>  config MACH_MX50_RDP
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 07f7c22..c68a925 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
>  obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
> +obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
>  
>  obj-$(CONFIG_DEBUG_LL) += lluart.o
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index 83d614c..323907e 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -202,7 +202,9 @@ int __init mx35_clocks_init()
>  				i, PTR_ERR(clk[i]));
>  
>  	clk_register_clkdev(clk[pata_gate], NULL, "pata_imx");
> +	clk_register_clkdev(clk[can1_gate], NULL, "53fe4000.can");
>  	clk_register_clkdev(clk[can1_gate], NULL, "flexcan.0");
> +	clk_register_clkdev(clk[can2_gate], NULL, "53fe8000.can");
>  	clk_register_clkdev(clk[can2_gate], NULL, "flexcan.1");
>  	clk_register_clkdev(clk[cspi1_gate], "per", "imx35-cspi.0");
>  	clk_register_clkdev(clk[cspi1_gate], "ipg", "imx35-cspi.0");
> @@ -219,12 +221,16 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[esdhc3_gate], "per", "sdhci-esdhc-imx35.2");
>  	clk_register_clkdev(clk[ipg], "ipg", "sdhci-esdhc-imx35.2");
>  	clk_register_clkdev(clk[ahb], "ahb", "sdhci-esdhc-imx35.2");
> +	clk_register_clkdev(clk[fec_gate], NULL, "50038000.fec");
>  	/* i.mx35 has the i.mx27 type fec */
>  	clk_register_clkdev(clk[fec_gate], NULL, "imx27-fec.0");
>  	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
> +	clk_register_clkdev(clk[i2c1_gate], NULL, "43f80000.i2c");
>  	clk_register_clkdev(clk[i2c1_gate], NULL, "imx-i2c.0");
> +	clk_register_clkdev(clk[i2c2_gate], NULL, "43f98000.i2c");
>  	clk_register_clkdev(clk[i2c2_gate], NULL, "imx-i2c.1");
> +	clk_register_clkdev(clk[i2c3_gate], NULL, "43f84000.i2c");
>  	clk_register_clkdev(clk[i2c3_gate], NULL, "imx-i2c.2");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
>  	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
> @@ -234,6 +240,12 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[ssi1_div_post], "per", "imx-ssi.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx-ssi.1");
>  	clk_register_clkdev(clk[ssi2_div_post], "per", "imx-ssi.1");
> +	clk_register_clkdev(clk[uart1_gate], "per", "43f90000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "43f90000.serial");
> +	clk_register_clkdev(clk[uart2_gate], "per", "43f94000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "43f94000.serial");
> +	clk_register_clkdev(clk[uart3_gate], "per", "5000c000.serial");
> +	clk_register_clkdev(clk[ipg], "ipg", "5000c000.serial");
>  	/* i.mx35 has the i.mx21 type uart */
>  	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
>  	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
> @@ -253,7 +265,9 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
>  	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
>  	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[wdog_gate], NULL, "53fdc000.wdog");
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
> +	clk_register_clkdev(clk[nfc_div], NULL, "bb000000.nand");
>  	clk_register_clkdev(clk[nfc_div], NULL, "mxc_nand.0");
>  
>  	clk_prepare_enable(clk[spba_gate]);
> diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
> new file mode 100644
> index 0000000..52b619a
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -0,0 +1,56 @@
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
> +#include <mach/hardware.h>
> +#include <linux/gpio.h>

This one is not well sorted.  Actually, I have seen some of the headers
are not needed now.

> +
> +static void __init imx35_dt_init(void)
> +{
> +	/* Some mx35 have problems when the cache is not initialized
> +	 * FIXME: ultimatly this belongs in the oftree definition
> +	 */

/*
 * Multiple line comments
 */

> +	imx3_init_l2x0();

Any problem with using l2x0_of_init instead here?

> +	pinctrl_provide_dummies();

Ideally, we should not have this.  But at least have a comment saying
this is a stop-gap solution before pinctrl is ready, and should be
removed once pinctrl is in place.

Regards,
Shawn

> +
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
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
> index 7128e97..82b0a57 100644
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
> -- 
> 1.7.10.4
> 
