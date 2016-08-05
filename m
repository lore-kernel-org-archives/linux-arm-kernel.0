From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Aug 2016 14:39:55 +0100
Subject: [PATCH 1/1] Add PPD device tree
In-Reply-To: <1470403887-15190-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <1470403887-15190-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <20160805133954.GC25152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 03:31:25PM +0200, Fabien Lahoudere wrote:
> +/*
> + * Hardware uses CKO2 at 24MHz at several places. Set the parent clock of
> + * CKO2 to OSC.
> + */
> +#define CKO2_CONFIGURATION \
> +	clock-frequency = <24000000>; \
> +	clocks = <&clks IMX5_CLK_CKO2>; \
> +	assigned-clocks = <&clks IMX5_CLK_CKO2_SEL>, <&clks IMX5_CLK_OSC>; \
> +	assigned-clock-parents = <&clks IMX5_CLK_OSC>

This makes the DT harder to read.

Please place these explicitly where used.

> +
> +/ {
> +	model = "Freescale i.MX53 CPUV0 PPD rev6";
> +	compatible = "fsl,imx53-ppd", "fsl,imx53";
> +
> +	aliases {
> +		spi0 = &cspi;
> +		spi1 = &ecspi1;
> +		spi2 = &ecspi2;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};

It would be good if you could also define the rate, using an alias if
necessary.

> +
> +	memory {
> +		reg = <0x70000000 0x20000000>,
> +		      <0xb0000000 0x20000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cko2_11M: sgtl_clock_cko2 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <11289600>;
> +		};
> +	};

Get rid of the clocks node, and place the clock directly under the root
node.

> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_sgtl5k: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "reg-sgtl5k";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};

Likewise for these. Get rid of the regulators container node and place
these directly under the root node.

Please don't make fake up reg and unit-address values. Just suffix the
node name, e.g. regulator-sgtl5k.

> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	fsl,spi-num-chipselects = <4>;
> +	/* Fake this GPIO, this has special handling in userspace. */

NAK. The DT should reflect reality, and should not be specific to a
given userspace.

> +	cs-gpios = <&gpio5 1 GPIO_ACTIVE_LOW
> +		    &gpio4 10 GPIO_ACTIVE_LOW
> +		    &gpio4 11 GPIO_ACTIVE_LOW
> +		    &gpio4 12 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	spidev0: spi at 0 {
> +		compatible = "spidev";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		status = "okay";
> +	};
> +
> +	spidev1: spi at 1 {
> +		compatible = "spidev";
> +		reg = <1>;
> +		spi-max-frequency = <1000000>;
> +		status = "okay";
> +	};
> +
> +	spidev2: spi at 2 {
> +		compatible = "spidev";
> +		reg = <2>;
> +		spi-max-frequency = <1000000>;
> +		status = "okay";
> +	};
> +
> +	spidev3: spi at 3 {
> +		compatible = "spidev";
> +		reg = <3>;
> +		spi-max-frequency = <1000000>;
> +		status = "okay";
> +	};
> +};

What are these SPI devices?

Please fully describe them, with a complete compatible list.

Thanks,
Mark.
