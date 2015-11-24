From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Nov 2015 08:20:12 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for the
 lamobo-r1 board
In-Reply-To: <5652CE10.1020808@redhat.com>
References: <1448046713-13579-1-git-send-email-hdegoede@redhat.com>
 <20151122195925.GR32142@lukather> <5652CE10.1020808@redhat.com>
Message-ID: <20151124072012.GD32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 23, 2015 at 09:28:00AM +0100, Hans de Goede wrote:
> >>+&cpu0 {
> >>+	cpu-supply = <&reg_dcdc2>;
> >>+	operating-points = <
> >>+		/* kHz	  uV */
> >>+		960000	1400000
> >>+		912000	1400000
> >>+		864000	1350000
> >>+		720000	1250000
> >>+		528000	1150000
> >>+		312000	1100000
> >>+		144000	1050000
> >>+		>;
> >
> >Why are you using a custom set of OPPs here, the default ones were
> >unstable?
> 
> The fex file uses non standard OPPs, just like the bananapi, so I've
> done in the same in the dts, thinking "better safe then sorry" we
> can try without the custom OPPs if you want and see how that works.

Most of the time, when it comes to FEX, there's no standard OPP
actually. We've consolidated a set from most of the FEX files, and
it's the one that we have right now. Most of the time it works just
fine (the lime2 being the only exception), so I'd rather have you use
the generic ones, and if that proves to be unstable switch to some
custom ones.

> >>+&i2c0 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&i2c0_pins_a>;
> >>+	status = "okay";
> >>+
> >>+	axp209: pmic at 34 {
> >>+		reg = <0x34>;
> >>+		interrupt-parent = <&nmi_intc>;
> >>+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> >>+	};
> >>+};
> >>+
> >>+&i2c2 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&i2c2_pins_a>;
> >>+	status = "okay";
> >>+};
> >
> >What is connected on i2c2?
> 
> The Lamobo-R1 has a gpio header idententical to the one found
> on the Banana Pi, i2c2 is routed to pins there.

So it's just a generic header with the pins left as is, and it's up to
the user to plug something on it?

The policy we had so far for this was to not enforce anything for
these pins, and leave to the user the choice to to do whatever he
wanted.

> >Is i2c1 used at all?
> 
> Not to my knowledge.

Ack

> > Would it make sense to add aliases for the i2c buses as well?
> 
> I do not think anything would use those aliases, if we do
> this we should probably do it for all boards which have in i2c
> bus routed to some header pins.

What I wanted to avoid was to have the bus number changed if i2c1 was
going to be used at some point, but I doesn't seem to be the case
here, so everything's fine.

> 
> >>+&ir0 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&ir0_rx_pins_a>;
> >>+	status = "okay";
> >>+};
> >>+
> >>+&mmc0 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_lamobo_r1>;
> >>+	vmmc-supply = <&reg_vcc3v3>;
> >>+	bus-width = <4>;
> >>+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> >>+	cd-inverted;
> >>+	status = "okay";
> >>+};
> >>+
> >>+&ohci0 {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&ohci1 {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&otg_sram {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&pio {
> >>+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> >>+		allwinner,pins = "PH4";
> >>+		allwinner,function = "gpio_in";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> >>+	};
> >>+
> >>+	mmc0_cd_pin_lamobo_r1: mmc0_cd_pin at 0 {
> >>+		allwinner,pins = "PH10";
> >>+		allwinner,function = "gpio_in";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> >>+	};
> >>+
> >>+	gmac_power_pin_lamobo_r1: gmac_power_pin at 0 {
> >>+		allwinner,pins = "PH23";
> >>+		allwinner,function = "gpio_out";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>+	};
> >>+
> >>+	led_pins_lamobo_r1: led_pins at 0 {
> >>+		allwinner,pins = "PH24";
> >>+		allwinner,function = "gpio_out";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>+	};
> >>+};
> >>+
> >>+#include "axp209.dtsi"
> >>+
> >>+&reg_ahci_5v {
> >>+	gpio = <&pio 1 3 0>; /* PB3 */
> >>+	status = "okay";
> >>+};
> >>+
> >>+&reg_dcdc2 {
> >>+	regulator-always-on;
> >>+	regulator-min-microvolt = <1000000>;
> >>+	regulator-max-microvolt = <1400000>;
> >>+	regulator-name = "vdd-cpu";
> >>+};
> >>+
> >>+&reg_dcdc3 {
> >>+	regulator-always-on;
> >>+	regulator-min-microvolt = <1000000>;
> >>+	regulator-max-microvolt = <1400000>;
> >>+	regulator-name = "vdd-int-dll";
> >>+};
> >>+
> >>+&reg_ldo1 {
> >>+	regulator-name = "vdd-rtc";
> >>+};
> >>+
> >>+&reg_ldo2 {
> >>+	regulator-always-on;
> >>+	regulator-min-microvolt = <3000000>;
> >>+	regulator-max-microvolt = <3000000>;
> >>+	regulator-name = "avcc";
> >>+};
> >>+
> >>+&reg_usb0_vbus {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&reg_usb1_vbus {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&reg_usb2_vbus {
> >>+	status = "okay";
> >>+};
> >>+
> >>+&spi0 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&spi0_pins_a>,
> >>+		    <&spi0_cs0_pins_a>,
> >>+		    <&spi0_cs1_pins_a>;
> >>+	status = "okay";
> >>+};
> >
> >I guess the same question about i2c also applies for SPI :)
> 
> Answers are the same too :)

Yep :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/1ce44fc3/attachment.sig>
