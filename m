From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Oct 2018 22:23:37 +0100
Subject: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround
 for v2.12a
In-Reply-To: <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-16-jernej.skrabec@siol.net>
 <3616158.EzHeIcd69b@avalon>
 <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
Message-ID: <20181009212337.GL30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 01:56:04PM -0400, Ilia Mirkin wrote:
> On Tue, Oct 9, 2018 at 1:40 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > commit 9c305eb442f3b371fc722ade827bbf673514123e
> > Author: Neil Armstrong <narmstrong@baylibre.com>
> > Date:   Fri Feb 23 12:44:37 2018 +0100
> >
> >     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
> >
> > I haven't paid too much attention to the patch back then, and have now double-
> > checked the HDMI output on R-Car Gen3. Enabling the workaround doesn't cause
> > any regression, and reverting the commit doesn't cause any issue either. I
> > thus wonder whether we shouldn't enable the workaround with count = 1 in the
> > default case instead of adding new IP core versions to the list. It would be
> > nice if someone from Synopsys could comment on this.
> 
> I hope this comment isn't *incredibly* off-topic, but we encountered a
> similar issue with NVIDIA (and I believe AMD) hardware a while back,
> related to HDMI. This was due to infoframes not being sent, but
> (perhaps) HDMI Audio being enabled.

You're probably right about the infoframes.  The errata documentation
for this workaround on iMX6 states:

 Each time one writes to some FC registers, and depending on the clock relation of sfr clk and tmds
 clk, some of these train of pulses (when these registers are configured in sequence), may not be
 caught by the arithmetic unit while it is busy processing/updating the first ones, so, it gets wrong
 video timing values, although the registers FC_* hold correct values. Even a soft reset will not
 make the arithmetic unit update correctly. Video will still pass correctly to the HDMI, but packets
 would not because the frame composer is holding internally incorrect video timing and this will
 quickly build up and overflow the packet FIFOs.

So, the workaround is about kicking the frame composer so that the
packets (iow, non-video data) are passed through correctly.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
