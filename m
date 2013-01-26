From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 18:50:37 -0500
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130126235037.GV1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

On Sat, Jan 26, 2013 at 08:01:04PM +0100, Simon Baatz wrote:
> Commits f479db "ARM: Kirkwood: Ensure runit clock always ticks." and
> 128789 "ARM: Kirkwood: Fix clk problems modular ethernet driver"
> ensured that the ge and runit clocks always tick on Kirkwood.  This
> prevents the device from locking up and from forgetting the MAC addresses
> which are usually set by the boot loader.
> 
> When moving the clock gating control to this driver for DT devices, these
> changes were disabled.  Ensure that the respective clocks have the
> CLK_IGNORE_UNUSED flag set.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
> 
> Hi,
> 
> kernel 3.8-rc5 will hang on kirkwood DT if the Ethernet driver is built
> as a module or when no driver claiming the runit clock is built in. 
> (Usually, at least the serial driver is built in, but it won't request
> the clock if "clock-frequency" is given in DT.)
> 
> In the past, we fixed this by keeping the clocks ticking (which
> probably is not be the nicest solution for the ge clocks).

I have to admit, I'm not really keen on this.  Most of these boards only
have one ethernet port, so at least one port would be energized
unnecessarily.

Another facet of this problem is the keymile board.  It has to enable
the clocks for sata in order to boot. (ref: board-km_kirkwood.c).

Perhaps there is some way we could declare certain gate clocks to be
non-gateable in the dts?  runit comes to mind, sata for keymile, and the
relevant ge[01] per board.  After all, it is a characteristic of the
board.  ;-)

eg in kirkwood-km_kirkwood.dts:

gate_clk: clock-gating-control at 2011c {
	/*
	 * need both sata clks enabled in order to boot
	 * even though we have no sata
	 */
	ungateable = <14 15>;
};

and in any other board:

gate_clk: clock-gating-control at 2011c {
	/* don't lose eth0 mac address */
	ungateable = <0>;
};

where in kirkwood.dtsi we had:

gate_clk: clock-gating-control at 2011c {
	compatible = "marvell,kirkwood-gating-clock";
	reg = <0x2011c 0x4>;
	clocks = <&core_clk 0>;
	#clock-cells = <1>;
	ungateable = <7>; /* never gate runit */
};

or, s/ungateable/ignore_unused/g

thx,

Jason.
