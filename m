From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 27 Jan 2013 11:15:59 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <20130127013131.GA2400@schnuecks.de>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
 <20130126235037.GV1758@titan.lakedaemon.net>
 <20130127013131.GA2400@schnuecks.de>
Message-ID: <5104FE5F.2040804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2013 02:31 AM, Simon Baatz wrote:
> On Sat, Jan 26, 2013 at 06:50:37PM -0500, Jason Cooper wrote:
>> Another facet of this problem is the keymile board.  It has to enable
>> the clocks for sata in order to boot. (ref: board-km_kirkwood.c).

The statement in board-km_kirkwood.c is just not true. Andrew and I did
some tests with Valentin Longchamps back when we introduced DT clk
gating. Keymile board hangs not because of the accesses to clk gating
ctrl registers but the phy gating that accessed the sata registers
that are missing on the Kirkwood used on that board.

Phy gates have not been used since DT clk gating at all. If we
reintroduce them in a DT compatible way we can still disable them
for keymile board in DT.

> I think we should do the following for 3.8:
>
> - Get the clocks by device name in kirkwood_ge0x_init()
> - Only set CLK_IGNORE_UNUSED for "runit" in clk-gating-ctrl.c. (I can
> do this by simply adding another case to the existing "ddr"
> exception, which makes the patch much less intrusive)

I agree that we should have .flags for clk-gating-ctrl but that
can live without any DT properties as we already have SoC specific
structs there (and Keymile's kirkwood doesn't hang on clk gating
control register accesses)

>> and in any other board:
>>
>> gate_clk: clock-gating-control at 2011c {
>> 	/* don't lose eth0 mac address */
>> 	ungateable =<0>;
>> };

If there is any hang issue with gated ge clk on kirkwood, the
solution is not to just disable the clock gate but make any
code that accesses ge registers prepare the clock.

Sebastian
