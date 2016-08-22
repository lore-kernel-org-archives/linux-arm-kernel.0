From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Mon, 22 Aug 2016 23:29:59 +0200
Subject: [PATCH v4 3/3] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <20160822185745.GC7104@lukather>
References: <9f39145aa6a46a1e130c4b91bd120eabeb7c8929.1471637309.git.ccc94453@vip.cybercity.dk>
 <ce704da79c6263a4a5048af8f8e90f22e0849188.1471637309.git.ccc94453@vip.cybercity.dk>
 <20160822185745.GC7104@lukather>
Message-ID: <20160822212959.yvr7abaclynxm5ta@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 08:57:45PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Aug 13, 2016 at 12:03:57AM +0200, Rask Ingemann Lambertsen wrote:
> > The Suncip CX-A99 board is found in at least four brands of TV boxes.
> > It features an Allwinner A80 SOC, with either 2 GiB DDR3 DRAM and
> > 16 GB eMMC or 4 GiB DDR3 DRAM and 32 GB eMMC, as well as several support
> > chips for Ethernet, wireless networking, video output, SATA and power
> > management. For details, see the linux-sunxi page about the board
> > <URL:https://linux-sunxi.org/Sunchip_CX-A99>.
> > 
> > This patch only adds support for the SD and eMMC storage, real-time clock,
> > USB 2.0 ports (and by extension the SATA port), the UART port and the LEDs.
> > All of this relies on the boot loader to leave those parts powered up, as
> > I'm still working on a driver for the AXP808 PMIC.
> > 
> > Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
> 
> It looks mostly good, but I have a couple of comments though, see below.
> 
> > ---
> > 
> > Although the vendor U-Boot lets you boot the kernel on one of the
> > Cortex-A15 cores, the kernel gpio-regulator driver currently glitches
> > the GPIO lines to the OZ80120 regulator such that the system crashes
> > during startup. This part needs further work to be useful.
> 
> So it doesn't power the CPU through one of the AXP regulators?
> Interesting design.

The Cortex-A7 cores are powered by the dcdca regulator on the AXP 808 PMIC.
Right now, I'm using the AXP 806 driver that Chen-Yu Tsai posted to drive
the AXP 808 and so far, it looks good.

[snip]
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&led_pins_cx_a99>;
> > +
> > +		blue {
> > +			gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;	/* PG10 */
> > +			label = "cx-a99:blue:normal";
> > +			default-state = "on";
> > +		};
> > +
> > +		red {
> > +			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;	/* PG11 */
> > +			label = "cx-a99:red:standby";
> 
> The last part of the label should be the function.

I'm not sure what else to label them. They form a bi-colour LED emitting
through the front of the device. The stock OS lights the blue LED when
the device is powered on and lights the red LED when the device is
suspended. There is no label on the front of the device telling what the
colours mean. Documentation/devicetree/bindings/leds/common.txt and
Documentation/devicetree/bindings/leds/leds-gpio.txt don't provide much in
the way of examples. Suggestions are welcome.

[snip]
> > +
> > +/* Each GPIO controls VBUS for a port on the GL850G hub connected to ehci0;
> > + * PL7 for port 1, the USB connector closest to the 12 V power connector, and
> > + * PL8 for port 2, the USB connector next to the (micro)SD card slot.
> > + * Note: The regulators are not chained like this in reality, but
> > + * regulator-fixed doesn't support a gpio list, and allwinner,sun9i-a80-usb-phy
> > + * doesn't support more than one supply, so this will have to do (for now).
> > + */
> > +&reg_usb1_vbus {
> > +	pinctrl-0 = <&usb1_vbus_r_pin_cx_a99>;
> > +	gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;	/* PL7 */
> > +	status = "okay";
> > +};
> > +
> > +&reg_usb2_vbus {
> > +	pinctrl-0 = <&usb2_vbus_r_pin_cx_a99>;
> > +	gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */
> 
> I'd really prefer it to be modelled properly, and not attached to the
> wrong device.
> 
> I have some work pending to allow multiple regulators in the same
> property, but that won't be ready soon.
> 
> For the time being, I would suggest having two usb1 regulators
> defined, each with their respective GPIOs, and one set to always on
> (and keep that great comment).

Will do if I don't come up with something better. I gave it a shot to
describe the hub as a child of ehci0 with a child node for each of the
two ports, but it didn't work.

Also, using the phy-supply property for the vbus-supply is an ugly hack,
in the first place, isn't it? Shouldn't it be more like this?

&usbphy1 {
	phy-supply = <&reg_vcc33_usbh>;
};

&ehci0 {
	vcc-supply = <&reg_vdd09_usbh>;
	phy = <&usbphy1>;

	hub at 1 {
		port at 1 {
			vbus-supply = <&reg_usb1_vbus>;
		}

		port at 2 {
			vbus-supply = <&reg_usb2_vbus>;
		}
	};
};

It would generally be great to be able to describe regulators that should
be kept in sync, because the Wifi+BT module's Vbat pin is supplied by two
regulators in parallel. IIRC, Hans de Goede ran into that as well on one
of his boards.

-- 
Rask Ingemann Lambertsen
