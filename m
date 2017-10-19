From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Oct 2017 16:54:16 +0200
Subject: [RFC resend] arm64: mt8173: Fix Acer Chromebooks mmsys probe
 problem
In-Reply-To: <1683149.BjzMD0lNNQ@avalon>
References: <20171019112610.13645-1-mbrugger@suse.com>
 <1508418114.7665.16.camel@pengutronix.de> <1683149.BjzMD0lNNQ@avalon>
Message-ID: <1508424856.7665.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, 2017-10-19 at 16:39 +0300, Laurent Pinchart wrote:
> Hi Philipp,
> 
> On Thursday, 19 October 2017 16:01:54 EEST Philipp Zabel wrote:
> > On Thu, 2017-10-19 at 13:26 +0200, Matthias Brugger wrote:
> > > In theory the MMSYS device tree identifier is matches twice, by the clk
> > > driver and the DRM subsystem. But the kernel only matches the first
> > > driver for a device (clk) and discards the second one. This breaks
> > > graphics on mt8173 and most probably on mt2701 as well.
> > > 
> > > MMSYS in Mediatek SoCs has some registers to control clock gates (which is
> > > used in the clk driver) and some registers to enable the differnet blocks
> > > of the display subsystem. The kernel uses the binding to load the central
> > > comoponent of the distplay subsystem, which in place probes all the other
> > > components and enables the present ones in the MMSYS.
> > > 
> > > We found us with the problem, that we need to change and therefor break
> > > one
> > > of the two bindings, or the DRM one or the clock driver one.
> > > 
> > > Apart from that the DRM subysystem does access the MMSYS registers via
> > > relaxed reads/writes. But the it should to so via regmap, as the
> > > registers are shared.
> > > 
> > > Possible solutions:
> > > 1) We add a new mediatek,mt8173-mmsys-clk node, which lives as a
> > > simple-mfd under the actual mmsys node. We change the clock driver to
> > > probe on this binding. This would make sense as the clock gate register
> > > live completly in the MMSYS configuration registers.
> > 
> > The reason why the drm driver matches against the mmsys node in the
> > first place is that we wanted to avoid 2).
> 
> Why did you want to avoid 2) ?

Because the "display-subsystem" node does not represent a real device,
it's just there to probe the driver that stitches all the DISP
components together.

> > Also, mmsys is not a pure clock controller, as it also contains the
> > display path configuration in its register space.
> 
> Which makes the mmsys related to display, but more in a syscon (combining 
> clocks and routing, and I assume other miscellaneous features that wouldn't 
> fit nicely in the other display-related IP cores) way than actually being part 
> of the display subsystem. Or does mmsys only provide display-related features 
> ?

All devices in the 0x14000000 - 0x14ffffff memory range are part of the
MMSYS system. That includes the MMSYS control or system configuration
block at 0x14000000 - 0x14000fff as well as all the related MDP (media
data path) and DISP (display data path) blocks that follow. The DISP
blocks are purely display related, while the MDP blocks implement
implement mem2mem functions like scaling and conversion.

> > > 2) As the nodes of the DRM subsystem just need some of the registers of
> > > MMSYS we add a new binding mediatek,mt8173-dispsys which probes the
> > > central component of the DRM system. It has only a handle to mt8173-mmsys
> > > to access the registerspace via regmap functions.
> > > 
> > > In this patchset I implemented 2). Please take into account, that this is
> > > a RFC. I had no time to actually test the verison on real HW. Some of the
> > > register accesses should be done using regmap_update instead of
> > > regmap_read + regmap_write.
> > > 
> > > This RFC shall only show how solution 2) would look like. We can use it as
> > > discussion to see how we circumvent the actual situation.
> > 
> > Or we could leave the bindings untouched and create one platform device
> > from the other or even set up the clocks from the drm driver?
> 
> Does mmsys provide features (such as clocks) to non-display IP cores ?

The MMSYS control block provides clocks for the DISP (display data path)
and MDP (multimedia data path) blocks, as well as the routing between
them, but not to anything outside of the MMSYS system.

regards
Philipp
