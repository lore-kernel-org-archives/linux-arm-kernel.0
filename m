From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 18:19:23 -0500
Subject: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
In-Reply-To: <53A20A7D.3060508@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-3-git-send-email-balbi@ti.com>
 <53A1BADD.7050309@ti.com> <20140618193113.GC4570@saruman.home>
 <53A20A7D.3060508@ti.com>
Message-ID: <20140618231923.GA9855@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 04:54:05PM -0500, Nishanth Menon wrote:
> On 06/18/2014 02:31 PM, Felipe Balbi wrote:
> >On Wed, Jun 18, 2014 at 11:14:21AM -0500, Nishanth Menon wrote:
> >>On 06/18/2014 10:43 AM, Felipe Balbi wrote:
> >>>Add support for TI's AM437x StarterKit Evaluation
> >>>Module.
> >>
> >>is there a link for this platform?
> >
> >internal only
> 
> but will eventually be sold externally? I assume this is not an TI

probably, but there's nothing public yet.

> internal only board.

correct assumption for all I know.

> [...]
> >>>+
> >>>+	matrix_keypad: matrix_keypad at 0 {
> >>>+		compatible = "gpio-matrix-keypad";
> >>
> >>no pinctrl needed?
> >
> >pins are gpio by default
> 
> Might be good to explicitly configure it - no strong opinions though
> -> GPIOs are always good to pinctrl up esp if bootloader screws up at
> a later date.

I find that very unlikely and don't quite like the idea of accessing
registers unnecessarily. OTOH, I don't quite care, to be frank.

> >>>+&i2c0 {
> >>>+        status = "okay";
> >>>+        pinctrl-names = "default";
> >>>+        pinctrl-0 = <&i2c0_pins>;
> >>
> >>what speed are you running this on? -> also can you align these to 1
> >
> >100kHz ?
> 
> Rule of thumb is to do the following: MIN(MAX_FREQ(D1),
> MAX_FREQ(D2).... MAX_FREQ(Dn)); where D1..n are all the peripherals on
> this i2c bus.

hehe, right.

> >>>+		interrupt-controller;
> >>>+		#interrupt-cells = <2>;
> >>>+
> >>>+		dcdc1: regulator-dcdc1 {
> >>>+			compatible = "ti,tps65218-dcdc1";
> >>>+			/* VDD_CORE limits min of OPP50 and max of OPP100 */
> >>>+			regulator-name = "vdd_core";
> >>>+			regulator-min-microvolt = <912000>;
> >>>+			regulator-max-microvolt = <1144000>;
> >>>+			regulator-boot-on;
> >>>+			regulator-always-on;
> >>>+		};
> >>>+
> >>>+		dcdc2: regulator-dcdc2 {
> >>>+			compatible = "ti,tps65218-dcdc2";
> >>>+			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
> >>>+			regulator-name = "vdd_mpu";
> >>>+			regulator-min-microvolt = <912000>;
> >>>+			regulator-max-microvolt = <1378000>;
> >>>+			regulator-boot-on;
> >>>+			regulator-always-on;
> >>>+		};
> >>>+
> >>>+		dcdc3: regulator-dcdc3 {
> >>>+			compatible = "ti,tps65218-dcdc3";
> >>>+			regulator-name = "vdds_ddr";
> >>no voltage ?
> >
> >has no users in kernel. Also, it comes out with default, and correct,
> >voltage.
> 
> Device tree is description of hardware, not just who uses what in OS
> of interest.

then we should start "fixing" every single DTS in the kernel because I'm
sure even LEDs and keypads are tied to some sort of supply, as is the
case with this board. No driver will use it though.

Also, I couldn't find anywhere which voltage is dcdc3 outputing and
there's no shunt anywhere (other than a 0 ohm resistor) to measure
voltage. So I kinda have my hands tied here.

(goes review schematics)

actually there's 0.05 ohm sense resistor. Hopefully it's easy to access.

> you might consider u-boot to use the same device tree at a later date and
> having complete details about the hardware is always the norm.
> 
> I suggest setting the voltage here to be complete even if there are no
> current users.
> 
> >>>+	edt-ft5306 at 38 {
> >>>+		status = "okay";
> >>>+		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
> >>>+		pinctrl-names = "default";
> >>>+		pinctrl-0 = <&edt_ft5306_ts_pins>;
> >>>+		reg = <0x38>;
> >>>+		interrupt-parent = <&gpio0>;
> >>>+		interrupts = <31 0>;
> >>>+
> >>>+		wake-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> >>
> >>why wake-gpios? we should be using pinctrl with interrupt-extended to
> >>do wakeup sequence, no?
> >
> >sure, can you patch the edt driver ? I'll fix the DTS after that gets
> >merged
> 
> If you really want to go down that road, so you could probably help
> review the pinctrl patches I posted to enable pinctrl wakeup[1]?
> 
> Come on, as of today, there is no ability to suspend AM437x without
> doing [1], let alone talk about wakeup gpio vs interrupt-extended. and
> do we really want to wakeup from suspend when touch screen is touched?
> 
> Do you expect wake-gpio to work even after doing interrupt based
> solution? I am no edt driver expert... maybe you can help me here.

you missed the point entirely. This pin is not used for the touchscreen
to wake SoC up, it's the other way around, see how the pin is an
*output*. Pull it low and the touchscreen won't generate IRQs, won't
respond to i2c accesses, etc. Pull it high, and the thing wakes up.

> >>>+&mmc1 {
> >>>+	status = "okay";
> >>>+	vmmc-supply = <&dcdc4>;
> >>>+	bus-width = <4>;
> >>>+	pinctrl-names = "default";
> >>>+	pinctrl-0 = <&mmc1_pins>;
> >>
> >>just for style, wonder if moving the pinctrl just after status is better?
> >
> >why ? makes no difference.
> 
> it does not - I agree, except, when you look at all other nodes:
> status="okay"
> pinctrl
> other things..
> 
> it is just a symmetry thing, I guess..

little bit of ocd, but sure.

> >>>+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> >>>+};
> >>>+
> >>>+&usb2_phy1 {
> >>>+	status = "okay";
> >>>+};
> >>>+
> >>>+&usb1 {
> >>>+	dr_mode = "peripheral";
> >>>+	status = "okay";
> >>>+};
> >>>+
> >>>+&usb2_phy2 {
> >>>+	status = "okay";
> >>>+};
> >>>+
> >>>+&usb2 {
> >>>+	dr_mode = "host";
> >>>+	status = "okay";
> >>>+};
> >>none of the above need pinctrl? no regulator supplies?
> >
> >pins in default states, drivers don't use regulators.
> 
> USB works without a supply? even a fixed voltage supply? that is
> weird.

take a look at the minicom output I posted if you don't believe. Well,
to be exact, tps63010 [1] is the one which generates the regulated V5_0D
which is used as VBUS_USB. The enable pin in that device is tied to the
3v3 rail (dcdc4 regulator in the PMIC as most everything else) but
there's no way (otherwise) to control that thing. There's no control
bus, no way to write a driver.

Since the board will anyways turn off if you disable the 3v3 rail, it's
pretty much pointless to figure out a hack just to add this to DTS.

[1] http://www.ti.com/product/TPS63010

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/06eacdea/attachment-0001.sig>
