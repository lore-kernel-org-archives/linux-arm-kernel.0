From: robherring2@gmail.com (Rob Herring)
Date: Mon, 15 Oct 2012 14:58:28 -0500
Subject: [PATCH 2/4] ARM: kirkwood: DT board setup for Network Space v2
 and parents
In-Reply-To: <1350315295-14567-3-git-send-email-simon.guinot@sequanux.org>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <507C6AE4.1020406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2012 10:34 AM, Simon Guinot wrote:
> This patch adds DT board setup for LaCie Network Space v2 and parents,
> based on the Marvell Kirkwood 6281 SoC. This includes Network Space v2
> (Max) and Internet Space v2.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/boot/dts/Makefile                 |    3 +
>  arch/arm/boot/dts/kirkwood-is2.dts         |   30 ++++++++++
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |   63 +++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-ns2.dts         |   30 ++++++++++
>  arch/arm/boot/dts/kirkwood-ns2max.dts      |   49 ++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig             |   21 +++++++
>  arch/arm/mach-kirkwood/Makefile            |    3 +
>  arch/arm/mach-kirkwood/board-dt.c          |    8 +++
>  arch/arm/mach-kirkwood/board-ns2.c         |   83 ++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h            |    8 +++
>  drivers/leds/Kconfig                       |    4 +-
>  11 files changed, 301 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-is2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2-common.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2max.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-ns2.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c1ce813..e6201b6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -34,9 +34,12 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>  	kirkwood-ib62x0.dtb \
>  	kirkwood-iconnect.dtb \
>  	kirkwood-iomega_ix2_200.dtb \
> +	kirkwood-is2.dtb \
>  	kirkwood-km_kirkwood.dtb \
>  	kirkwood-lschlv2.dtb \
>  	kirkwood-lsxhl.dtb \
> +	kirkwood-ns2.dtb \
> +	kirkwood-ns2max.dtb \
>  	kirkwood-ts219-6281.dtb \
>  	kirkwood-ts219-6282.dtb
>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
> new file mode 100644
> index 0000000..7bc4677
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-is2.dts
> @@ -0,0 +1,30 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood-ns2-common.dtsi"
> +
> +/ {
> +	model = "LaCie Internet Space v2";
> +	compatible = "lacie,inetspace_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";

Compatible strings must be documented.

Rob

> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <1>;
> +		};
> +	};
> +
> +	ns2-leds {
> +		compatible = "ns2-leds";
> +
> +		blue-sata {
> +			label = "ns2:blue:sata";
> +			slow-gpio = <&gpio0 29 0>;
> +			cmd-gpio = <&gpio0 30 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> new file mode 100644
> index 0000000..9bc6785
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> @@ -0,0 +1,63 @@
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			clock-frequency = <166666667>;
> +			status = "okay";
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +
> +			flash at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "mx25l4005a";
> +				reg = <0>;
> +				spi-max-frequency = <20000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			eeprom at 50 {
> +				compatible = "at,24c04";
> +				pagesize = <16>;
> +				reg = <0x50>;
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button at 1 {
> +			label = "Power push button";
> +			linux,code = <116>;
> +			gpios = <&gpio1 0 0>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		red-fail {
> +			label = "ns2:red:fail";
> +			gpios = <&gpio0 12 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
> new file mode 100644
> index 0000000..d018213
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-ns2.dts
> @@ -0,0 +1,30 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood-ns2-common.dtsi"
> +
> +/ {
> +	model = "LaCie Network Space v2";
> +	compatible = "lacie,netspace_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <1>;
> +		};
> +	};
> +
> +	ns2-leds {
> +		compatible = "ns2-leds";
> +
> +		blue-sata {
> +			label = "ns2:blue:sata";
> +			slow-gpio = <&gpio0 29 0>;
> +			cmd-gpio = <&gpio0 30 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
> new file mode 100644
> index 0000000..82156e2
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
> @@ -0,0 +1,49 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood-ns2-common.dtsi"
> +
> +/ {
> +	model = "LaCie Network Space Max v2";
> +	compatible = "lacie,netspace_max_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	ocp at f1000000 {
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +	gpio_fan {
> +		compatible = "gpio-fan";
> +		gpios = <&gpio0 22 1
> +			 &gpio0  7 1
> +			 &gpio1  1 1
> +			 &gpio0 23 1>;
> +		gpio-fan,speed-map =
> +			<   0  0
> +			 1500 15
> +			 1700 14
> +			 1800 13
> +			 2100 12
> +			 3100 11
> +			 3300 10
> +			 4300  9
> +			 5500  8>;
> +		alarm-gpios = <&gpio0 25 1>;
> +	};
> +
> +	ns2-leds {
> +		compatible = "ns2-leds";
> +
> +		blue-sata {
> +			label = "ns2:blue:sata";
> +			slow-gpio = <&gpio0 29 0>;
> +			cmd-gpio = <&gpio0 30 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 50bca50..847e0c2 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -130,6 +130,27 @@ config MACH_KM_KIRKWOOD_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
>  
> +config MACH_INETSPACE_V2_DT
> +	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the LaCie
> +	  Internet Space v2 NAS, using Flattened Device Tree.
> +
> +config MACH_NETSPACE_V2_DT
> +	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the LaCie
> +	  Network Space v2 NAS, using Flattened Device Tree.
> +
> +config MACH_NETSPACE_MAX_V2_DT
> +	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the LaCie
> +	  Network Space Max v2 NAS, using Flattened Device Tree.
> +
>  config MACH_TS219
>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 294779f..1f63d80 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -31,3 +31,6 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
>  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
>  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
>  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> +obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
> +obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
> +obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 70c5a28..b3e0519 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -96,6 +96,11 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("keymile,km_kirkwood"))
>  		km_kirkwood_init();
>  
> +	if (of_machine_is_compatible("lacie,inetspace_v2") ||
> +	    of_machine_is_compatible("lacie,netspace_v2") ||
> +	    of_machine_is_compatible("lacie,netspace_max_v2"))
> +		ns2_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table,
>  			     kirkwood_auxdata_lookup, NULL);
>  }
> @@ -112,6 +117,9 @@ static const char *kirkwood_dt_board_compat[] = {
>  	"buffalo,lsxl",
>  	"iom,ix2-200",
>  	"keymile,km_kirkwood",
> +	"lacie,inetspace_v2",
> +	"lacie,netspace_max_v2",
> +	"lacie,netspace_v2",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
> new file mode 100644
> index 0000000..b36c55c
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-ns2.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright 2012 (C), Simon Guinot <simon.guinot@sequanux.org>
> + *
> + * arch/arm/mach-kirkwood/board-ns2.c
> + *
> + * LaCie Network Space v2 board (and parents) initialization for drivers
> + * not converted to flattened device tree yet.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/gpio.h>
> +#include "common.h"
> +#include "mpp.h"
> +
> +static struct mv643xx_eth_platform_data ns2_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> +};
> +
> +static unsigned int ns2_mpp_config[] __initdata = {
> +	MPP0_SPI_SCn,
> +	MPP1_SPI_MOSI,
> +	MPP2_SPI_SCK,
> +	MPP3_SPI_MISO,
> +	MPP4_NF_IO6,
> +	MPP5_NF_IO7,
> +	MPP6_SYSRST_OUTn,
> +	MPP7_GPO,		/* Fan speed (bit 1) */
> +	MPP8_TW0_SDA,
> +	MPP9_TW0_SCK,
> +	MPP10_UART0_TXD,
> +	MPP11_UART0_RXD,
> +	MPP12_GPO,		/* Red led */
> +	MPP14_GPIO,		/* USB fuse */
> +	MPP16_GPIO,		/* SATA 0 power */
> +	MPP17_GPIO,		/* SATA 1 power */
> +	MPP18_NF_IO0,
> +	MPP19_NF_IO1,
> +	MPP20_SATA1_ACTn,
> +	MPP21_SATA0_ACTn,
> +	MPP22_GPIO,		/* Fan speed (bit 0) */
> +	MPP23_GPIO,		/* Fan power */
> +	MPP24_GPIO,		/* USB mode select */
> +	MPP25_GPIO,		/* Fan rotation fail */
> +	MPP26_GPIO,		/* USB device vbus */
> +	MPP28_GPIO,		/* USB enable host vbus */
> +	MPP29_GPIO,		/* Blue led (slow register) */
> +	MPP30_GPIO,		/* Blue led (command register) */
> +	MPP31_GPIO,		/* Board power off */
> +	MPP32_GPIO,		/* Power button (0 = Released, 1 = Pushed) */
> +	MPP33_GPO,		/* Fan speed (bit 2) */
> +	0
> +};
> +
> +#define NS2_GPIO_POWER_OFF	31
> +
> +static void ns2_power_off(void)
> +{
> +	gpio_set_value(NS2_GPIO_POWER_OFF, 1);
> +}
> +
> +void __init ns2_init(void)
> +{
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +	kirkwood_mpp_conf(ns2_mpp_config);
> +
> +	kirkwood_ehci_init();
> +	kirkwood_ge00_init(&ns2_ge00_data);
> +
> +	if (gpio_request(NS2_GPIO_POWER_OFF, "power-off") == 0 &&
> +	    gpio_direction_output(NS2_GPIO_POWER_OFF, 0) == 0)
> +		pm_power_off = ns2_power_off;
> +	else
> +		pr_err("ns2: failed to configure power-off GPIO\n");
> +}
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index bcffd7c..2f75f3f 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -112,6 +112,14 @@ void km_kirkwood_init(void);
>  static inline void km_kirkwood_init(void) {};
>  #endif
>  
> +#if defined(CONFIG_MACH_INETSPACE_V2_DT) || \
> +	defined(CONFIG_MACH_NETSPACE_V2_DT) || \
> +	defined(CONFIG_MACH_NETSPACE_MAX_V2_DT)
> +void ns2_init(void);
> +#else
> +static inline void ns2_init(void) {};
> +#endif
> +
>  /* early init functions not converted to fdt yet */
>  char *kirkwood_id(void);
>  void kirkwood_l2_init(void);
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index f508def..e455c08 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -379,7 +379,9 @@ config LEDS_NS2
>  	tristate "LED support for Network Space v2 GPIO LEDs"
>  	depends on LEDS_CLASS
>  	depends on MACH_NETSPACE_V2 || MACH_INETSPACE_V2 || \
> -		   MACH_NETSPACE_MAX_V2 || MACH_D2NET_V2
> +		   MACH_NETSPACE_MAX_V2 || MACH_D2NET_V2 || \
> +		   MACH_NETSPACE_V2_DT || MACH_INETSPACE_V2_DT || \
> +		   MACH_NETSPACE_MAX_V2_DT
>  	default y
>  	help
>  	  This option enable support for the dual-GPIO LED found on the
> 
