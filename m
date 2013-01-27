From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Jan 2013 02:31:31 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <20130126235037.GV1758@titan.lakedaemon.net>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
 <20130126235037.GV1758@titan.lakedaemon.net>
Message-ID: <20130127013131.GA2400@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 06:50:37PM -0500, Jason Cooper wrote:
> Simon,
> 
> On Sat, Jan 26, 2013 at 08:01:04PM +0100, Simon Baatz wrote:
> > Commits f479db "ARM: Kirkwood: Ensure runit clock always ticks." and
> > 128789 "ARM: Kirkwood: Fix clk problems modular ethernet driver"
> > ensured that the ge and runit clocks always tick on Kirkwood.  This
> > prevents the device from locking up and from forgetting the MAC addresses
> > which are usually set by the boot loader.
> > 
> > When moving the clock gating control to this driver for DT devices, these
> > changes were disabled.  Ensure that the respective clocks have the
> > CLK_IGNORE_UNUSED flag set.
> > 
> > 
> > In the past, we fixed this by keeping the clocks ticking (which
> > probably is not be the nicest solution for the ge clocks).
> 
> I have to admit, I'm not really keen on this.  Most of these boards only
> have one ethernet port, so at least one port would be energized
> unnecessarily.

Me neither, the patch was intended to get 3.8 to work with
modularized drivers.  It was not intended to be the final solution. 
However, I think I found a better way for 3.8, see below.

> 
> Another facet of this problem is the keymile board.  It has to enable
> the clocks for sata in order to boot. (ref: board-km_kirkwood.c).

I did not notice it before, but looking at this, I realized why there
is the problem with the ge[01] clocks: kirkwood_ge0[01]_init() in common.c
depends on clk pointers that are only initialized in the non-DT case
(kirkwood_clk_init()) but not in the DT case
(kirkwood_legacy_clk_init() in board-dt.c). 

I think we should do the following for 3.8:

- Get the clocks by device name in kirkwood_ge0x_init()
- Only set CLK_IGNORE_UNUSED for "runit" in clk-gating-ctrl.c. (I can
do this by simply adding another case to the existing "ddr"
exception, which makes the patch much less intrusive)

For 3.9 with a DT converted ethernet driver, we will need something
more clever.

If you agree, I can prepare patches for 3.8.

> Perhaps there is some way we could declare certain gate clocks to be
> non-gateable in the dts?  runit comes to mind, sata for keymile, and the
> relevant ge[01] per board.  After all, it is a characteristic of the
> board.  ;-)
> 

I like this idea. That fits my 'more clever' from above ;-)

> eg in kirkwood-km_kirkwood.dts:
> 
> gate_clk: clock-gating-control at 2011c {
> 	/*
> 	 * need both sata clks enabled in order to boot
> 	 * even though we have no sata
> 	 */
> 	ungateable = <14 15>;
> };
> 
> and in any other board:
> 
> gate_clk: clock-gating-control at 2011c {
> 	/* don't lose eth0 mac address */
> 	ungateable = <0>;
> };
> 
> where in kirkwood.dtsi we had:
> 
> gate_clk: clock-gating-control at 2011c {
> 	compatible = "marvell,kirkwood-gating-clock";
> 	reg = <0x2011c 0x4>;
> 	clocks = <&core_clk 0>;
> 	#clock-cells = <1>;
> 	ungateable = <7>; /* never gate runit */
> };
> 
> or, s/ungateable/ignore_unused/g

Yes, probably better.

- Simon
