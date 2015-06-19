From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jun 2015 00:38:47 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <1434678624.4767.22.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com>
 <1434678624.4767.22.camel@dolka.fr>
Message-ID: <20150619223847.GC1116@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/dts-v1/;

/* TODO: the specific power off method */

You can achieve this using the restart-poweroff driver. See the
kirkwood linkstation DTS files for an example.

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/input/input.h>
#include <dt-bindings/interrupt-controller/irq.h>
#include "orion5x-mv88f5182.dtsi"

/ {
	model = "Buffalo Linkstation Mini (LS-WSGL)";
	compatible = "buffalo,linkstation_mini", "marvell,orion5x-88f5182", "marvell,orion5x";

	memory {
		reg = <0x00000000 0x8000000>; /* 128 MB */
	};

	chosen {
		bootargs = "console=ttyS0,115200";
		linux,stdout-path = &uart0;
	};

	soc {
		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>;
	};

	gpio-keys {
		compatible = "gpio-keys";
		pinctrl-0 = <&pmx_buttons>;
		pinctrl-names = "default";
		#address-cells = <1>;
		#size-cells = <0>;
		func {
			label = "Function Button";
			linux,code = <KEY_OPTION>;
			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
		};

		power {
			label = "Power-on Switch";
			linux,input-type = <5>; /* EV_SW */
			linux,code = <0>; /* LSMINI_SW_POWER */
			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
		};

		autopower {
			label = "Power-auto Switch";
			linux,input-type = <5>; /* EV_SW */
			linux,code = <1>; /* LSMINI_SW_AUTOPOWER */
			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
		};

There is a contribute for two other linkstation devices also made
today, which have these two same buttons. I'm not sure these are the
best choice of keys, but what every we decide, we should use the same
for all linkstation devices.

	};

	gpio-leds {
		compatible = "gpio-leds";
		pinctrl-0 = <&pmx_leds>;
		pinctrl-names = "default";

		alarm {
			label = "alarm:red";

The board name should be in here. "lswsgl:alarm:red". Same for all the
LEDs.

			gpio = <&gpio0 2 GPIO_ACTIVE_LOW>;
		};

		info {
			label = "info:amber";
			gpio = <&gpio0 3 GPIO_ACTIVE_LOW>;
		};

		func {
			label = "func:blue:top";
			gpio = <&gpio0 9 GPIO_ACTIVE_LOW>;
		};

		power {
			label = "power:blue:bottom";
			gpio = <&gpio0 14 GPIO_ACTIVE_LOW>;
			default-state = "on";
		};
	};

	regulators {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;
		pinctrl-0 = <&pmx_sata0_power &pmx_sata1_power &pmx_usb_power>;
		pinctrl-names = "default";

		sata0_power: regulator at 0 {
			compatible = "regulator-fixed";
			reg = <0>;
			regulator-name = "SATA0 Power";
			regulator-min-microvolt = <5000000>;
			regulator-max-microvolt = <5000000>;
			enable-active-high;
			regulator-always-on;
			regulator-boot-on;
			gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
		};

		sata1_power: regulator at 1 {
			compatible = "regulator-fixed";
			reg = <1>;
			regulator-name = "SATA1 Power";
			regulator-min-microvolt = <5000000>;
			regulator-max-microvolt = <5000000>;
			enable-active-high;
			regulator-always-on;
			regulator-boot-on;
			gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
		};

		usb_power: regulator at 2 {
			compatible = "regulator-fixed";
			reg = <2>;
			regulator-name = "USB Power";
			regulator-min-microvolt = <5000000>;
			regulator-max-microvolt = <5000000>;
			enable-active-high;
			regulator-always-on;
			regulator-boot-on;
			gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
		};
	};
};

&devbus_bootcs {
	status = "okay";

	devbus,keep-config;

	flash at 0 {
		compatible = "cfi-flash";
		reg = <0 0x40000>;
		bank-width = <1>;
                #address-cells = <1>;
		#size-cells = <1>;

		partition at 0 {
			label = "Full256Kb";
			reg = <0 0x40000>;
			read-only;
		};
	};
};

&mdio {
	status = "okay";

	ethphy: ethernet-phy {
		reg = <8>;
	};
};

&ehci0 {
	status = "okay";
};

&eth {
	status = "okay";

	ethernet-port at 0 {
		phy-handle = <&ethphy>;
	};
};

&i2c {
	status = "okay";
	clock-frequency = <100000>;
	#address-cells = <1>;

	rtc at 32 {
		compatible = "ricoh,rs5c372a";
		reg = <0x32>;
	};
};

&pinctrl {
	pmx_buttons: pmx-buttons {
		marvell,pins = "mpp15", "mpp17", "mpp18";
		marvell,function = "gpio";
	};

	pmx_leds: pmx-leds {
		marvell,pins = "mpp2", "mpp3", "mpp9", "mpp14";
		marvell,function = "gpio";
	};

It would be normal to have four separate entries for these leds.

Otherwise, this looks pretty good.

	   Andrew
