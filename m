From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Jul 2017 10:46:55 +0100
Subject: [PATCH] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170712094655.GC7472@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 12, 2017 at 11:04:08AM +0200, linux-kernel-dev at beckhoff.com wrote:
> +/dts-v1/;
> +#include "imx53.dtsi"
> +
> +#define MX53_PAD_EIM_D26__UART2_RXD_MUX    0x144 0x48c 0x880 0x2 0x0
> +#define MX53_PAD_EIM_D27__UART2_TXD_MUX    0x148 0x490 0x000 0x2 0x0
> +#define MX53_PAD_EIM_D28__UART2_RTS        0x14c 0x494 0x87c 0x2 0x0
> +#define MX53_PAD_EIM_D29__UART2_CTS        0x150 0x498 0x000 0x2 0x0
> +
> +/ {
> +	model = "Freescale i.MX53 based Beckhoff CX9020";
> +	compatible = "fsl,imx53-qsb", "fsl,imx53";
> +
> +	chosen {
> +		stdout-path = &uart2;

No baud-rate or bits configuration?

> +	};
> +
> +	memory {
> +		reg = <0x70000000 0x20000000>,
> +		      <0xb0000000 0x20000000>;
> +	};
> +
> +	ccat {
> +		compatible = "bhf,emi-ccat";
> +	};
> +
> +	display0: display at di0 {

This unit-address (the bit after the @) isn't valid, as that should
match a reg or ranges, but this node has neither.

Just call this display-0.

> +		#address-cells =<1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,imx-parallel-display";
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ipu_disp0>;
> +		status = "okay";
> +
> +		port at 0 {
> +			reg = <0>;
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu_di0_disp0>;
> +			};
> +		};
> +
> +		port at 1 {
> +			reg = <1>;
> +			display0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +
> +	dvi_panel: display at 0 {

Likewise you have no reg here, so the unit address isn't valid.

Surely panel-0?

> +		#address-cells =<1>;
> +		#size-cells = <0>;
> +		compatible = "simple,ddc-only";

I don't see that compatible string in my Linux tree, and it doesn't make
sense to me -- "simple" isn't a vendor-prefix.

Where has this come from?

> +		ddc-i2c-bus = <&i2c2>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&display0_out>;
> +			};
> +		};
> +	};

[...]

> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_3p2v: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;

Meaningless reg entry.

> +			regulator-name = "3P2V";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_usb_vbus: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;

Likewise.

> +			regulator-name = "usb_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio7 8 0>;
> +			enable-active-high;
> +		};
> +	};

There's no need for a simple-bus here. It doesn't represent HW, and you
can nothing. You can put these directly under the root node, without a
synthetic reg or unnecessary container:

	reg_3p2v: regulator-3p2v {
		compatible = "regulator-fixed";
		regulator-name = "3P2V";
		regulator-min-microvolt = <3200000>;
		regulator-max-microvolt = <3200000>;
		regulator-always-on;
	};

	reg_usb_vbus: regulator-usb-vbus {
		compatible = "regulator-fixed";
		regulator-name = "usb_vbus";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		gpio = <&gpio7 8 0>;
		enable-active-high;
	}

Otherwise, looks fine to me.

Thanks,
Mark.
