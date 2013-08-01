From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 1 Aug 2013 11:24:35 +0200
Subject: [PATCH 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2
 platforms to DT
In-Reply-To: <1375346738-21596-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375346738-21596-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130801092435.GW9916@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:45:36AM +0200, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-net2big-v2.dts          | 204 ++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-net5big-v2.dts          | 238 +++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig                     |  24 +--
>  arch/arm/mach-kirkwood/Makefile                    |   4 +-
>  .../{netxbig_v2-setup.c => board-netxbig_v2.c}     | 213 +-----------------
>  5 files changed, 459 insertions(+), 224 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
>  rename arch/arm/mach-kirkwood/{netxbig_v2-setup.c => board-netxbig_v2.c} (53%)

OK. Please drop my reply to your patch 8. For some reasons, I got this
one right after...

It looks all good. I am going to test it.

Thanks

Simon

> 
> diff --git a/arch/arm/boot/dts/kirkwood-net2big-v2.dts b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
> new file mode 100644
> index 0000000..06beca9
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
> @@ -0,0 +1,204 @@
> +/*
> + * LaCie 2Big Network v2
> + *
> + * Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are common between the 6281
> + * and 6282 variants of the Marvell Kirkwood Development Board.
> + */
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "LaCie 2Big Network v2";
> +	compatible = "lacie,net2big-v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_misc &pmx_sysrst>;
> +			pinctrl-names = "default";
> +
> +			pmx_keys: pmx-keys {
> +				marvell,pins = "mpp13", "mpp15", "mpp34";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sata_power: pmx-sata-power {
> +				marvell,pins = "mpp16", "mpp17";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins = "mpp20";
> +				marvell,function = "sata1";
> +			};
> +
> +			pmx_sata0: pmx-sata0 {
> +				marvell,pins = "mpp21";
> +				marvell,function = "sata0";
> +			};
> +
> +			pmx_poweroff: pmx-poweroff {
> +				marvell,pins = "mpp7";
> +				marvell,function = "gpo";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			/*
> +			 * MPP14: USB fuse alarm
> +			 * MPP24: USB mode select
> +			 * MPP26: USB device vbus
> +			 * MPP28: USB enable host vbus
> +			 * MPP35: inhibit switch power-off
> +			 * MPP36: SATA HDD1 presence
> +			 * MPP37: SATA HDD2 presence
> +			 * MPP40: eSATA presence
> +			 * MPP44: GPIO extension (data 0)
> +			 * MPP45: GPIO extension (data 1)
> +			 * MPP46: GPIO extension (data 2)
> +			 * MPP47: GPIO extension (addr 0)
> +			 * MPP48: GPIO extension (addr 1)
> +			 * MPP49: GPIO extension (addr 2)
> +			 */
> +			pmx_misc: pmx-misc {
> +				marvell,pins = "mpp14", "mpp24", "mpp26", "mpp28", "mpp29",
> +					       "mpp35", "mpp36", "mpp37", "mpp40", "mpp44",
> +					       "mpp45", "mpp46", "mpp47", "mpp48", "mpp49";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
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
> +			pinctrl-0 = <&pmx_i2c>;
> +			pinctrl-names = "default";
> +
> +			eeprom at 50 {
> +				compatible = "at,24c04";
> +				pagesize = <16>;
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			pinctrl-0 = <&pmx_uart0>;
> +			pinctrl-names = "default";
> +			clock-frequency = <200000000>;
> +			status = "ok";
> +		};
> +
> +		ehci at 50000 {
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +        gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio0 7 0>;
> +        };
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_keys>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Back power switch (on|auto)";
> +			linux,code = <0x1>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 13 1>;
> +		};
> +		button at 1 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <0x2>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 15 1>;
> +		};
> +		button at 1 {
> +			label = "Function button";
> +			linux,code = <0x165>; /* KEY_OPTION */
> +			gpios = <&gpio1 3 1>;
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		pinctrl-0 = <&pmx_sata_power>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sata0_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA0 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 16 0>;
> +		};
> +
> +		sata1_power: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 17 0>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-net5big-v2.dts b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
> new file mode 100644
> index 0000000..61dea84
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
> @@ -0,0 +1,238 @@
> +/*
> + * LaCie 5Big Network v2
> + *
> + * Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file contains the definitions that are common between the 6281
> + * and 6282 variants of the Marvell Kirkwood Development Board.
> + */
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "LaCie 5Big Network v2";
> +	compatible = "lacie,net5big-v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_misc &pmx_sysrst>;
> +			pinctrl-names = "default";
> +
> +			pmx_keys: pmx-keys {
> +				marvell,pins = "mpp13", "mpp15", "mpp34";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sata_power: pmx-sata-power {
> +				marvell,pins = "mpp16", "mpp17", "mpp41", "mpp42", "mpp43";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_poweroff: pmx-poweroff {
> +				marvell,pins = "mpp7";
> +				marvell,function = "gpo";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			/*
> +			 * MPP14: USB fuse alarm
> +			 * MPP28: USB enable host vbus
> +			 * MPP29: GPIO extension ALE
> +			 * MPP35: inhibit switch power-off
> +			 * MPP36: SATA HDD1 presence
> +			 * MPP37: SATA HDD2 presence
> +			 * MPP38: SATA HDD3 presence
> +			 * MPP39: SATA HDD4 presence
> +			 * MPP40: SATA HDD5 presence
> +			 * MPP44: GPIO extension (data 0)
> +			 * MPP45: GPIO extension (data 1)
> +			 * MPP46: GPIO extension (data 2)
> +			 * MPP47: GPIO extension (addr 0)
> +			 * MPP48: GPIO extension (addr 1)
> +			 * MPP49: GPIO extension (addr 2)
> +			 */
> +			pmx_misc: pmx-misc {
> +				marvell,pins = "mpp14", "mpp28", "mpp29", "mpp35", "mpp36",
> +					       "mpp37", "mpp38", "mpp39", "mpp40", "mpp44",
> +					       "mpp45", "mpp46", "mpp47", "mpp48", "mpp49";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_ge1: pmx-ge1 {
> +				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23", "mpp24",
> +					       "mpp25", "mpp26", "mpp27", "mpp30", "mpp31",
> +					       "mpp32", "mpp33";
> +				marvell,function = "ge1";
> +			};
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
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
> +			pinctrl-0 = <&pmx_i2c>;
> +			pinctrl-names = "default";
> +
> +			eeprom at 50 {
> +				compatible = "at,24c04";
> +				pagesize = <16>;
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			pinctrl-0 = <&pmx_uart0>;
> +			pinctrl-names = "default";
> +			clock-frequency = <200000000>;
> +			status = "ok";
> +		};
> +
> +		ehci at 50000 {
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +        gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio0 7 0>;
> +        };
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_keys>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Back power switch (on|auto)";
> +			linux,code = <0x1>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 13 1>;
> +		};
> +		button at 1 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <0x2>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 15 1>;
> +		};
> +		button at 1 {
> +			label = "Function button";
> +			linux,code = <0x165>; /* KEY_OPTION */
> +			gpios = <&gpio1 3 1>;
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		pinctrl-0 = <&pmx_sata_power>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sata0_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA0 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 16 0>;
> +		};
> +
> +		sata1_power: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 17 0>;
> +		};
> +
> +		sata2_power: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA2 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 9 0>;
> +		};
> +
> +		sata3_power: regulator at 4 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA3 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 10 0>;
> +		};
> +
> +		sata4_power: regulator at 5 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "SATA4 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 11 0>;
> +                };
> +        };
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 5c207a8..0f2cafb 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -2,18 +2,6 @@ if ARCH_KIRKWOOD
>  
>  menu "Marvell Kirkwood Implementations"
>  
> -config MACH_NET2BIG_V2
> -	bool "LaCie 2Big Network v2 NAS Board"
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie 2Big Network v2 NAS.
> -
> -config MACH_NET5BIG_V2
> -	bool "LaCie 5Big Network v2 NAS Board"
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie 5Big Network v2 NAS.
> -
>  config MACH_OPENRD
>          bool
>  
> @@ -200,6 +188,18 @@ config MACH_MV88F6281GTW_GE_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell 88F6281 GTW GE Board (Flattened Device Tree).
>  
> +config MACH_NET2BIG_V2_DT
> +	bool "LaCie 2Big Network v2 NAS Board (Flattened Device Tree)"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  LaCie 2Big Network v2 NAS  (Flattened Device Tree).
> +
> +config MACH_NET5BIG_V2_DT
> +	bool "LaCie 5Big Network v2 NAS Board (Flattened Device Tree)"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  LaCie 5Big Network v2 NAS  (Flattened Device Tree).
> +
>  config MACH_NETSPACE_LITE_V2_DT
>  	bool "LaCie Network Space Lite v2 NAS (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index d0bd566..a2ec379 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -1,7 +1,5 @@
>  obj-y				+= common.o irq.o pcie.o mpp.o
>  
> -obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
> -obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
>  obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
>  obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
> @@ -26,6 +24,8 @@ obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
>  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
>  obj-$(CONFIG_MACH_MPLCEC4_DT)		+= board-mplcec4.o
>  obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
> +obj-$(CONFIG_MACH_NET2BIG_V2)		+= board-netxbig_v2.o
> +obj-$(CONFIG_MACH_NET5BIG_V2)		+= board-netxbig_v2.o
>  obj-$(CONFIG_MACH_NETSPACE_LITE_V2_DT)	+= board-ns2.o
>  obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
>  obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
> diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/board-netxbig_v2.c
> similarity index 53%
> rename from arch/arm/mach-kirkwood/netxbig_v2-setup.c
> rename to arch/arm/mach-kirkwood/board-netxbig_v2.c
> index 913d032..7d71981 100644
> --- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/board-netxbig_v2.c
> @@ -23,19 +23,14 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
>  #include <linux/mv643xx_eth.h>
> -#include <linux/input.h>
>  #include <linux/gpio.h>
> -#include <linux/gpio_keys.h>
>  #include <linux/leds.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/kirkwood.h>
>  #include <linux/platform_data/leds-kirkwood-netxbig.h>
>  #include "common.h"
> -#include "mpp.h"
> -#include "lacie_v2-common.h"
>  
>  /*****************************************************************************
>   * Ethernet
> @@ -50,61 +45,6 @@ static struct mv643xx_eth_platform_data netxbig_v2_ge01_data = {
>  };
>  
>  /*****************************************************************************
> - * SATA
> - ****************************************************************************/
> -
> -static struct mv_sata_platform_data netxbig_v2_sata_data = {
> -	.n_ports	= 2,
> -};
> -
> -/*****************************************************************************
> - * GPIO keys
> - ****************************************************************************/
> -
> -#define NETXBIG_V2_GPIO_SWITCH_POWER_ON		13
> -#define NETXBIG_V2_GPIO_SWITCH_POWER_OFF	15
> -#define NETXBIG_V2_GPIO_FUNC_BUTTON		34
> -
> -#define NETXBIG_V2_SWITCH_POWER_ON		0x1
> -#define NETXBIG_V2_SWITCH_POWER_OFF		0x2
> -
> -static struct gpio_keys_button netxbig_v2_buttons[] = {
> -	[0] = {
> -		.type           = EV_SW,
> -		.code           = NETXBIG_V2_SWITCH_POWER_ON,
> -		.gpio           = NETXBIG_V2_GPIO_SWITCH_POWER_ON,
> -		.desc           = "Back power switch (on|auto)",
> -		.active_low     = 1,
> -	},
> -	[1] = {
> -		.type           = EV_SW,
> -		.code           = NETXBIG_V2_SWITCH_POWER_OFF,
> -		.gpio           = NETXBIG_V2_GPIO_SWITCH_POWER_OFF,
> -		.desc           = "Back power switch (auto|off)",
> -		.active_low     = 1,
> -	},
> -	[2] = {
> -		.code		= KEY_OPTION,
> -		.gpio		= NETXBIG_V2_GPIO_FUNC_BUTTON,
> -		.desc		= "Function button",
> -		.active_low	= 1,
> -	},
> -};
> -
> -static struct gpio_keys_platform_data netxbig_v2_button_data = {
> -	.buttons	= netxbig_v2_buttons,
> -	.nbuttons	= ARRAY_SIZE(netxbig_v2_buttons),
> -};
> -
> -static struct platform_device netxbig_v2_gpio_buttons = {
> -	.name		= "gpio-keys",
> -	.id		= -1,
> -	.dev		= {
> -		.platform_data	= &netxbig_v2_button_data,
> -	},
> -};
> -
> -/*****************************************************************************
>   * GPIO extension LEDs
>   ****************************************************************************/
>  
> @@ -264,159 +204,12 @@ static struct platform_device netxbig_v2_leds = {
>  	},
>  };
>  
> -/*****************************************************************************
> - * General Setup
> - ****************************************************************************/
> -
> -static unsigned int net2big_v2_mpp_config[] __initdata = {
> -	MPP0_SPI_SCn,
> -	MPP1_SPI_MOSI,
> -	MPP2_SPI_SCK,
> -	MPP3_SPI_MISO,
> -	MPP6_SYSRST_OUTn,
> -	MPP7_GPO,		/* Request power-off */
> -	MPP8_TW0_SDA,
> -	MPP9_TW0_SCK,
> -	MPP10_UART0_TXD,
> -	MPP11_UART0_RXD,
> -	MPP13_GPIO,		/* Rear power switch (on|auto) */
> -	MPP14_GPIO,		/* USB fuse alarm */
> -	MPP15_GPIO,		/* Rear power switch (auto|off) */
> -	MPP16_GPIO,		/* SATA HDD1 power */
> -	MPP17_GPIO,		/* SATA HDD2 power */
> -	MPP20_SATA1_ACTn,
> -	MPP21_SATA0_ACTn,
> -	MPP24_GPIO,		/* USB mode select */
> -	MPP26_GPIO,		/* USB device vbus */
> -	MPP28_GPIO,		/* USB enable host vbus */
> -	MPP29_GPIO,		/* GPIO extension ALE */
> -	MPP34_GPIO,		/* Rear Push button */
> -	MPP35_GPIO,		/* Inhibit switch power-off */
> -	MPP36_GPIO,		/* SATA HDD1 presence */
> -	MPP37_GPIO,		/* SATA HDD2 presence */
> -	MPP40_GPIO,		/* eSATA presence */
> -	MPP44_GPIO,		/* GPIO extension (data 0) */
> -	MPP45_GPIO,		/* GPIO extension (data 1) */
> -	MPP46_GPIO,		/* GPIO extension (data 2) */
> -	MPP47_GPIO,		/* GPIO extension (addr 0) */
> -	MPP48_GPIO,		/* GPIO extension (addr 1) */
> -	MPP49_GPIO,		/* GPIO extension (addr 2) */
> -	0
> -};
> -
> -static unsigned int net5big_v2_mpp_config[] __initdata = {
> -	MPP0_SPI_SCn,
> -	MPP1_SPI_MOSI,
> -	MPP2_SPI_SCK,
> -	MPP3_SPI_MISO,
> -	MPP6_SYSRST_OUTn,
> -	MPP7_GPO,		/* Request power-off */
> -	MPP8_TW0_SDA,
> -	MPP9_TW0_SCK,
> -	MPP10_UART0_TXD,
> -	MPP11_UART0_RXD,
> -	MPP13_GPIO,		/* Rear power switch (on|auto) */
> -	MPP14_GPIO,		/* USB fuse alarm */
> -	MPP15_GPIO,		/* Rear power switch (auto|off) */
> -	MPP16_GPIO,		/* SATA HDD1 power */
> -	MPP17_GPIO,		/* SATA HDD2 power */
> -	MPP20_GE1_TXD0,
> -	MPP21_GE1_TXD1,
> -	MPP22_GE1_TXD2,
> -	MPP23_GE1_TXD3,
> -	MPP24_GE1_RXD0,
> -	MPP25_GE1_RXD1,
> -	MPP26_GE1_RXD2,
> -	MPP27_GE1_RXD3,
> -	MPP28_GPIO,		/* USB enable host vbus */
> -	MPP29_GPIO,		/* GPIO extension ALE */
> -	MPP30_GE1_RXCTL,
> -	MPP31_GE1_RXCLK,
> -	MPP32_GE1_TCLKOUT,
> -	MPP33_GE1_TXCTL,
> -	MPP34_GPIO,		/* Rear Push button */
> -	MPP35_GPIO,		/* Inhibit switch power-off */
> -	MPP36_GPIO,		/* SATA HDD1 presence */
> -	MPP37_GPIO,		/* SATA HDD2 presence */
> -	MPP38_GPIO,		/* SATA HDD3 presence */
> -	MPP39_GPIO,		/* SATA HDD4 presence */
> -	MPP40_GPIO,		/* SATA HDD5 presence */
> -	MPP41_GPIO,		/* SATA HDD3 power */
> -	MPP42_GPIO,		/* SATA HDD4 power */
> -	MPP43_GPIO,		/* SATA HDD5 power */
> -	MPP44_GPIO,		/* GPIO extension (data 0) */
> -	MPP45_GPIO,		/* GPIO extension (data 1) */
> -	MPP46_GPIO,		/* GPIO extension (data 2) */
> -	MPP47_GPIO,		/* GPIO extension (addr 0) */
> -	MPP48_GPIO,		/* GPIO extension (addr 1) */
> -	MPP49_GPIO,		/* GPIO extension (addr 2) */
> -	0
> -};
> -
> -#define NETXBIG_V2_GPIO_POWER_OFF		7
> -
> -static void netxbig_v2_power_off(void)
> +void __init netxbig_v2_init(void)
>  {
> -	gpio_set_value(NETXBIG_V2_GPIO_POWER_OFF, 1);
> -}
> -
> -static void __init netxbig_v2_init(void)
> -{
> -	/*
> -	 * Basic setup. Needs to be called early.
> -	 */
> -	kirkwood_init();
> -	if (machine_is_net2big_v2())
> -		kirkwood_mpp_conf(net2big_v2_mpp_config);
> -	else
> -		kirkwood_mpp_conf(net5big_v2_mpp_config);
> -
> -	if (machine_is_net2big_v2())
> -		lacie_v2_hdd_power_init(2);
> -	else
> -		lacie_v2_hdd_power_init(5);
> -
> -	kirkwood_ehci_init();
>  	kirkwood_ge00_init(&netxbig_v2_ge00_data);
> -	if (machine_is_net5big_v2())
> +	if (of_machine_is_compatible("lacie,net5big-v2")) {
>  		kirkwood_ge01_init(&netxbig_v2_ge01_data);
> -	kirkwood_sata_init(&netxbig_v2_sata_data);
> -	kirkwood_uart0_init();
> -	lacie_v2_register_flash();
> -	lacie_v2_register_i2c_devices();
> -
> -	if (machine_is_net5big_v2())
>  		netxbig_v2_leds.dev.platform_data = &net5big_v2_leds_data;
> +	}
>  	platform_device_register(&netxbig_v2_leds);
> -	platform_device_register(&netxbig_v2_gpio_buttons);
> -
> -	if (gpio_request(NETXBIG_V2_GPIO_POWER_OFF, "power-off") == 0 &&
> -	    gpio_direction_output(NETXBIG_V2_GPIO_POWER_OFF, 0) == 0)
> -		pm_power_off = netxbig_v2_power_off;
> -	else
> -		pr_err("netxbig_v2: failed to configure power-off GPIO\n");
>  }
> -
> -#ifdef CONFIG_MACH_NET2BIG_V2
> -MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
> -	.atag_offset	= 0x100,
> -	.init_machine	= netxbig_v2_init,
> -	.map_io		= kirkwood_map_io,
> -	.init_early	= kirkwood_init_early,
> -	.init_irq	= kirkwood_init_irq,
> -	.init_time	= kirkwood_timer_init,
> -	.restart	= kirkwood_restart,
> -MACHINE_END
> -#endif
> -
> -#ifdef CONFIG_MACH_NET5BIG_V2
> -MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
> -	.atag_offset	= 0x100,
> -	.init_machine	= netxbig_v2_init,
> -	.map_io		= kirkwood_map_io,
> -	.init_early	= kirkwood_init_early,
> -	.init_irq	= kirkwood_init_irq,
> -	.init_time	= kirkwood_timer_init,
> -	.restart	= kirkwood_restart,
> -MACHINE_END
> -#endif
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130801/6badf89a/attachment-0001.sig>
