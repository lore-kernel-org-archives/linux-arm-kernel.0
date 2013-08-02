From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 2 Aug 2013 23:25:53 +0200
Subject: [PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2
 platforms to DT
In-Reply-To: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130802212553.GA20330@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:07:33PM +0200, Thomas Petazzoni wrote:
> This commit converts the LaCie Net2big and Net5Big Kirkwood boards to
> use a Device Tree representation. All devices are converted to use a
> DT representation, except the GPIO extension leds that use a special
> leds-netxbig driver that does not yet have a DT binding.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile                |   2 +
>  arch/arm/boot/dts/kirkwood-net2big-v2.dts | 219 ++++++++++++++++
>  arch/arm/boot/dts/kirkwood-net5big-v2.dts | 265 +++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig            |  26 +-
>  arch/arm/mach-kirkwood/Makefile           |   4 +-
>  arch/arm/mach-kirkwood/board-dt.c         |   4 +
>  arch/arm/mach-kirkwood/board-netxbig_v2.c | 199 ++++++++++++++
>  arch/arm/mach-kirkwood/common.h           |   6 +
>  arch/arm/mach-kirkwood/netxbig_v2-setup.c | 422 ------------------------------
>  9 files changed, 709 insertions(+), 438 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-netxbig_v2.c
>  delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c

Again, thanks for this patch. Please, see my comments below.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d168bed..20a6886 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -85,6 +85,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
>  	kirkwood-lsxhl.dtb \
>  	kirkwood-mplcec4.dtb \
>  	kirkwood-mv88f6281gtw-ge.dtb \
> +	kirkwood-net2big-v2.dtb \
> +	kirkwood-net5big-v2.dtb \
>  	kirkwood-netgear_readynas_duo_v2.dtb \
>  	kirkwood-ns2.dtb \
>  	kirkwood-ns2lite.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-net2big-v2.dts b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
> new file mode 100644
> index 0000000..608ef01
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-net2big-v2.dts
> @@ -0,0 +1,219 @@
> +/*
> + * LaCie 2Big Network v2
> + *
> + * Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
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

The memory size is 256MB (0x10000000).

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
> +			pinctrl-0 = <&pmx_twsi0>;
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

The serial clock-frequency is 166666667 for the net2big_v2 as well as
the TCLK frequency. It could smart to inherit the clock frequencies (if
not given) from the TCLK.

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
> +		button at 2 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <0x2>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 15 1>;
> +		};
> +		button at 3 {
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

The regulator driver fails to register an already registred sysfs entry.
If I set "reg = <2>;" then the error goes away.

> +			regulator-name = "SATA1 Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 17 0>;

As for the d2net_v2, it would be nice to allow to enable/disable power
for the SATA disks.

> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		device_type = "ethernet-phy";
> +		reg = <8>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-net5big-v2.dts b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
> new file mode 100644
> index 0000000..46ca107
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-net5big-v2.dts
> @@ -0,0 +1,265 @@
> +/*
> + * LaCie 5Big Network v2
> + *
> + * Simon Guinot <sguinot@lacie.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
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

This time, the memory size is OK :)

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
> +			pinctrl-0 = <&pmx_twsi0>;
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

clock-frequency = <166666667>;

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
> +		button at 2 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <0x2>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 15 1>;
> +		};
> +		button at 3 {
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

reg = <2>; ?

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

reg = <3>; ?

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

reg = <4>; ?

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

reg = <5>; ?

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
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		device_type = "ethernet-phy";
> +		reg = <8>;
> +	};
> +
> +	ethphy1: ethernet-phy at 1 {
> +		device_type = "ethernet-phy";
> +		reg = <0>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};

eth1 don't work and I don't know why. I can only say it works with the
legacy board-setup and Linux v3.10.

> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index f624162..b7e66fa 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -5,20 +5,6 @@ menu "Marvell Kirkwood Implementations"
>  config KIRKWOOD_LEGACY
>  	bool
>  
> -config MACH_NET2BIG_V2
> -	bool "LaCie 2Big Network v2 NAS Board"
> -	select KIRKWOOD_LEGACY
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie 2Big Network v2 NAS.
> -
> -config MACH_NET5BIG_V2
> -	bool "LaCie 5Big Network v2 NAS Board"
> -	select KIRKWOOD_LEGACY
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie 5Big Network v2 NAS.
> -
>  config MACH_OPENRD
>  	select KIRKWOOD_LEGACY
>          bool
> @@ -113,6 +99,18 @@ config MACH_MV88F6281GTW_GE_DT
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

Before changing this options, we need to fix the Kconfig dependencies
for the driver led-netxbig. I will send a patch.

>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 0dcc5d4..38d0d74 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -1,8 +1,6 @@
>  obj-y				+= common.o pcie.o
>  obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
>  
> -obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
> -obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
>  obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
>  obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
> @@ -13,3 +11,5 @@ obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
>  obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
>  obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
>  obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
> +obj-$(CONFIG_MACH_NET2BIG_V2)		+= board-netxbig_v2.o

CONFIG_MACH_NET2BIG_V2_DT

> +obj-$(CONFIG_MACH_NET5BIG_V2)		+= board-netxbig_v2.o

CONFIG_MACH_NET5BIG_V2_DT

> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index b129c65..80955cc 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c

... snip ...

> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index cc639bb..a9010a3 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -71,6 +71,12 @@ void mv88f6281gtw_ge_init(void);
>  static inline void mv88f6281gtw_ge_init(void) {};
>  #endif
>  
> +#if defined(MACH_NET2BIG_V2_DT) || defined(MACH_NET5BIG_V2_DT)

#if defined(CONFIG_MACH_NET2BIG_V2_DT) || defined(CONFIG_MACH_NET5BIG_V2_DT)

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/ea5796f2/attachment.sig>
