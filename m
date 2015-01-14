From: lars.doelle@on-line.de (Lars Doelle)
Date: Wed, 14 Jan 2015 11:18:25 +0100
Subject: [linux-sunxi] Re: Including empty regulator nodes in axp209.dtsi
 is a BAD idea
In-Reply-To: <20150113164606.GA4891@lukather>
References: <54B4E7B5.6060304@redhat.com> <20150113164606.GA4891@lukather>
Message-ID: <5312007.HNApKlEIe7@x64.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 13, 2015 17:46:06 Maxime Ripard wrote:
> On Tue, Jan 13, 2015 at 10:39:01AM +0100, Hans de Goede wrote:
> > Hi ChenYu, Maxime,
> > 
> > During the review of a few dts files for new boards Maxime asked me to use
> > axp209.dtsi to avoid the standard axp209 "boilerplate" present in most
> > boards using the axp209 pmic.
> > 
> > But axp209.dtsi includes empty regulator nodes, e.g. :
> > 
> >                 reg_dcdc3: dcdc3 {
> >                         regulator-name = "dcdc3";
> >                 };
> > 
> > This is a BAD idea, the presence of these empty nodes causes the
> > axp20x-regulator driver to actually register regulators for them,
> > and then on late_init the regulator subsys turns them off, since
> > they have absolutely no constraints set (nor users registered)
> > and the regulator subsys assumes that when devicetree is used their
> > is always a compete set of constraints and that thus turning them
> > off is safe.
> > 
> > So when I switched to using axp209.dtsi for the bananapro.dts,
> > and booted the bananapro this is the last message I got from the
> > kernel while booting:
> > 
> > [    2.314014] dcdc3: disabling
> > 
> > And away went our DRAM power-supply, oops.
> > 
> > So for dcdc2 (CPU) and dcdc3 (DRAM), the boilerplate
> > should contain reasonable constraints (eg the operating range
> > from the datasheet)
> 
> Indeed.

It is very unclear to me, what to with this dtsi as it is.

Wrt. axp209, I have a specification like in sun7i-a20-olinuxino-lime2.dts.
If I include this dtsi, what does it help or how is it supposed to be of any
use?

In particular, the following section

|			axp209: pmic at 34 {
|				compatible = "x-powers,axp209";
|				reg = <0x34>;
|				interrupt-parent = <&nmi_intc>;
|				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;

|				interrupt-controller;
|				#interrupt-cells = <1>;

|				acin-supply = <&reg_axp_ipsout>;
|				vin2-supply = <&reg_axp_ipsout>;
|				vin3-supply = <&reg_axp_ipsout>;
|				ldo24in-supply = <&reg_axp_ipsout>;
|				ldo3in-supply = <&reg_axp_ipsout>;

would be needed anyway as it is not in sun7i-a20.dtsi, followed by the
regulators, to switch them on. Now a dtsi would make sense, if it shortens
the device specific information.

Should not the section above together with the full regulators be in axp209.dtsi
and only the regulators be mentioned in the boards dts, to switch them on? Isn't
this stuff that should be included in sun7i-a20.dtsi anyway, somehow?

Kind regards, Lars
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/f8972cc5/attachment.sig>
