From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 8 Jun 2015 17:44:53 +0200
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150608142926.GY7557@n2100.arm.linux.org.uk>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
 <20150605231058.GQ7557@n2100.arm.linux.org.uk>
 <20150608140256.GA10354@ulmo.nvidia.com>
 <20150608142926.GY7557@n2100.arm.linux.org.uk>
Message-ID: <20150608154448.GA11103@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 03:29:26PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 08, 2015 at 04:02:58PM +0200, Thierry Reding wrote:
> > On Sat, Jun 06, 2015 at 12:10:58AM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> > > > Hi Thierry
> > > > 
> > > > Am Freitag, 5. Juni 2015, 13:02:01 schrieb Thierry Reding:
> > > > > If this is specific to the Rockchip implementation, shouldn't this go
> > > > > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > > > > could then simply go into the Rockchip DRM tree.
> > > > 
> > > > actually, we determined that the supply names are universal to the IP
> > > > (both in imx and rockchip and probably more if there are more users
> > > > out there). Just Russell requested that we don't pollute the generic
> > > > code until necessary, as it looks like the supply of those is somehow
> > > > handled internally on the imx.
> > > 
> > > Why do you think it's universal?
> > > 
> > > Let's start from the beginning, before we create something that's not
> > > representative of the hardware.
> > > 
> > > dw_hdmi actually drives two pieces of hardware - the HDMI transmitter,
> > > and a separate hardware block, the HDMI phy.
> > > 
> > > There are at least two possible HDMI phys referenced in the iMX
> > > documentation - there is one called HEAC which doesn't appear in iMX
> > > devices afaik, and the one which does, which is a 3D phy.
> > 
> > I'm not sure I understand correctly. Are these PHYs exchangeable? Does
> > the DesignWare IP provide them or could they be provided separately?
> 
> You're asking questions we have no real answers to - all we have is the
> available documentation provided by Freescale - we don't even have the
> Rochchip documentation.
> 
> From the Freescale documentation, which documents the HDMI transmitter
> entirely separately from the HDMI phy, I would say that the IP is
> structured as two entirely separate blocks, and the chip designer is
> free to choose an appropriate phy from a range of HDMI phys.

Does it associate any of the registers with the HDMI PHY? According to
the register definitions in drivers/gpu/drm/bridge/dw_hdmi.h the PHY
registers are interleaved with other registers that are likely part of
the HDMI transmitter proper (there are things like HDCP and CEC engines
in that IP as well).

> Moreover, in the feature list for the HDMI transmitter, it says (though
> this is not applicable to iMX6 - and is probably lifted from the
> Synopsis documentation):
> 
> "* Option to remove pixel repetition clock from HDMI TX interface for an
>   easy integration with third party HDMI TX PHYs"
> 
> So - here's the question: what do we do when we find something using the
> Synopsis design-ware HDMI transmitter with a different HDMI phy?
> 
> Remember, VP, VPH, VP_FILT_* are all part of the HDMI phy according to
> the freescale documentation, and not part of the HDMI transmitter.
> 
> > I
> > see register definitions for a "source" PHY and a "master" PHY, where
> > the latter seems to be an I2C controller rather than a PHY. Perhaps it
> > is used to communicate with an external PHY?
> 
> I'm not sure where you get that from.  Maybe you could give a chapter
> reference?

That's just from skimming drivers/gpu/drm/bridge/dw_hdmi.h (register
offsets 0x3000 and the following). The large gap between them and the
preceding FC registers could be an additional indication that they are
indeed separate IP blocks. Then again, the AUD registers start at an
offset of 0x3100, so maybe it's no indication at all.

Are these the registers used to control the PHY that you're referring
to? It seems odd to me that the documentation would specify these
registers interleaved with other registers if the PHYs can be freely
chosen from a set of HDMI PHYs. Perhaps the set of PHYs that can be used
need to expose the same integration interface? Maybe these registers
aren't used to control the PHY at all but rather configure the interface
between transmitter and PHY?

Sorry if these are more questions that the documentation doesn't answer.
Just trying to understand what's going on.

> Looking deeper at this HEAC issue, that is a separate, smaller phy which
> doesn't have much to do with video - though it remains rather undocumented
> in the freescale docs.  That's only going on a block diagram near the
> start of the HDMI transmitter chapter though.

HEAC could be "HDMI Ethernet Audio Control", see here:

	http://en.wikipedia.org/wiki/HDMI#ARC
	http://en.wikipedia.org/wiki/HDMI#HEC

> > > If we wanted to model this correctly, then for iMX, I would suggest
> > > that the HDMI phy should be modelled in DT, and _all_ the six VP*
> > > supplies are modelled - and we should assume that "GD" is a "power
> > > good" signal, though we don't know that for certain.
> > 
> > Perhaps VP_FILT* are sourced from the same supply as VP, so maybe we
> > don't have to care at the DT level?
> 
> We'd be guessing - and that's exactly my point.  Designing something at
> DT level based on guesswork is no way to go, especially with a generic
> bit of IP which would be re-used across multiple different platforms.

Agreed.

> > > What we also don't know on iMX6 is what voltages any of these are
> > > supplied with.
> > 
> > A rather common nuisance with these licensed IP blocks is that some of
> > the details may be hidden in SoC glue, resulting in the interface being
> > different on each SoC. Given all of the above it sounds like i.MX could
> > have some internal glue to supply VP and VPH and there'd be no sensible
> > way to represent them in DT.
> 
> ... or it's entirely possible that all these supplies are always fed by
> the iMX6 SoC all the time.

Yes, that's what I was implying.

> > > So, as we don't have much certainty here, and we know that adding it
> > > to what is the HDMI transmitter would be wrong, I'd suggest not
> > > modelling it in a generic way at present.
> > 
> > Does DesignWare by any chance offer documentation about the IP? If not I
> > agree that the safest thing to do for now would be to make this Rockchip
> > specific.
> 
> That's _exactly_ why I raised the point originally, and said that it should
> be Rockchip specific until we know better.  Glad you've caught up with my
> thinking. :)
> 
> However, my thinking _now_ is that it shouldn't even be modelled as part
> of our HDMI transmitter DT blob, but we should be modelling the HDMI
> transmitter separately from the HDMI phy as two separate DT blobs, and
> then the HDMI phy blob gets the (possibly optional) VPH and VP supplies.

Yes, I agree. One problem that you could run into with such a split is
that the PHY control registers may be interleaved with the registers of
the HDMI transmitter. But perhaps my understanding is wrong and the PHY
is truly controlled via a completely own set of registers. Looking at
the implementation, the HDMI_PHY_* registers seem to be used to control
various aspects of an interface between transmitter and PHY rather than
the PHY itself and it seems like the PHY itself is really an I2C slave
accessed using the I2C master controlled using the HDMI_PHY_I2CM_*
registers.

So perhaps the HDMI transmitter DT node really should expose the PHY as
an I2C child. In fact, looking at HDMI_PHY_I2CM_SLAVE_ADDR_* field
values (lines 870 and 871 in dw_hdmi.h) it should have two children, one
for the "GEN2" PHY and one for the "HEAC" PHY. You could even go as far
as exposing the HDMI_PHY_I2CM_* registers as I2C master and implement
the PHYs as proper I2C client drivers, but that might be overkill,
especially considering that you'd need to have extra API to convey the
HDMI configuration. Still, might be worth considering to make the split
really explicit.

I guess I've answered most of my earlier questions myself...

> What if someone designs a chip with their own HDMI phy which uses
> different supplies?

That's really one more reason to write proper drivers for the PHYs. If
you really ever have to deal with a different PHY chances are that more
than just the supplies will be different, in which case you'd need to
somehow also abstract away the interoperation between HDMI transmitter
and PHY.

> This is one of the problems I have with DT - DT needs us to describe
> the hardware correctly first time around, when we may not have all the
> available facts to make proper decisions, and wrong decisions can very
> well lead to serious headaches later on because we didn't model
> something correctly - and we're stuck with the wrong decisions for ever.

I feel the same way. Although there have been occasional exceptions to
the DT ABI stability rule if it could be proven that an existing binding
was completely wrong, I've made the experience that putting as little as
possible into DT (and at the same time resist the temptation of a
generic solution) helps keep the headaches in check.

Fortunately the dw-hdmi driver gets much of this right already (it's
helper code rather than a proper driver), so keeping things like power
supplies specific to a particular integration should be easy to do and
prevent potential future incompatibilities.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/649817de/attachment-0001.sig>
