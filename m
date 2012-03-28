From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Mar 2012 13:58:04 +0800
Subject: [PATCH v2 1/1] ARM: imx28: add basic dt support
In-Reply-To: <1332513070-5400-1-git-send-email-b29396@freescale.com>
References: <1332513070-5400-1-git-send-email-b29396@freescale.com>
Message-ID: <20120328055801.GA3953@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 10:31:10PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This patch includes basic dt support which can boot via nfs rootfs.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ChangeLog v1->v2:
>  * Some fixes addressed Rob's review comments.
>    Remove using of OF_DEV_AUXDATA.
>  * Remove mac address from dts file
>    Currently we use the mac address got from uboot to work.
>    Will submit a p separate atch using prom_update_property to fix this
>    issue for driver based on suggestions from Grant and Lothar.
>  * rename mxs-dt.c to mach-mxs.c which is supposed to support mx23 dt
>    too in the future.
>  * add compatible string "fsl,imx28" per Sascha's suggestion
>  * add more devices in dtsi file
>    For those devices still not in use, set the state to "disabled"
>    by default.
> 
> For other patches i sent with this in the first series like mmc and sdma
> dt support, i will send out them separately since this patch does not depend
> on them and does not block you to run dt via nfs rootfs.
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 +
>  arch/arm/boot/dts/imx28-evk.dts               |   35 +++
>  arch/arm/boot/dts/imx28.dtsi                  |  358 +++++++++++++++++++++++++
>  arch/arm/mach-mxs/Kconfig                     |    8 +
>  arch/arm/mach-mxs/Makefile                    |    1 +
>  arch/arm/mach-mxs/clock-mx28.c                |    4 +
>  arch/arm/mach-mxs/mach-mxs.c                  |   69 +++++
>  7 files changed, 479 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx28-evk.dts
>  create mode 100644 arch/arm/boot/dts/imx28.dtsi
>  create mode 100644 arch/arm/mach-mxs/mach-mxs.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 54bddda..9f21faf 100644
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
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> new file mode 100644
> index 0000000..5402495
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -0,0 +1,35 @@
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
> +		device_type = "memory";

This is already in skeleton.dtsi included by imx28.dtsi.

> +		reg = <0x40000000 0x08000000>;
> +	};
> +
> +	ahb at 80080000 {
> +		ethernet at 800f0000 {
> +			phy-mode = "rmii";
> +			status = "okay";
> +		};
> +
> +		ethernet at 800f4000 {
> +			phy-mode = "rmii";
> +			status = "okay";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> new file mode 100644
> index 0000000..9152354
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -0,0 +1,358 @@
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
> +	#address-cells = <1>;
> +	#size-cells = <1>;

These two are already in skeleton.dtsi.

> +	interrupt-parent = <&icoll>;
> +
> +	aliases {
> +		serial0 = &duart;
> +	};
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
> +				compatible = "fsl,imx28-icoll";

I would expect it be:

	compatible = "fsl,imx28-icoll", "fsl,mxs-icoll";

So it can be matched by both imx23 and imx28.

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
> +			ssp at 80010000 {
> +				reg = <0x80010000 2000>;
> +				interrupts = <96 82>;
> +				status = "disabled";
> +			};
> +
> +			ssp at 80012000 {
> +				reg = <0x80012000 2000>;
> +				interrupts = <97 83>;
> +				status = "disabled";
> +			};
> +
> +			ssp at 80014000 {
> +				reg = <0x80014000 2000>;
> +				interrupts = <98 84>;
> +				status = "disabled";
> +			};
> +
> +			ssp at 80016000 {
> +				reg = <0x80016000 2000>;
> +				interrupts = <99 85>;
> +				status = "disabled";
> +			};
> +
> +			pinctrl at 80018000 {
> +				reg = <0x80018000 2000>;
> +				status = "disabled";
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
> +			can at 80032000 {
> +				reg = <0x80032000 2000>;
> +				interrupts = <8>;
> +				status = "disabled";
> +			};
> +
> +			can at 80034000 {
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
> +			saif at 80042000 {
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
> +			saif at 80046000 {
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
> +			i2c at 80058000 {
> +				reg = <0x80058000 2000>;
> +				interrupts = <111 68>;
> +				status = "disabled";
> +			};
> +
> +			i2c at 8005a000 {
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
> +			serial at 8006a000 {
> +				reg = <0x8006a000 0x2000>;
> +				interrupts = <112 70 71>;
> +				status = "disabled";
> +			};
> +
> +			serial at 8006c000 {
> +				reg = <0x8006c000 0x2000>;
> +				interrupts = <113 72 73>;
> +				status = "disabled";
> +			};
> +
> +			serial at 8006e000 {
> +				reg = <0x8006e000 0x2000>;
> +				interrupts = <114 74 75>;
> +				status = "disabled";
> +			};
> +
> +			serial at 80070000 {
> +				reg = <0x80070000 0x2000>;
> +				interrupts = <115 76 77>;
> +				status = "disabled";
> +			};
> +
> +			serial at 80072000 {
> +				reg = <0x80072000 0x2000>;
> +				interrupts = <116 78 79>;
> +				status = "disabled";
> +			};
> +
> +			duart: serial at 80074000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x80074000 0x1000>;
> +				interrupts = <47>;
> +			};
> +
> +			usbphy at 8007c000 {
> +				reg = <0x8007c000 0x2000>;
> +				status = "disabled";
> +			};
> +
> +			usbphy at 8007e000 {
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
> +		usbctrl at 80080000 {
> +			reg = <0x80080000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		usbctrl at 80090000 {
> +			reg = <0x80090000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		dflpt at 800c0000 {
> +			reg = <0x800c0000 0x10000>;
> +			status = "disabled";
> +		};
> +
> +		ethernet at 800f0000 {
> +			compatible = "fsl,imx28-fec";
> +			reg = <0x800f0000 0x4000>;
> +			interrupts = <101>;
> +			status = "disabled";
> +		};
> +
> +		ethernet at 800f4000 {
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
> index c57f996..c776aef 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -17,6 +17,14 @@ config SOC_IMX28
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

If I build mxs_defconfig with only MACH_MXS_DT enabled, I got

  LD      .tmp_vmlinux1
arch/arm/mach-mxs/built-in.o: In function `mxs_add_amba_device':
arch/arm/mach-mxs/devices.c:89: undefined reference to `amba_device_register'

It's caused by missing "select ARM_AMBA".  For non-dt build, it gets
selected under "config MXS_HAVE_AMBA_DUART" (mach-mxs/devices/Kconfig).

I intend to fix it in the following way.

--8<---
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 570d5d5..d076452 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -7,11 +7,13 @@ config MXS_OCOTP

 config SOC_IMX23
        bool
+       select ARM_AMBA
        select CPU_ARM926T
        select HAVE_PWM

 config SOC_IMX28
        bool
+       select ARM_AMBA
        select CPU_ARM926T
        select HAVE_PWM

diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 18b6bf5..2febd62 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -1,6 +1,5 @@
 config MXS_HAVE_AMBA_DUART
        bool
-       select ARM_AMBA

--->8--

>  config MACH_STMP378X_DEVB
>  	bool "Support STMP378x_devb Platform"
>  	select SOC_IMX23
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 908bf9a..8328c45 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PM) += pm.o
>  obj-$(CONFIG_SOC_IMX23) += clock-mx23.o
>  obj-$(CONFIG_SOC_IMX28) += clock-mx28.o
>  
> +obj-$(CONFIG_MACH_MXS_DT) += mach-mxs.o
>  obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
>  obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
>  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..88ed30c 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -671,6 +671,10 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
>  	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
>  	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
> +	/* for DT */
> +	_REGISTER_CLOCK("80074000.serial", NULL, uart_clk)
> +	_REGISTER_CLOCK("800f0000.ethernet", NULL, fec_clk)
> +	_REGISTER_CLOCK("800f4000.ethernet", NULL, fec_clk)
>  };
>  
>  static int clk_misc_init(void)
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> new file mode 100644
> index 0000000..6d1e331
> --- /dev/null
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -0,0 +1,69 @@
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
> +#include <linux/init.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +#include <mach/mx28.h>

This one is not needed.

> +
> +static int __init imx28_icoll_add_irq_domain(struct device_node *np,

mxs_icoll_add_irq_domain

> +				struct device_node *interrupt_parent)
> +{
> +	irq_domain_add_simple(np, 0);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mxs_irq_match[] __initconst = {
> +	{ .compatible = "fsl,imx28-icoll", .data = imx28_icoll_add_irq_domain, },

"fsl,mxs-icoll"

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
> +static void __init imx28_machine_init(void)

mxs_init_machine(), so that imx23 can use it later and have the
function name somehow aligned with hook name .init_machine.

> +{
> +       of_platform_populate(NULL, of_default_bus_match_table,
> +		NULL, NULL);
> +}
> +
> +static const char *imx28_dt_compat[] __initdata = {

mxs_dt_compat

> +	"fsl,imx28",
> +	"fsl,imx28-evk",

I would have the list sorted from the most specific to the most
general.  That said, it's better to have "fsl,imx28" sorted after
"fsl,imx28-evk".

> +	NULL,
> +};
> +
> +DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
> +	.map_io		= mx28_map_io,
> +	.init_irq	= mxs_dt_init_irq,
> +	.timer		= &imx28_timer,
> +	.init_machine	= imx28_machine_init,
> +	.dt_compat	= imx28_dt_compat,
> +	.restart	= mxs_restart,
> +MACHINE_END
> -- 
> 1.7.0.4
> 

-- 
Regards,
Shawn
