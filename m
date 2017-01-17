From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 17 Jan 2017 23:26:21 +0100
Subject: [PATCH 0/5] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <CAFBinCDvtufXUxe+cRCzOKFtbOqS-xEr0Vp=_0S4Pn+sTPHOmg@mail.gmail.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <1484680984.26620.29.camel@baylibre.com>
 <CAFBinCDvtufXUxe+cRCzOKFtbOqS-xEr0Vp=_0S4Pn+sTPHOmg@mail.gmail.com>
Message-ID: <1484691981.26620.55.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-17 at 22:09 +0100, Martin Blumenstingl wrote:
> On Tue, Jan 17, 2017 at 8:23 PM, Jerome Brunet <jbrunet@baylibre.com>
> wrote:
> > 
> > On Sat, 2016-12-03 at 00:47 +0100, Martin Blumenstingl wrote:
> > > 
> > > This partially fixes the 1000Mbit/s ethernet TX throughput issues
> > > (on
> > > networks which are not affected by the EEE problem, as reported
> > > here:
> > > [1]).
> > > The actual problem for the TX throughput issues was that the TX
> > > delay
> > > was applied twice:
> > > - once "accidentally" by the PHY (this was fixed with [2])
> > > - once by the MAC because there was a hardcoded TX delay (of
> > > 2ns),
> > > ? this will be configurable with the changes from [0]
> > > 
> > > These are the dts changes which belong to my other series (in v2
> > > these patches were part of the other series, upon request of the
> > > net maintainers I have split the .dts changes into their own
> > > series
> > > so
> > > we are able to take both through different trees):
> > > "[PATCH net-next v3 0/2] stmmac: dwmac-meson8b: configurable
> > > RGMII TX delay": [0].
> > > Thus this series depends on the ACK for the binding changes in
> > > the
> > > other series!
> > > 
> > > I based these changes on my other series "[PATCH v2 0/2] GXL and
> > > GXM
> > > SCPI improvements": [3]
> > > 
> > > 
> > > [0] http://lists.infradead.org/pipermail/linux-amlogic/2016-Decem
> > > ber/
> > > 001834.html
> > > [1] http://lists.infradead.org/pipermail/linux-amlogic/2016-Novem
> > > ber/
> > > 001607.html
> > > [2] http://lists.infradead.org/pipermail/linux-amlogic/2016-Novem
> > > ber/
> > > 001707.html
> > > [3] http://lists.infradead.org/pipermail/linux-amlogic/2016-Decem
> > > ber/
> > > 001831.html
> > > 
> > > Martin Blumenstingl (5):
> > > ? ARM64: dts: meson-gx: move the MDIO node to meson-gx
> > 
> > Sorry for the late reply, I've only been able to test this
> > yesterday.
> > 
> > With "snps,dwmac-mdio" provided in meson-gx.dtsi, the mdio_node is
> > defined in stmmac_mdio_register and auto-detection of the PHY is
> > disabled for all meson-gx boards.
> > 
> > I wonder if this is desirable ? or maybe this something we could
> > fix in
> > stmmac ? (perform auto-detect the mdio bus is provided without a
> > PHY)
> actually it's only a "problem" when introducing support for new
> devices. can you please forward this question to the stmmac
> maintainers, as I think your idea of enabling auto-detection when
> there are no children in the MDIO-bus makes sense

That's one way to address the issue, sure. I just wonder if we should
keep the declaration of the mdio bus with "snps,dwmac-mdio" in the dts
using it, with the phy explicitly declared ...

Otherwise, we have to make clear that you must always explicitly
declare your PHY in amlogic's dts so there is no surprise.

As you mentioned, we missed the gxbb-nexbox-a95. No phy declared in
that dts, but it still get the mdio bus from meson-gx.dtsi. So as of
"ARM64: dts: meson-gx: move the MDIO node to meson-gx" the PHY is not
detected on this board.

> 
> > 
> > Also, I think bisect is broken between patch 1 and patch 4: The PHY
> > of
> > some boards won't be detected between these patches. Should we
> > squash
> > them ?
> what do you mean exactly? currently the TX-delay is hardcoded in
> dwmac-meson8b. patch 4 moves the hardcoded value from the
> dwmac-meson8b to the .dts-files.
> unfortunately the corresponding dwmac-meson8b patch was not accepted
> yet, so at the moment patch 4 should be a no-op.

Nothing related to the tx-delay ... I'm all for it ;) Thx for your work
by the way

What I meant is that as of "ARM64: dts: meson-gx: move the MDIO node to
meson-gx" all boards not declaring the PHY explicitly can't detect it
anymore. that's more or less all gxbb boards

With "ARM64: dts: meson-gxbb-odroidc2: add reset for the ethernet PHY"
the odroid gets fixed ... but the p200 and vega-s95 are still broken?

With the next patch, the p200 is/should have been fixed, then the vega-
s95 is fixed?

In the end the gxbb-nexbox is still broken. To be honest I did not
verify if there any other board in that case.

My point is that I think the declaration of the mdio bus in meson-
gx.dtsi and the declaration of each PHY in the board dtss should be
done in single commit to avoid having a (very) short part of the
history with regressions

> 
> > 
> > > 
> > > ? ARM64: dts: meson-gxbb-odroidc2: add reset for the ethernet PHY
> > > ? ARM64: dts: meson-gxbb-p20x: add reset for the ethernet PHY
> > > ? ARM64: dts: meson-gxbb-vega-s95: add reset for the ethernet PHY
> > > ? ARM64: dts: amlogic: add the ethernet TX delay configuration
> > > 
> > 
> > Last remark, about the use of ethernet-phy-idXXXX.XXXX in the
> > odroid
> > and the vega: Isn't it better to let phylib do the autodetection of
> > the
> > phy id ?
> > 
> > If we want to specify the id in DT, we should probably add it for
> > the
> > Micrel PHY of the p200 as well, for consistency.
> this seems to be a "best practice" when the PHY ID is known, see [0]
> If you know the PHY ID of the Micrel PHY then please let me know,
> then
> we can include this in the fix for the p20x boards

OK

> 
> > 
> > > 
> > > ?arch/arm64/boot/dts/amlogic/meson-gx.dtsi????????????|??6 ++++++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts??| 17
> > > +++++++++++++++++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi?????| 17
> > > +++++++++++++++++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 17
> > > +++++++++++++++++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts |??2 ++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxl.dtsi???????????|??6 ------
> > > ?arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts??|??2 ++
> > > ?arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts??|??2 ++
> > > ?8 files changed, 63 insertions(+), 6 deletions(-)
> > > 
> 
> [0] http://lxr.free-electrons.com/source/Documentation/devicetree/bin
> dings/net/phy.txt#L22
