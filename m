From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 15:29:26 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150608140256.GA10354@ulmo.nvidia.com>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
 <20150605231058.GQ7557@n2100.arm.linux.org.uk>
 <20150608140256.GA10354@ulmo.nvidia.com>
Message-ID: <20150608142926.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 04:02:58PM +0200, Thierry Reding wrote:
> On Sat, Jun 06, 2015 at 12:10:58AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> > > Hi Thierry
> > > 
> > > Am Freitag, 5. Juni 2015, 13:02:01 schrieb Thierry Reding:
> > > > If this is specific to the Rockchip implementation, shouldn't this go
> > > > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > > > could then simply go into the Rockchip DRM tree.
> > > 
> > > actually, we determined that the supply names are universal to the IP
> > > (both in imx and rockchip and probably more if there are more users
> > > out there). Just Russell requested that we don't pollute the generic
> > > code until necessary, as it looks like the supply of those is somehow
> > > handled internally on the imx.
> > 
> > Why do you think it's universal?
> > 
> > Let's start from the beginning, before we create something that's not
> > representative of the hardware.
> > 
> > dw_hdmi actually drives two pieces of hardware - the HDMI transmitter,
> > and a separate hardware block, the HDMI phy.
> > 
> > There are at least two possible HDMI phys referenced in the iMX
> > documentation - there is one called HEAC which doesn't appear in iMX
> > devices afaik, and the one which does, which is a 3D phy.
> 
> I'm not sure I understand correctly. Are these PHYs exchangeable? Does
> the DesignWare IP provide them or could they be provided separately?

You're asking questions we have no real answers to - all we have is the
available documentation provided by Freescale - we don't even have the
Rochchip documentation.

>From the Freescale documentation, which documents the HDMI transmitter
entirely separately from the HDMI phy, I would say that the IP is
structured as two entirely separate blocks, and the chip designer is
free to choose an appropriate phy from a range of HDMI phys.

Moreover, in the feature list for the HDMI transmitter, it says (though
this is not applicable to iMX6 - and is probably lifted from the
Synopsis documentation):

"* Option to remove pixel repetition clock from HDMI TX interface for an
  easy integration with third party HDMI TX PHYs"

So - here's the question: what do we do when we find something using the
Synopsis design-ware HDMI transmitter with a different HDMI phy?

Remember, VP, VPH, VP_FILT_* are all part of the HDMI phy according to
the freescale documentation, and not part of the HDMI transmitter.

> I
> see register definitions for a "source" PHY and a "master" PHY, where
> the latter seems to be an I2C controller rather than a PHY. Perhaps it
> is used to communicate with an external PHY?

I'm not sure where you get that from.  Maybe you could give a chapter
reference?

Looking deeper at this HEAC issue, that is a separate, smaller phy which
doesn't have much to do with video - though it remains rather undocumented
in the freescale docs.  That's only going on a block diagram near the
start of the HDMI transmitter chapter though.

> > If we wanted to model this correctly, then for iMX, I would suggest
> > that the HDMI phy should be modelled in DT, and _all_ the six VP*
> > supplies are modelled - and we should assume that "GD" is a "power
> > good" signal, though we don't know that for certain.
> 
> Perhaps VP_FILT* are sourced from the same supply as VP, so maybe we
> don't have to care at the DT level?

We'd be guessing - and that's exactly my point.  Designing something at
DT level based on guesswork is no way to go, especially with a generic
bit of IP which would be re-used across multiple different platforms.

> > What we also don't know on iMX6 is what voltages any of these are
> > supplied with.
> 
> A rather common nuisance with these licensed IP blocks is that some of
> the details may be hidden in SoC glue, resulting in the interface being
> different on each SoC. Given all of the above it sounds like i.MX could
> have some internal glue to supply VP and VPH and there'd be no sensible
> way to represent them in DT.

... or it's entirely possible that all these supplies are always fed by
the iMX6 SoC all the time.

> > So, as we don't have much certainty here, and we know that adding it
> > to what is the HDMI transmitter would be wrong, I'd suggest not
> > modelling it in a generic way at present.
> 
> Does DesignWare by any chance offer documentation about the IP? If not I
> agree that the safest thing to do for now would be to make this Rockchip
> specific.

That's _exactly_ why I raised the point originally, and said that it should
be Rockchip specific until we know better.  Glad you've caught up with my
thinking. :)

However, my thinking _now_ is that it shouldn't even be modelled as part
of our HDMI transmitter DT blob, but we should be modelling the HDMI
transmitter separately from the HDMI phy as two separate DT blobs, and
then the HDMI phy blob gets the (possibly optional) VPH and VP supplies.

What if someone designs a chip with their own HDMI phy which uses
different supplies?

This is one of the problems I have with DT - DT needs us to describe
the hardware correctly first time around, when we may not have all the
available facts to make proper decisions, and wrong decisions can very
well lead to serious headaches later on because we didn't model
something correctly - and we're stuck with the wrong decisions for ever.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
