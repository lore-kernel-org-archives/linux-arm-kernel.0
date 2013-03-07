From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 07 Mar 2013 14:06:27 +0100
Subject: doubt about where to put pin-mux in MX28 based platform DT
In-Reply-To: <5137769F.1000308@digi.com>
References: <5137769F.1000308@digi.com>
Message-ID: <513890D3.5060905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

Le 06/03/2013 18:02, Hector Palacios a ?crit :
> I'm creating the DT for a custom platform based on Freescale MX28 CPU
> and I have some doubts about where to add some pin mux configurations:
> whether in imx28.dtsi or in my platform dts.
> 
> A pair of examples folow:
> 
> Example #1. My platform is using a valid IOMUX for DUART TX/RX lines
> which is not covered in imx28.dtsi, namely the I2C0 pins. Since this is
> a valid IOMUX that can be used by other platforms, I'd say I should
> included it in imx28.dtsi:
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 3fa6d19..8928b7b 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -186,6 +186,17 @@
>                                         fsl,pull-up = <0>;
>                                 };
> 
> +                               duart_pins_c: duart at 2 {
> +                                       reg = <2>;
> +                                       fsl,pinmux-ids = <
> +                                               0x3182 /*
> MX28_PAD_I2C0_SCL__DUART_RX */
> +                                               0x3192 /*
> MX28_PAD_I2C0_SDA__DUART_TX */
> +                                       >;
> +                                       fsl,drive-strength = <0>;
> +                                       fsl,voltage = <1>;
> +                                       fsl,pull-up = <0>;
> +                               };
> +
>                                 duart_4pins_a: duart-4pins at 0 {
>                                         reg = <0>;
>                                         fsl,pinmux-ids = <

That's right.

> Example #2. My platform assembles a NAND chip which is powered at 1.8V.
> The imx28.dtsi has a configuration 'gpmi_pins_a: gpmi-nand at 0' that
> configures the pins at 3.3V.
> Should I create another entry here 'gpmi_pins_b: gpmi-nand at 1' with
> fsl,voltage = <0>; or should I create a specific entry in my platform's
> DT instead?
> What is the convention?

Since it's the same pinset, I'd rather go for using gpmi_pins_a in your
NAND chip node, but also overload the fsl,voltage property of
gpmi_pins_a in your board device tree.

That would give something like

pinctrl at 80018000 {
	gpmi_pins_a: gpmi-nand at 0 {
		fsl,voltage = <0>;
	};
};

nand at deadbeef {
	pinctrl-names = "default";
	pinctrl-0 = <&gpmi_pins_a>;
}

But maybe Sascha will have a different view on this.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
