From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Jun 2015 00:10:58 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <23123577.mOoqGCAPdL@diego>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
Message-ID: <20150605231058.GQ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> Hi Thierry
> 
> Am Freitag, 5. Juni 2015, 13:02:01 schrieb Thierry Reding:
> > If this is specific to the Rockchip implementation, shouldn't this go
> > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > could then simply go into the Rockchip DRM tree.
> 
> actually, we determined that the supply names are universal to the IP
> (both in imx and rockchip and probably more if there are more users
> out there). Just Russell requested that we don't pollute the generic
> code until necessary, as it looks like the supply of those is somehow
> handled internally on the imx.

Why do you think it's universal?

Let's start from the beginning, before we create something that's not
representative of the hardware.

dw_hdmi actually drives two pieces of hardware - the HDMI transmitter,
and a separate hardware block, the HDMI phy.

There are at least two possible HDMI phys referenced in the iMX
documentation - there is one called HEAC which doesn't appear in iMX
devices afaik, and the one which does, which is a 3D phy.

The 3D phy top level IO diagram does have VPH and VP power supplies,
but it also has VP_FILT0, VP_FILT1, VP_FILT2, VP_FILT3 and GD labelled
up as "Power supply signals".  Where they connect to in the rest of the
system - or whether they are connected - is undocumented.

The HDMI transmitter itself is not documented what it's supplies
actually are.

So, what we currently have in DT for dw_hdmi is something which doesn't
_quite_ reflect the hardware right now, and to go adding VP and VPH
supplies to the generic binding is wrong - it doesn't follow the
hardware structure detailed in the iMX documentation I have.

As the Rockchip documentation is not available, I can't comment whether
it would be current proposal is appropriate for Rockchip or not, which
is why I haven't commented on this other than saying that it's not
appropriate to be a generic dw_hdmi binding.

If we wanted to model this correctly, then for iMX, I would suggest
that the HDMI phy should be modelled in DT, and _all_ the six VP*
supplies are modelled - and we should assume that "GD" is a "power
good" signal, though we don't know that for certain.

What we also don't know on iMX6 is what voltages any of these are
supplied with.

So, as we don't have much certainty here, and we know that adding it
to what is the HDMI transmitter would be wrong, I'd suggest not
modelling it in a generic way at present.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
