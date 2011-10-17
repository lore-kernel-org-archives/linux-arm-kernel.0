From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Oct 2011 13:05:39 +0200
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111017105302.GC20184@b20223-02.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<20111014081024.GA9485@b20223-02.ap.freescale.net>
	<20111014100504.GC2966@opensource.wolfsonmicro.com>
	<20111014103233.GB9485@b20223-02.ap.freescale.net>
	<20111016175521.GA13565@pengutronix.de>
	<20111017084851.GB20184@b20223-02.ap.freescale.net>
	<20111017092028.GA3042@opensource.wolfsonmicro.com>
	<20111017105302.GC20184@b20223-02.ap.freescale.net>
Message-ID: <20111017110539.GB18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 06:53:03PM +0800, Richard Zhao wrote:
> On Mon, Oct 17, 2011 at 10:20:28AM +0100, Mark Brown wrote:
> > On Mon, Oct 17, 2011 at 04:48:52PM +0800, Richard Zhao wrote:
> > 
> > > For example, devices that possible access to on-chip RAM, depend on OCRAM clock. 
> > > On imx53, VPU depends on OCRAM clock, even when VPU does not use OCRAM.
> > 
> > So if the VPU depends on OCRAM the VPU should be enabling the OCRAM
> > clock.  The function of a given clock isn't terribly relevant, and
> > certainly grouping clocks together doesn't seem to be the obvious
> > solution from what you've said
> VPU don't know OCRAM clk, it's SoC specific. I know it's clock function
> replationship. But it's the only better place to refect the dependency 
> in clock tree. Another dependency example, from SoC bus topology, some bus
> clk always depends on bus switch/hub.
> > - if the driver doesn't know about the
> > clock it seems like the core ought to be enabling it transparently
> > rather than gluing it together with some other random clock.
> If you mean clk core here, then we need things like below:
> struct clk_hw {
> 	struct clk *clk;
> 	struct dependency {
> 		struct clk_hw *clks;
> 		int count;
> 	};
> };
> Though Mike does not like to add things in clk_hw, but it's the only place
> to put common things of clk drivers.

It's not a problem to associate multiple clocks to a device, we can do
this now already. What a driver can't do now is give-me-all-clocks-I-need(dev),
but this problem should not be solved at clock core level but at the
clkdev level.
The fact is that the different clocks for a device are really different
clocks. A dumb driver may want to request/enable all relevant clocks at
once while a more sophisticated driver may want to enable the clock for
accessing registers in the probe function and a baud clock on device
open time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
