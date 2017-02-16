From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 16 Feb 2017 07:17:54 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <20170210085920.7l7gswm6yjuqgdfx@lukather>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
Message-ID: <20170216061753.sd7zjs5jzdingufp@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 09:59:20AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Feb 09, 2017 at 12:34:06AM +0100, Rask Ingemann Lambertsen wrote:
> > The Suncip CX-A99 board is found in at least four brands of media players.
> > It features an Allwinner A80 ARM SoC and is found in two models:
> > 
> > 1) 2 GiB DDR3 DRAM and 16 GB eMMC
> > 2) 4 GiB DDR3 DRAM and 32 GB eMMC
> > 
> > For details of the board, see the linux-sunxi page
> > <URL:https://linux-sunxi.org/Sunchip_CX-A99>.
> 
> Please don't put URLs in commit logs (and the DT).

OK.

> > Supported features (+ means tested):
> > + One Cortex-A7 CPU core (or four with experimental U-Boot PSCI patches)
> > + AXP808 power management chip
> > + OZ80120 voltage regulator
> > + Serial console port (internal)
> > + eMMC and SD card slot
> > + USB 2.0 host ports on on-board USB hub
> > + SATA port on on-board SATA-to-USB bridge *
> > + IEEE 802.11 a/b/g/n/ac SDIO Wifi
> > + Real-time clock
> > + LEDs
> > - IR receiver for remote control
> > 
> > * Only shows up when a SATA device is connected. Also, if a power source
> >   is connected to the USB 3.0 connector across power cycles (e.g. FEL
> >   boot), the bridge may not properly reset and not show up on the USB bus.
> >   The vendor U-Boot performs some unknown magic which resets the bridge.
> 
> Is that magic at the USB level, or specific to the bridge itself?

I don't know, but since the other USB port connected to the hub comes up
fine, I'm assuming it's something to do with the SATA-to-USB bridge.

> > diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> > new file mode 100644
> > index 0000000..f5496d2
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
[...]
> > +	/* USB 3.0 standard-A receptacle. For now, only Vbus is supported. */
> 
> I'm not sure what you mean by "only VBUS is supported"? Is there any
> other signal?

I'm just trying to say that at the moment, all the connector will do is to
supply power to a connected device (for charging batteries or whatever).

> > +	reg_usb0_vbus: regulator-usb0-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb0-vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;	/* PH15 */
> > +		enable-active-high;
> 
> This is redundant with the GPIO flag

No. I have now tested without "enable-active-high" and then Vbus stays off.
This is also in line with the binding documentation:

"- enable-active-high: Polarity of GPIO is Active high
 If this property is missing, the default assumed is Active low."

It also seems to me that the way this is implemented in Linux, the GPIO
polarity flag is ignored.

> > +		regulator-always-on;
> 
> And it shouldn't be always on. The USB driver will enable it if needs
> be.

Yes, we just don't have a driver for the A80 USB 3.0 port yet.

> > +	/*
> > +	 * A GL850G hub with two external USB connectors is connected
> > +	 * to ehci0. Each has a Vbus regulator controlled by a GPIO:
> > +	 * PL7 for port 1, closest to the 12 V power connector, and
> > +	 * PL8 for port 2, next to the SD card slot.
> > +	 * Because regulator-fixed doesn't support a GPIO list, and
> > +	 * allwinner,sun9i-a80-usb-phy doesn't support more than one
> > +	 * supply, we have to use regulator-always-on on usb1-2-vbus.
> > +	 * Note that the GPIO pins also need cldo1 to be enabled.
> > +	 */
> 
> What is the source of those regulators connected then? Some PMIC
> regulator? AC-IN?

These two regulators are supplied from a fixed 12 V to 5 V DC-DC converter
which can't be controlled in any way.

> > +	reg_usb1_1_vbus: regulator-usb1-1-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb1-1-vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;	/* PL7 */
> > +		enable-active-high;
> > +	};
> > +
> > +	reg_usb1_2_vbus: regulator-usb1-2-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb1-2-vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
> > +		enable-active-high;
> > +		regulator-always-on;
> 
> Same comment about always on. If the driver needs fixing to grab an
> additional regulator, fix it, but this shouldn't be left that way.

I agree, but a lot of work is missing to get to that point. To get the USB
ports up and running, you need to enable quite a few regulators:
1. VDD09-USB for the controller internals.
2. VCC33-USB for the PHY.
3. Vbus for each connector belonging to the controller.
4. Pin group supply for the GPIO pins controlling each of the Vbus supplies.

Nobody seems to have thought about the first and the last two supplies when
the bindings were written. In this case, 1, 2 and 4 will be connected to
always-on regulators anyway. Getting support for multiple Vbus supplies
probably needs something along the lines of what was discussed with your
coupled regulator patches:

https://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398862.html
https://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/405401.html
https://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/466207.html

> > +	/* OZ80120 voltage regulator for the four Cortex-A15 cores. */
> > +	reg_vdd_cpub: regulator-vdd-cpub {
> > +		compatible = "regulator-gpio";
> > +
> > +		regulator-always-on;
> > +		regulator-min-microvolt = < 800000>;
> > +		regulator-max-microvolt = <1100000>;
> > +		regulator-name = "vdd-cpub";
> > +
> > +		enable-gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>;	/* PL2 */
> > +		enable-active-high;
> > +		gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>,		/* PL3 */
> > +			<&r_pio 0 4 GPIO_ACTIVE_HIGH>,		/* PL4 */
> > +			<&r_pio 0 5 GPIO_ACTIVE_HIGH>;		/* PL5 */
> > +
> > +		gpios-states = <1 0 0>;
> > +		states = <	 750000 0x7
> > +				 800000 0x3
> > +				 850000 0x5
> > +				 900000 0x1
> > +				 950000 0x6
> > +				1000000 0x2
> > +				1100000 0x4
> > +				1200000 0x0>;
> 
> You're listing a minimum state of 750mv, yet your minimum voltage is
> 800mV.

Yes. The regulator is capable of outputting the listed voltages in the
750 mV to 1200 mV range, but the permissible range of the consumer is only
800 mV to 1100 mV according to the A80 data sheet. Likewise, the AXP806
regulators support a larger voltage range than that of the connected
consumers.

> > +/* Ampak AP6335 IEEE 802.11 a/b/g/n/ac "Wifi". */
> 
> Why "wifi" ? It's not implementing true wifi?

I put quotes around it because the proper spelling is Wi-Fi, but since that
is a trademark, most people use the term Wifi capitalised in one way or
another (or sometimes not). Grepping the other dts files, it seems customary
to leave out the quotes, so I'll do the same.

> > +&mmc1 {
> > +	bus-width = <4>;
> > +	non-removable;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> > +	vmmc-supply = <&reg_cldo3>;	/* See cldo2,cldo3 note. */
> > +	vqmmc-supply = <&reg_aldo2>;
> 
> So it's able to support 1.2 or 1.8V IO modes? Surely you want to
> enable those modes here to.

Thanks for the hint. I thought the driver would automatically detect that.
The following modes are supported according to the data sheet:

* DS: Default speed up to 25MHz (3.3V signaling).
* HS: High speed up to 50MHz (3.3V signaling).
* SDR12: SDR up to 25MHz (1.8V signaling).
* SDR25: SDR up to 50MHz (1.8V signaling).
* SDR50: SDR up to 100MHz (1.8V signaling).
* SDR104: SDR up to 208MHz (1.8V signaling).
* DDR50: DDR up to 50MHz (1.8V signaling).

Unfortunately, when I enable the 1.8 V modes, or even just SDR-12, the
device fails to initialise with error -110 (-ETIMEDOUT). I will take a look
at that, but no promises.

> > +	pmic at 745 {
> > +		compatible = "x-powers,axp808", "x-powers,axp806";
> > +		reg = <0x745>;
> > +		interrupt-parent = <&nmi_intc>;
> > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +
> > +		swin-supply = <&reg_dcdce>;
> 
> Please use an incude for that PMIC.

I don't understand. What would that include file contain? Very few lines
would be shared between .dts files. You could save < 8 lines total if you
#include the 5 lines that are common between the Cubieboard4, the Optimus
and this board.

> > +		/* In comments: Initial setup from vendor sys_config.fex. */
> > +		regulators {
> > +			/* 3.0 V (enabled). */
> 
> This might be disabled though.

Indeed it is currently disabled by the kernel during startup, as there are
no consumers listed in the device tree. I don't know what that regulator
supplies, and it is on my to-do list for probing the next time that I have
the heat sink off the board.

> > +			/* 1.8 V (enabled). */
> > +			reg_aldo2: aldo2 {
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3600000>;
> > +				regulator-name = "vcc-pg-pm-wifi+btio-audio";
> 
> Usually, there is simpler names available on the schematics, or at
> least simpler names we can come up with.

I don't have schematics as it's not a developer board. V1.1 of the PCB,
which I have, doesn't even have the component names silkscreened onto it.

-- 
Rask Ingemann Lambertsen
