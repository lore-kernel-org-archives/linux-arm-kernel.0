From: marex@denx.de (Marek Vasut)
Date: Mon, 7 May 2012 18:09:55 +0200
Subject: [PATCH 1/3] ARM: mxs: add initial device tree support for
 imx28-evk board
In-Reply-To: <1336399890-12883-2-git-send-email-shawn.guo@linaro.org>
References: <1336399890-12883-1-git-send-email-shawn.guo@linaro.org>
 <1336399890-12883-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205071809.55627.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This patch includes basic dt support which can boot via nfs rootfs.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 +
>  arch/arm/boot/dts/imx28-evk.dts               |   48 +++
>  arch/arm/boot/dts/imx28.dtsi                  |  382
> +++++++++++++++++++++++++ arch/arm/mach-mxs/Kconfig                     | 
>  10 +
>  arch/arm/mach-mxs/Makefile                    |    1 +
>  arch/arm/mach-mxs/devices/Kconfig             |    1 -
>  arch/arm/mach-mxs/mach-mxs.c                  |   85 ++++++
>  drivers/clk/mxs/clk-imx28.c                   |    1 +
>  8 files changed, 531 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx28-evk.dts
>  create mode 100644 arch/arm/boot/dts/imx28.dtsi
>  create mode 100644 arch/arm/mach-mxs/mach-mxs.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> b/Documentation/devicetree/bindings/arm/fsl.txt index bfbc771..fecb580
> 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -1,6 +1,10 @@
>  Freescale i.MX Platforms Device Tree Bindings
>  -----------------------------------------------
> 
> +i.MX28 Evaluation Kit
> +Required root node properties:
> +    - compatible = "fsl,imx28-evk", "fsl,imx28";
> +
>  i.MX51 Babbage Board
>  Required root node properties:
>      - compatible = "fsl,imx51-babbage", "fsl,imx51";
> diff --git a/arch/arm/boot/dts/imx28-evk.dts
> b/arch/arm/boot/dts/imx28-evk.dts new file mode 100644
> index 0000000..5aee8ed
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx28.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX28 Evaluation Kit";
> +	compatible = "fsl,imx28-evk", "fsl,imx28";
> +
> +	memory {
> +		reg = <0x40000000 0x08000000>;
> +	};
> +
> +	apb at 80000000 {
> +		apbx at 80040000 {
> +			duart: serial at 80074000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&duart_pins_a>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ahb at 80080000 {
> +		mac0: ethernet at 800f0000 {
> +			phy-mode = "rmii";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mac0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		mac1: ethernet at 800f4000 {
> +			phy-mode = "rmii";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mac1_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> new file mode 100644
> index 0000000..5daf757
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -0,0 +1,382 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&icoll>;
> +
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,arm926ejs";
> +		};
> +	};
> +
> +	apb at 80000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x80000000 0x80000>;
> +		ranges;
> +
> +		apbh at 80000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x80000000 0x3c900>;
> +			ranges;
> +
> +			icoll: interrupt-controller at 80000000 {
> +				compatible = "fsl,imx28-icoll", "fsl,mxs-icoll";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				reg = <0x80000000 0x2000>;
> +			};
> +
> +			hsadc at 80002000 {
> +				reg = <0x80002000 2000>;
> +				interrupts = <13 87>;
> +				status = "disabled";
> +			};
> +
> +			dma-apbh at 80004000 {
> +				reg = <0x80004000 2000>;
> +				status = "disabled";
> +			};
> +
> +			perfmon at 80006000 {
> +				reg = <0x80006000 800>;
> +				interrupts = <27>;
> +				status = "disabled";
> +			};
> +
> +			bch at 8000a000 {
> +				reg = <0x8000a000 2000>;
> +				interrupts = <41>;
> +				status = "disabled";
> +			};
> +
> +			gpmi at 8000c000 {
> +				reg = <0x8000c000 2000>;
> +				interrupts = <42 88>;
> +				status = "disabled";
> +			};
> +
> +			ssp0: ssp at 80010000 {
> +				reg = <0x80010000 2000>;
> +				interrupts = <96 82>;
> +				status = "disabled";
> +			};
> +
> +			ssp1: ssp at 80012000 {
> +				reg = <0x80012000 2000>;
> +				interrupts = <97 83>;
> +				status = "disabled";
> +			};
> +
> +			ssp2: ssp at 80014000 {
> +				reg = <0x80014000 2000>;
> +				interrupts = <98 84>;
> +				status = "disabled";
> +			};
> +
> +			ssp3: ssp at 80016000 {
> +				reg = <0x80016000 2000>;
> +				interrupts = <99 85>;
> +				status = "disabled";
> +			};
> +
> +			pinctrl at 80018000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx28-pinctrl";
> +				reg = <0x80018000 2000>;
> +
> +				duart_pins_a: duart at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3102 0x3112>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				mac0_pins_a: mac0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x4000 0x4010 0x4020
> +						0x4030 0x4040 0x4060 0x4070
> +						0x4080 0x4100>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				mac1_pins_a: mac1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x40f1 0x4091 0x40a1
> +						0x40e1 0x40b1 0x40c1>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +			};
> +
> +			digctl at 8001c000 {
> +				reg = <0x8001c000 2000>;
> +				interrupts = <89>;
> +				status = "disabled";
> +			};
> +
> +			etm at 80022000 {
> +				reg = <0x80022000 2000>;
> +				status = "disabled";
> +			};
> +
> +			dma-apbx at 80024000 {
> +				reg = <0x80024000 2000>;
> +				status = "disabled";
> +			};
> +
> +			dcp at 80028000 {
> +				reg = <0x80028000 2000>;
> +				interrupts = <52 53 54>;
> +				status = "disabled";
> +			};
> +
> +			pxp at 8002a000 {
> +				reg = <0x8002a000 2000>;
> +				interrupts = <39>;
> +				status = "disabled";
> +			};
> +
> +			ocotp at 8002c000 {
> +				reg = <0x8002c000 2000>;
> +				status = "disabled";
> +			};
> +
> +			axi-ahb at 8002e000 {
> +				reg = <0x8002e000 2000>;
> +				status = "disabled";
> +			};
> +
> +			lcdif at 80030000 {
> +				reg = <0x80030000 2000>;
> +				interrupts = <38 86>;
> +				status = "disabled";
> +			};
> +
> +			can0: can at 80032000 {
> +				reg = <0x80032000 2000>;
> +				interrupts = <8>;
> +				status = "disabled";
> +			};
> +
> +			can1: can at 80034000 {
> +				reg = <0x80034000 2000>;
> +				interrupts = <9>;
> +				status = "disabled";
> +			};
> +
> +			simdbg at 8003c000 {
> +				reg = <0x8003c000 200>;
> +				status = "disabled";
> +			};
> +
> +			simgpmisel at 8003c200 {
> +				reg = <0x8003c200 100>;
> +				status = "disabled";
> +			};
> +
> +			simsspsel at 8003c300 {
> +				reg = <0x8003c300 100>;
> +				status = "disabled";
> +			};
> +
> +			simmemsel at 8003c400 {
> +				reg = <0x8003c400 100>;
> +				status = "disabled";
> +			};
> +
> +			gpiomon at 8003c500 {
> +				reg = <0x8003c500 100>;
> +				status = "disabled";
> +			};
> +
> +			simenet at 8003c700 {
> +				reg = <0x8003c700 100>;
> +				status = "disabled";
> +			};
> +
> +			armjtag at 8003c800 {
> +				reg = <0x8003c800 100>;
> +				status = "disabled";
> +			};
> +                };
> +
> +		apbx at 80040000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x80040000 0x40000>;
> +			ranges;
> +
> +			clkctl at 80040000 {
> +				reg = <0x80040000 2000>;
> +				status = "disabled";
> +			};
> +
> +			saif0: saif at 80042000 {
> +				reg = <0x80042000 2000>;
> +				interrupts = <59 80>;
> +				status = "disabled";
> +			};
> +
> +			power at 80044000 {
> +				reg = <0x80044000 2000>;
> +				status = "disabled";
> +			};
> +
> +			saif1: saif at 80046000 {
> +				reg = <0x80046000 2000>;
> +				interrupts = <58 81>;
> +				status = "disabled";
> +			};
> +
> +			lradc at 80050000 {
> +				reg = <0x80050000 2000>;
> +				status = "disabled";
> +			};
> +
> +			spdif at 80054000 {
> +				reg = <0x80054000 2000>;
> +				interrupts = <45 66>;
> +				status = "disabled";
> +			};
> +
> +			rtc at 80056000 {
> +				reg = <0x80056000 2000>;
> +				interrupts = <28 29>;
> +				status = "disabled";
> +			};
> +
> +			i2c0: i2c at 80058000 {
> +				reg = <0x80058000 2000>;
> +				interrupts = <111 68>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 8005a000 {
> +				reg = <0x8005a000 2000>;
> +				interrupts = <110 69>;
> +				status = "disabled";
> +			};
> +
> +			pwm at 80064000 {
> +				reg = <0x80064000 2000>;
> +				status = "disabled";
> +			};
> +
> +			timrot at 80068000 {
> +				reg = <0x80068000 2000>;
> +				status = "disabled";
> +			};
> +
> +			auart0: serial at 8006a000 {
> +				reg = <0x8006a000 0x2000>;
> +				interrupts = <112 70 71>;
> +				status = "disabled";
> +			};
> +
> +			auart1: serial at 8006c000 {
> +				reg = <0x8006c000 0x2000>;
> +				interrupts = <113 72 73>;
> +				status = "disabled";
> +			};
> +
> +			auart2: serial at 8006e000 {
> +				reg = <0x8006e000 0x2000>;
> +				interrupts = <114 74 75>;
> +				status = "disabled";
> +			};
> +
> +			auart3: serial at 80070000 {
> +				reg = <0x80070000 0x2000>;
> +				interrupts = <115 76 77>;
> +				status = "disabled";
> +			};
> +
> +			auart4: serial at 80072000 {
> +				reg = <0x80072000 0x2000>;
> +				interrupts = <116 78 79>;
> +				status = "disabled";
> +			};
> +
> +			duart: serial at 80074000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x80074000 0x1000>;
> +				interrupts = <47>;
> +				status = "disabled";
> +			};
> +
> +			usbphy0: usbphy at 8007c000 {
> +				reg = <0x8007c000 0x2000>;
> +				status = "disabled";
> +			};
> +
> +			usbphy1: usbphy at 8007e000 {
> +				reg = <0x8007e000 0x2000>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	ahb at 80080000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x80080000 0x80000>;
> +		ranges;
> +
> +		usbctrl0: usbctrl at 80080000 {
> +			reg = <0x80080000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		usbctrl1: usbctrl at 80090000 {
> +			reg = <0x80090000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		dflpt at 800c0000 {
> +			reg = <0x800c0000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		mac0: ethernet at 800f0000 {
> +			compatible = "fsl,imx28-fec";
> +			reg = <0x800f0000 0x4000>;
> +			interrupts = <101>;
> +			status = "disabled";
> +		};
> +
> +		mac1: ethernet at 800f4000 {
> +			compatible = "fsl,imx28-fec";
> +			reg = <0x800f4000 0x4000>;
> +			interrupts = <102>;
> +			status = "disabled";
> +		};
> +
> +		switch at 800f8000 {
> +			reg = <0x800f8000 0x8000>;
> +			status = "disabled";
> +		};
> +
> +	};
> +};
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 07d5383..15bb4e2 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -7,18 +7,28 @@ config MXS_OCOTP
> 
>  config SOC_IMX23
>  	bool
> +	select ARM_AMBA
>  	select CPU_ARM926T
>  	select HAVE_PWM
>  	select PINCTRL_IMX23
> 
>  config SOC_IMX28
>  	bool
> +	select ARM_AMBA
>  	select CPU_ARM926T
>  	select HAVE_PWM
>  	select PINCTRL_IMX28
> 
>  comment "MXS platforms:"
> 
> +config MACH_MXS_DT
> +	bool "Support MXS platforms from device tree"
> +	select SOC_IMX28
> +	select USE_OF
> +	help
> +	  Include support for Freescale MXS platforms(i.MX23 and i.MX28)
> +	  using the device tree for discovery
> +
>  config MACH_STMP378X_DEVB
>  	bool "Support STMP378x_devb Platform"
>  	select SOC_IMX23
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 6ce21a2..e41590c 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -4,6 +4,7 @@ obj-y := devices.o icoll.o iomux.o system.o timer.o mm.o
>  obj-$(CONFIG_MXS_OCOTP) += ocotp.o
>  obj-$(CONFIG_PM) += pm.o
> 
> +obj-$(CONFIG_MACH_MXS_DT) += mach-mxs.o
>  obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
>  obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
>  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> diff --git a/arch/arm/mach-mxs/devices/Kconfig
> b/arch/arm/mach-mxs/devices/Kconfig index b8913df..19659de 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -1,6 +1,5 @@
>  config MXS_HAVE_AMBA_DUART
>  	bool
> -	select ARM_AMBA
> 
>  config MXS_HAVE_PLATFORM_AUART
>  	bool
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> new file mode 100644
> index 0000000..5d81a23
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/init.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +
> +static int __init mxs_icoll_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	irq_domain_add_legacy(np, 128, 0, 0, &irq_domain_simple_ops, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mxs_irq_match[] __initconst = {
> +	{ .compatible = "fsl,mxs-icoll", .data = mxs_icoll_add_irq_domain, },
> +	{ /* sentinel */ }
> +};
> +
> +static void __init mxs_dt_init_irq(void)
> +{
> +	icoll_init_irq();
> +	of_irq_init(mxs_irq_match);
> +}
> +
> +static void __init imx28_timer_init(void)
> +{
> +	mx28_clocks_init();
> +}
> +
> +static struct sys_timer imx28_timer = {
> +	.init = imx28_timer_init,
> +};
> +
> +static void __init imx28_evk_init(void)
> +{
> +	struct clk *clk;
> +
> +	/* Enable fec phy clock */
> +	clk = clk_get_sys("enet_out", NULL);
> +	if (!IS_ERR(clk))
> +		clk_prepare_enable(clk);
> +}
> +
> +static void __init mxs_machine_init(void)
> +{
> +	if (of_machine_is_compatible("fsl,imx28-evk"))
> +		imx28_evk_init();
> +
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +				NULL, NULL);
> +}
> +
> +static const char *imx28_dt_compat[] __initdata = {
> +	"fsl,imx28-evk",
> +	"fsl,imx28",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
> +	.map_io		= mx28_map_io,
> +	.init_irq	= mxs_dt_init_irq,
> +	.timer		= &imx28_timer,
> +	.init_machine	= mxs_machine_init,
> +	.dt_compat	= imx28_dt_compat,
> +	.restart	= mxs_restart,
> +MACHINE_END
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 2ae0d3d..92b6ce0 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -133,6 +133,7 @@ static struct clk_lookup hbus_lookups[] __initdata = {
> 
>  static struct clk_lookup xbus_lookups[] __initdata = {
>  	{ .dev_id = "duart", .con_id = "apb_pclk"},
> +	{ .dev_id = "80074000.serial", .con_id = "apb_pclk"},
>  	{ .dev_id = "mxs-dma-apbx", },
>  	{ .dev_id = "80024000.dma-apbx", },
>  };
