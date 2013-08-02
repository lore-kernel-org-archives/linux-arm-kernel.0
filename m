From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 2 Aug 2013 16:31:39 +0200
Subject: [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130802143139.GZ9916@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:07:27PM +0200, Thomas Petazzoni wrote:
> This commit completely converts the d2net_v2 Kirkwood board to use a
> Device Tree representation.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile              |   1 +
>  arch/arm/boot/dts/kirkwood-d2net-v2.dts | 231 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig          |   7 -
>  arch/arm/mach-kirkwood/Makefile         |   2 +-
>  arch/arm/mach-kirkwood/d2net_v2-setup.c | 231 --------------------------------
>  5 files changed, 233 insertions(+), 239 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-d2net-v2.dts
>  delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c

Hi Thomas,

Thanks for this patch. I have tested on by d2net_v2 board and it is
almost good. Please, see below for my comments.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..277685f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -67,6 +67,7 @@ dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>  	integratorcp.dtb
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>  dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
> +	kirkwood-d2net-v2.dtb \
>  	kirkwood-db-88f6281.dtb \
>  	kirkwood-db-88f6282.dtb \
>  	kirkwood-dns320.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-d2net-v2.dts b/arch/arm/boot/dts/kirkwood-d2net-v2.dts
> new file mode 100644
> index 0000000..3b2d75b
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-d2net-v2.dts
> @@ -0,0 +1,231 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "LaCie d2 Network v2";
> +	compatible = "lacie,d2net_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		/* TODO: verify memory installed on board */
> +		reg = <0x00000000 0x20000000>;

The board only provides 256MB of memory (0x100000000).

> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_inhibit_poweroff
> +				     &pmx_sysrst>;
> +
> +			pmx_spi: pmx-spi {
> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> +				marvell,function = "spi";
> +			};
> +
> +			pmx_i2c: pmx-i2c {
> +				marvell,pins = "mpp8", "mpp9";
> +				marvell,function = "twsi0";
> +			};
> +
> +			pmx_uart: pmx-uart {
> +				marvell,pins = "mpp10", "mpp11";
> +				marvell,function = "uart0";
> +			};
> +
> +			pmx_leds: pmx-leds {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpo";

"gpo" is not valid for the 6281 SoC. You could use "gpio" instead.

> +			};
> +
> +			pmx_keys: pmx-keys {
> +				marvell,pins = "mpp13", "mpp15", "mpp34";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_poweroff: pmx-poweroff {
> +				marvell,pins = "mpp7";
> +				marvell,function = "gpo";
> +			};
> +
> +			pmx_sata_power: pmx-sata-power {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sata: pmx-sata {
> +				marvell,pins = "mpp21";
> +				marvell,function = "sata0";
> +			};
> +
> +			pmx_usb: pmx-usb {
> +				marvell,pins = "mpp14", "mpp24", "mpp26", "mpp28";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			pmx_inhibit_poweroff: pmx-inhibit-poweroff {
> +				marvell,pins = "mpp35";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_cpld_leds: pmx-cpld-leds {
> +				marvell,pins = "mpp29", "mpp30";
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
> +			status = "ok";
> +			pinctrl-0 = <&pmx_uart>;
> +			pinctrl-names = "default";
> +		};
> +
> +		sata at 80000 {
> +			nr-ports = <2>;
> +			status = "okay";
> +			pinctrl-0 = <&pmx_sata>;
> +			pinctrl-names = "default";
> +		};
> +
> +		ehci at 50000 {
> +			pinctrl-0 = <&pmx_usb>;
> +			pinctrl-names = "default";
> +		};
> +	};
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
> +			linux,code = <1>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 13 0>;
> +		};
> +
> +		button at 2 {
> +			label = "Back power switch (auto|off)";
> +			linux,code = <2>;
> +			linux,input-type = <5>; /* EV_SW */
> +			gpios = <&gpio0 15 0>;
> +		};
> +
> +		button at 3 {
> +			label = "Front Push Button";
> +			linux,code = <116>; /* KEY_POWER */
> +			gpios = <&gpio1 2 1>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_leds>;
> +		pinctrl-names = "default";
> +
> +		fail {
> +			label = "d2net_v2:red:fail";
> +			gpios = <&gpio0 12 0>;
> +			default-state = "on";

"keep" is a better default-state. Else, blue and red are melted for the
front LED.

> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio0 7 0>;
> +	};
> +
> +	ns2-leds {
> +		compatible = "lacie,ns2-leds";
> +		pinctrl-0 = <&pmx_cpld_leds>;
> +		pinctrl-names = "default";
> +
> +		blue-sata {
> +			label = "d2net_v2:blue:sata";
> +			slow-gpio = <&gpio0 29 0>;
> +			cmd-gpio = <&gpio0 30 0>;
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

I don't know the regulator API at all. But is that possible to allow a
user to enable/disable the SATA0 power ? If yes, then it should be great
to have the appropriate setting.

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
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 60d0896..8bcd659 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -5,13 +5,6 @@ menu "Marvell Kirkwood Implementations"
>  config KIRKWOOD_LEGACY
>  	bool
>  
> -config MACH_D2NET_V2
> -	bool "LaCie d2 Network v2 NAS Board"
> -	select KIRKWOOD_LEGACY
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie d2 Network v2 NAS.

Before removing this option, we need to fix the Kconfig dependencies for
the LED driver leds-ns2. I will send a patch to do that.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/38085ee6/attachment.sig>
