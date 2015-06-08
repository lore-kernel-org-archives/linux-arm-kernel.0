From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 8 Jun 2015 16:02:58 +0200
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150605231058.GQ7557@n2100.arm.linux.org.uk>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
 <20150605231058.GQ7557@n2100.arm.linux.org.uk>
Message-ID: <20150608140256.GA10354@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 06, 2015 at 12:10:58AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> > Hi Thierry
> > 
> > Am Freitag, 5. Juni 2015, 13:02:01 schrieb Thierry Reding:
> > > If this is specific to the Rockchip implementation, shouldn't this go
> > > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > > could then simply go into the Rockchip DRM tree.
> > 
> > actually, we determined that the supply names are universal to the IP
> > (both in imx and rockchip and probably more if there are more users
> > out there). Just Russell requested that we don't pollute the generic
> > code until necessary, as it looks like the supply of those is somehow
> > handled internally on the imx.
> 
> Why do you think it's universal?
> 
> Let's start from the beginning, before we create something that's not
> representative of the hardware.
> 
> dw_hdmi actually drives two pieces of hardware - the HDMI transmitter,
> and a separate hardware block, the HDMI phy.
> 
> There are at least two possible HDMI phys referenced in the iMX
> documentation - there is one called HEAC which doesn't appear in iMX
> devices afaik, and the one which does, which is a 3D phy.

I'm not sure I understand correctly. Are these PHYs exchangeable? Does
the DesignWare IP provide them or could they be provided separately? I
see register definitions for a "source" PHY and a "master" PHY, where
the latter seems to be an I2C controller rather than a PHY. Perhaps it
is used to communicate with an external PHY?

Can somebody give me a quick summary (or point me to documentation) on
how this works?

> The 3D phy top level IO diagram does have VPH and VP power supplies,
> but it also has VP_FILT0, VP_FILT1, VP_FILT2, VP_FILT3 and GD labelled
> up as "Power supply signals".  Where they connect to in the rest of the
> system - or whether they are connected - is undocumented.
> 
> The HDMI transmitter itself is not documented what it's supplies
> actually are.
> 
> So, what we currently have in DT for dw_hdmi is something which doesn't
> _quite_ reflect the hardware right now, and to go adding VP and VPH
> supplies to the generic binding is wrong - it doesn't follow the
> hardware structure detailed in the iMX documentation I have.
> 
> As the Rockchip documentation is not available, I can't comment whether
> it would be current proposal is appropriate for Rockchip or not, which
> is why I haven't commented on this other than saying that it's not
> appropriate to be a generic dw_hdmi binding.
> 
> If we wanted to model this correctly, then for iMX, I would suggest
> that the HDMI phy should be modelled in DT, and _all_ the six VP*
> supplies are modelled - and we should assume that "GD" is a "power
> good" signal, though we don't know that for certain.

Perhaps VP_FILT* are sourced from the same supply as VP, so maybe we
don't have to care at the DT level?

> What we also don't know on iMX6 is what voltages any of these are
> supplied with.

A rather common nuisance with these licensed IP blocks is that some of
the details may be hidden in SoC glue, resulting in the interface being
different on each SoC. Given all of the above it sounds like i.MX could
have some internal glue to supply VP and VPH and there'd be no sensible
way to represent them in DT.

> So, as we don't have much certainty here, and we know that adding it
> to what is the HDMI transmitter would be wrong, I'd suggest not
> modelling it in a generic way at present.

Does DesignWare by any chance offer documentation about the IP? If not I
agree that the safest thing to do for now would be to make this Rockchip
specific. If it should prove to be generic after all (in which case i.MX
would seem to provide SoC glue to supply them) we can still promote the
supplies to be generic. They'd need to be optional to handle the i.MX,
though. Or perhaps a dummy regulator could be referenced, representing
the SoC-internal supply to the block. Maybe there even is a (SoC-
specific) way to control this internal regulator?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/a9533e31/attachment.sig>
