From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 21:53:37 -0500
Subject: [linux-sunxi] Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add
 AXP209 support to various boards
In-Reply-To: <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
 <20140505225139.GD9464@lukather>
 <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
Message-ID: <20140508025337.GI7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 09:38:23AM +0200, Carlo Caione wrote:
> On Tue, May 6, 2014 at 12:51 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, May 03, 2014 at 02:21:06PM +0200, Carlo Caione wrote:
> >> On Sat, May 3, 2014 at 3:09 AM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi,
> >> >
> >> > On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
> >> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> >> Signed-off-by: Carlo Caione <carlo@caione.org>
> >> >> ---
> >> >>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 ++++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 ++++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 ++++++++++++++++++++++
> >> >>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++++++++
> >> >>  10 files changed, 602 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> >> index fa746aea..57d3fb4 100644
> >> >> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> >> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >> >> @@ -88,6 +88,56 @@
> >> >>                       pinctrl-names = "default";
> >> >>                       pinctrl-0 = <&i2c0_pins_a>;
> >> >>                       status = "okay";
> >> >> +
> >> >> +                     axp209: pmic at 34 {
> >> >> +                             compatible = "x-powers,axp209";
> >> >> +                             reg = <0x34>;
> >> >> +                             interrupts = <0>;
> >> >> +
> >> >> +                             interrupt-controller;
> >> >> +                             #interrupt-cells = <1>;
> >> >> +
> >> >> +                             acin-supply = <&reg_axp_ipsout>;
> >> >> +                             vin2-supply = <&reg_axp_ipsout>;
> >> >> +                             vin3-supply = <&reg_axp_ipsout>;
> >> >> +                             ldo24in-supply = <&reg_axp_ipsout>;
> >> >> +                             ldo3in-supply = <&reg_axp_ipsout>;
> >> >> +                             ldo5in-supply = <&reg_axp_ipsout>;
> >> >> +
> >> >> +                             regulators {
> >> >> +                                     x-powers,dcdc-freq = <1500>;
> >> >> +
> >> >> +                                     axp_vcore_reg: dcdc2 {
> >> >> +                                             regulator-min-microvolt = <700000>;
> >> >> +                                             regulator-max-microvolt = <2275000>;
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_ddr_reg: dcdc3 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_rtc_reg: ldo1 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_analog_reg: ldo2 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_pll_reg: ldo3 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_hdmi_reg: ldo4 {
> >> >> +                                             regulator-always-on;
> >> >> +                                     };
> >> >> +
> >> >> +                                     axp_mic_reg: ldo5 {
> >> >> +                                             regulator-always-on;
> >> >
> >> > Do all these regulators need to be always on? It makes sense for the
> >> > pll and vcore, but I don't get why the mic and hdmi regulators need
> >> > this.
> >>
> >> I did this way because I don't have the schematics for all the board
> >> so I thought it was safer to leave all the regulators enabled
> >
> > Well, we have the schematics for most of these boards (at least all
> > the cubie and olinuxinos).
> >
> > As far as the other boards are concerned, if we don't have that
> > information, I'd say leave them alone until someone has access to
> > these informations.
> 
> What do you mean exactly with "leave them alone". The problem is that
> if the regulator is not explicitly marked as always-on, it is disabled
> at boot time, so I think that the most safe thing to do is leave them
> on to avoid turning off something at boot time that could be
> important.

What I mean is that no information is still better than wrong
informations. If you don't have the schematics, then don't do anything
on this boards. Hopefully, someone with more infos on this will know
what to do.

Moreover, I have the feeling that you just copy pasted all the
informations on this patch. The first example I'm seeing is the
cubieboard, for which we do have the schematics, and this patch says
that ldo4 is used for HDMI, and that is required to stays always on,
while LDO4 doesn't seem to be used at all, and that HDMI takes
directly its input source from DC-5V.

I guess you need some more refining on this patch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/f95fdaa3/attachment.sig>
