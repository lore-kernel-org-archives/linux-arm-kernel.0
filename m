From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Feb 2014 10:44:06 +0100
Subject: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
In-Reply-To: <52EF70E2.6070803@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
 <20140131134505.GG2950@lukather> <52EF70E2.6070803@redhat.com>
Message-ID: <20140204094406.GM25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 11:35:14AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 01/31/2014 02:45 PM, Maxime Ripard wrote:
> >Hi Hans,
> >
> >On Wed, Jan 22, 2014 at 08:04:48PM +0100, Hans de Goede wrote:
> >>From: Oliver Schinagl <oliver@schinagl.nl>
> >>
> >>This patch adds sunxi sata support to A10 boards that have such a connector.
> >>Some boards also feature a regulator via a GPIO and support for this is also
> >>added.
> >>
> >>Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
> >>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
> >>  arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
> >>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++++++++
> >
> >I'm still half convinced about this at the moment, given the number of
> >platforms we support, we can always change it back if things become too messy.
> 
> I assume that this == sunxi-ahci-reg.dtsi ?  To be sure I understand
> you correctly, you're ok with going this route for now, right ?

Yep.

> How about the same for the usb ohci/ehci controller dts patches ? Currently they
> are still using the put a regulator node in each dts file model, which leads to
> a lot of boilerplate code. So I would like to move to the same model as I'm
> using here for the sata supply.

That would make sense too.

> >>  4 files changed, 56 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> >>
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>index aef8207..3fb7305 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>@@ -48,6 +48,10 @@
> >>  			status = "okay";
> >>  		};
> >>
> >>+		ahci: sata at 01c18000 {
> >>+			status = "okay";
> >>+		};
> >>+
> >>  		pinctrl at 01c20800 {
> >>  			mmc0_cd_pin_a1000: mmc0_cd_pin at 0 {
> >>  				allwinner,pins = "PH1";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> >>index f50fb2b..6ae1110 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> >>@@ -12,6 +12,7 @@
> >>
> >>  /dts-v1/;
> >>  /include/ "sun4i-a10.dtsi"
> >>+/include/ "sunxi-ahci-reg.dtsi"
> >>
> >>  / {
> >>  	model = "Cubietech Cubieboard";
> >>@@ -51,6 +52,11 @@
> >>  			status = "okay";
> >>  		};
> >>
> >>+		ahci: sata at 01c18000 {
> >>+			target-supply = <&reg_ahci_5v>;
> >>+			status = "okay";
> >>+		};
> >>+
> >>  		pinctrl at 01c20800 {
> >>  			mmc0_cd_pin_cubieboard: mmc0_cd_pin at 0 {
> >>  				allwinner,pins = "PH1";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> >>index 4736dd2..198dcda 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10.dtsi
> >>+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> >>@@ -331,6 +331,14 @@
> >>  			status = "disabled";
> >>  		};
> >>
> >>+		ahci: sata at 01c18000 {
> >>+			compatible = "allwinner,sun4i-a10-ahci";
> >
> >To be consistent with the rest of the sun4i devices compatible, It
> >should be sun4i-ahci.
> >
> >However, since these devices don't use the same compatible pattern as
> >their own machine compatible, and are consisent with the rest of the
> >compatibles for the other SoCs, we can probably make this a go to
> >transition progressively to this pattern.
> 
> Ack, I think it would be good to be consistent and try to use
> sun?i-aXX-foo everywhere. I noticed that we already use that in various
> places, so I thought it would be good to do that for all new dts bindings.

Yes, that's my plan.

> >I'll cook up some patches for the other devices.
> 
> Thanks.

And I sent them on sunday.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/a627150d/attachment-0001.sig>
