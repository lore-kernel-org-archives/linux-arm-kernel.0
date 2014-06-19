From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 22:05:20 -0500
Subject: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
In-Reply-To: <53A24A39.4080100@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-3-git-send-email-balbi@ti.com>
 <53A1BADD.7050309@ti.com> <20140618193113.GC4570@saruman.home>
 <53A20A7D.3060508@ti.com> <20140618231923.GA9855@saruman.home>
 <53A24A39.4080100@ti.com>
Message-ID: <20140619030520.GA13805@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 09:26:01PM -0500, Nishanth Menon wrote:
> On 06/18/2014 06:19 PM, Felipe Balbi wrote:
> [...]
> >>>>>Add support for TI's AM437x StarterKit Evaluation
> >>>>>Module.
> >>>>
> >>>>is there a link for this platform?
> >>>
> >>>internal only
> >>
> >>but will eventually be sold externally? I assume this is not an TI
> >
> >probably, but there's nothing public yet.
> >
> >>internal only board.
> >
> >correct assumption for all I know.
> 
> Yikes.. ok.. I'd let Tony et.al make the call on this, I guess.

would we really block a DTS just because there's no public wiki page
available (yet) ?

Sounds a bit extreme to me.

> >>>>>+	edt-ft5306 at 38 {
> >>>>>+		status = "okay";
> >>>>>+		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
> >>>>>+		pinctrl-names = "default";
> >>>>>+		pinctrl-0 = <&edt_ft5306_ts_pins>;
> >>>>>+		reg = <0x38>;
> >>>>>+		interrupt-parent = <&gpio0>;
> >>>>>+		interrupts = <31 0>;
> >>>>>+
> >>>>>+		wake-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> >>>>
> >>>>why wake-gpios? we should be using pinctrl with interrupt-extended to
> >>>>do wakeup sequence, no?
> >>>
> >>>sure, can you patch the edt driver ? I'll fix the DTS after that gets
> >>>merged
> >>
> >>If you really want to go down that road, so you could probably help
> >>review the pinctrl patches I posted to enable pinctrl wakeup[1]?
> >>
> >>Come on, as of today, there is no ability to suspend AM437x without
> >>doing [1], let alone talk about wakeup gpio vs interrupt-extended. and
> >>do we really want to wakeup from suspend when touch screen is touched?
> >>
> >>Do you expect wake-gpio to work even after doing interrupt based
> >>solution? I am no edt driver expert... maybe you can help me here.
> >
> >you missed the point entirely. This pin is not used for the touchscreen
> >to wake SoC up, it's the other way around, see how the pin is an
> >*output*. Pull it low and the touchscreen won't generate IRQs, won't
> >respond to i2c accesses, etc. Pull it high, and the thing wakes up.
> 
> Aaah.. My apologies.. I was confused. Thanks for clarifying.

np

> [...]
> >>>>>+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> >>>>>+};
> >>>>>+
> >>>>>+&usb2_phy1 {
> >>>>>+	status = "okay";
> >>>>>+};
> >>>>>+
> >>>>>+&usb1 {
> >>>>>+	dr_mode = "peripheral";
> >>>>>+	status = "okay";
> >>>>>+};
> >>>>>+
> >>>>>+&usb2_phy2 {
> >>>>>+	status = "okay";
> >>>>>+};
> >>>>>+
> >>>>>+&usb2 {
> >>>>>+	dr_mode = "host";
> >>>>>+	status = "okay";
> >>>>>+};
> >>>>none of the above need pinctrl? no regulator supplies?
> >>>
> >>>pins in default states, drivers don't use regulators.
> >>
> >>USB works without a supply? even a fixed voltage supply? that is
> >>weird.
> >
> >take a look at the minicom output I posted if you don't believe. Well,
> >to be exact, tps63010 [1] is the one which generates the regulated V5_0D
> >which is used as VBUS_USB. The enable pin in that device is tied to the
> >3v3 rail (dcdc4 regulator in the PMIC as most everything else) but
> >there's no way (otherwise) to control that thing. There's no control
> >bus, no way to write a driver.
> >
> >Since the board will anyways turn off if you disable the 3v3 rail, it's
> >pretty much pointless to figure out a hack just to add this to DTS.
> >
> >[1] http://www.ti.com/product/TPS63010
> 
> I am sure to trust you on the test log :) ->  but then from dts description
> perspective, it is good if we describe the supplies, even as a always on
> fixed-regulator. We had instances like 2430SDP ethernet where... umm... we
> originally missed describing ethernet supply and boom, one fine morning, no
> more nfs filesystem - I mean, it is a one off scenario there, but describing
> regulators helps us atleast understand the power tree of the board a little
> better.
> 
> Again, no strong opinions on my side, it is a good thing to do is all
> I feel about it.

you mean something like:

	V5_0D: fixedregulator at 0 {
		compatible = "regulator-fixed";
		regulator-name = "V5_0D";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-boot-on;
		regulator-always-on;
		vin-supply = <&dcdc4>;
	};

	VBUS_USB: fixedregulator at 1 {
		compatible = "regulator-fixed";
		regulator-name = "VBUS_USB";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-boot-on;
		regulator-always-on;
		vin-supply = <&V5_0D>;
	};

I can add that, but note that it's *solely* to make sysfs look nice. And
if that's the case, most likely *every* DTS file in tree today as
incomplete. OTOH, I really consider this to be hugely unnecessary
because of the fact that board will turn off if 3v3 (dcdc4) is disabled.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/afa0d569/attachment-0001.sig>
