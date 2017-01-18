From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 18 Jan 2017 11:36:09 +0100
Subject: [PATCH 3/5] ARM64: dts: meson-gxbb-p20x: add reset for the
 ethernet PHY
In-Reply-To: <CAFBinCBfJ4b1a1Bqn7kJHyj79i8UJnjJh00u3NvARzJPuUmrNA@mail.gmail.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <20161202234739.22929-4-martin.blumenstingl@googlemail.com>
 <1484680941.26620.28.camel@baylibre.com>
 <CAFBinCBfJ4b1a1Bqn7kJHyj79i8UJnjJh00u3NvARzJPuUmrNA@mail.gmail.com>
Message-ID: <1484735769.26620.69.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-17 at 22:26 +0100, Martin Blumenstingl wrote:
> On Tue, Jan 17, 2017 at 8:22 PM, Jerome Brunet <jbrunet@baylibre.com>
> wrote:
> > 
> > On Sat, 2016-12-03 at 00:47 +0100, Martin Blumenstingl wrote:
> > > 
> > > This resets the ethernet PHY during boot to get the PHY into a
> > > "clean"
> > > state. While here also specify the phy-handle of the ethmac node
> > > to
> > > make the PHY configuration similar to the one we have on GXL
> > > devices.
> > > 
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemai
> > > l.co
> > > m>
> > > Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> > > ---
> > > ?arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 15
> > > +++++++++++++++
> > > ?1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> > > b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> > > index 203be28..2abc553 100644
> > > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> > > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> > > @@ -134,10 +134,25 @@
> > > ??????pinctrl-names = "default";
> > > ?};
> > > 
> > > +&mdio0 {
> > > +?????ethernet_phy0: ethernet-phy at 0 {
> > > +?????????????compatible = "ethernet-phy-ieee802.3-c22";
> > > +?????????????reg = <0>;
> > 
> > Sorry for the late reply.
> > I just tried on the p200 and this patch (serie) breaks the network
> > on
> > it. The PHY is not detected anymore.
> > 
> > From the KSZ9031 Datasheet : "PHY Address 0h is supported as the
> > unique
> > PHY address only; it is not supported as the broadcast PHY address
> > [...]"
> > 
> > So we can't just use the broadcast address here:
> > reg should be <3>.
> OK, I'll fix that in a follow-up. as mentioned in the other thread:
> can you confirm that the PHY ID is 0x00221620?

That's right.

> It seems that I also broke meson-gxbb-nexbox-a95x.dts with that
> series
> (no idea why that slipped through): according to the photos from
> Neil's wiki [0] this seems to use an IC+ 10/100 ethernet PHY
> (probably
> an IP101A)

IP101GR from what I can see on the board.

> 
> > 
> > > 
> > > +?????};
> > > +};
> > > +
> > > ?&ethmac {
> > > ??????status = "okay";
> > > ??????pinctrl-0 = <&eth_rgmii_pins>;
> > > ??????pinctrl-names = "default";
> > > +
> > > +?????phy-handle = <&ethernet_phy0>;
> > > +
> > > +?????snps,reset-gpio = <&gpio GPIOZ_14 0>;
> > > +?????snps,reset-delays-us = <0 10000 1000000>;
> > > +?????snps,reset-active-low;
> > > +
> > > +?????phy-mode = "rgmii";
> > 
> > We can't define this in p20x. actually the p201 uses an rmii.
> > I have not idea about gpio reset, or the phy address for the p201.
> > 
> > I suppose it would be better to move this to meson-gxbb_p200.dts
> > 
> > I don't know if anybody has a p201, but until we can confirm a
> > working
> > Ethernet configuration, we should probably drop it for the p201
> > 
> > Of course the problem was already there before this patch ...
> indeed, that seems to be a problem.
> the GXBB Nexbox A95x I mentioned above is based on the p201 board.
> Amlogic's .dts also toggles GPIOZ_14 for it: [1]
> chances are high that it also features an IP101A PHY (this is pure
> speculation though).

Agreed, chances are high it'll be this way.

> 
> I propose four patches to fix all this situation:
> - add the GPIOZ_14 reset and an ethernet_phy0 (with reg = <0>) to
> meson-gxbb-nexbox-a95x.dts
> - add the ethernet_phy0 node with reg = <0> (and ideally I also want
> to include the KSZ9031 PHY ID) to meson-gxbb-p200.dtsi along with
> phy-mode = "rgmii"

you mean with reg = <3> ?

> - add the ethernet_phy0 node with reg = <0> (without any PHY ID as we
> don't know which one is used) to meson-gxbb-p201.dtsi along with
> phy-mode = "rgmii"
> - remove "phy-mode" and ethernet_phy0 from meson-gxbb-p20x.dtsi and
> add a comment that both, the RGMII and the RMII PHY have GPIOZ_14
> connected to their reset line

I'm not too sure about these last 2 points. As you mentioned, we are
only speculating regarding the p201. I would prefer to avoid putting
things we are not sure about in the DT (as much as possible).

We could disable the ethernet for p201:
1) if nobody complains, situation remains unchanged, ethernet is not
working on that board
2) if someone complains, then we will be able to some facts from
him/her, and get it working properly.

After all, that's not a regression. With what we had in the meson-gxbb-
p20x.dtsi so far, ethernet never worked on that board.
?
> 
> does that make sense?
> 
> 
> Regards,
> Martin
> 
> 
> [0] https://github.com/superna9999/linux/wiki/Boards#nexbox-a95x-s905
> [1] https://github.com/khadas/linux/blob/Vim/arch/arm64/boot/dts/amlo
> gic/gxbb_p201.dts#L186
