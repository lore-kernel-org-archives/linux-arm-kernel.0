From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Nov 2015 11:35:40 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1447841412.3144.57.camel@pengutronix.de>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <1447840120-8513-2-git-send-email-marex@denx.de>
 <1447841412.3144.57.camel@pengutronix.de>
Message-ID: <201511181135.40171.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 at 11:10:12 AM, Lucas Stach wrote:
> Hi Marek,

Hi!

> some comments below.

Thanks!

[...]

> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> 
> Remove this simple bus. It's not there in hardware, regulators are board
> level components just like the nodes below.

This is surprising to me, since all the boards I checked use this /regulators
simple bus to contain all the regulators. Is this going to change now ?

> > +		reg_2p5v: 2p5v {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "2P5V";
> > +			regulator-min-microvolt = <2500000>;
> > +			regulator-max-microvolt = <2500000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_3p3v: 3p3v {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "3P3V";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_usb_otg_vbus: usb_otg_vbus {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "usb_otg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			enable-active-high;
> > +		};
> > +
> > +		reg_audio_codec: es8328-regulator {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "es8328-power";
> > +			regulator-boot-on;
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			startup-delay-us = <400000>;
> > +			gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +		};
> > +
> > +		reg_pcie: pcie-regulator {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "pcie-bus-power";
> > +			regulator-min-microvolt = <1500000>;
> > +			regulator-max-microvolt = <1500000>;
> > +			gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> 
> Make this an always-on regulator for now. More comments about this
> below.

Roger!

> > +		};

[...]

> > +&ecspi3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi3_novena>;
> > +	fsl,spi-num-chipselects = <3>;
> > +	status = "okay";
> > +
> > +	spidev at 0 {
> > +		compatible = "spidev";
> 
> This will explode on a new kernel. Specifying spidev without using a
> more specific compatible will trigger a WARN_ON(), as it's considered
> bad style.

Oh, looks like imx_v6_v7_defconfig didn't have SPIDEV active, which is
why I didn't catch it during my last test, dang.

This SPI interface is routed into the FPGA, so what do you suggest I put
in the compatible string? There is no other sensible driver for the peripheral,
since the peripheral can be anything.

> > +		spi-max-frequency = <30000000>;
> > +		reg = <0>;
> > +	};
> > +};

[...]

> > +&pcie {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_pcie_novena>;
> > +	reset-gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
> > +	bus-supply = <&reg_pcie>;
> 
> This isn't supported by the mainline binding. This needs more work to
> properly handle PROBE_DEFER in the PCIe driver. Just remove this
> property for now and make the regulator always-on, this will continue to
> work when we come around to fixing this properly.

OK

> > +	status = "okay";
> > +};
> > +
> > +&sata {
> > +	target-supply = <&reg_sata>;
> > +	fsl,transmit-level-mV = <1025>;
> > +	fsl,transmit-boost-mdB = <0>;
> > +	fsl,transmit-atten-16ths = <8>;
> > +	status = "okay";
> > +};
> > +
> > +&ssi1 {
> > +	fsl,mode = "i2s-slave";
> > +	status = "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart2_novena>;
> > +	status = "okay";
> > +};
> > +
> > +&uart3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart3_novena>;
> > +	status = "okay";
> > +};
> > +
> > +&uart4 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart4_novena>;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg {
> > +	vbus-supply = <&reg_usb_otg_vbus>;
> > +	dr_mode = "otg";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usbotg_novena>;
> > +	disable-over-current;
> > +	status = "okay";
> > +};
> > +
> > +&usbh1 {
> > +	vbus-supply = <&swbst_reg>;
> > +	status = "okay";
> > +};
> > +
> > +&usdhc2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usdhc2_novena>;
> > +	cd-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> 
> I would bet this GPIO is actually ACTIVE_LOW, lots of boards got this
> wrong initially.

Both of them in fact are LOW, thanks!
