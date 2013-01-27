From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Jan 2013 11:56:54 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <5104FE5F.2040804@gmail.com>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
 <20130126235037.GV1758@titan.lakedaemon.net>
 <20130127013131.GA2400@schnuecks.de> <5104FE5F.2040804@gmail.com>
Message-ID: <20130127105654.GA23127@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Sun, Jan 27, 2013 at 11:15:59AM +0100, Sebastian Hesselbarth wrote:
> 
> >I think we should do the following for 3.8:
> >
> >- Get the clocks by device name in kirkwood_ge0x_init()
> >- Only set CLK_IGNORE_UNUSED for "runit" in clk-gating-ctrl.c. (I can
> >do this by simply adding another case to the existing "ddr"
> >exception, which makes the patch much less intrusive)
> 
> I agree that we should have .flags for clk-gating-ctrl but that
> can live without any DT properties as we already have SoC specific
> structs there (and Keymile's kirkwood doesn't hang on clk gating
> control register accesses)

Oh, I just posted the patch with the simple if, not the .flags. As
said, the .flags create much noise.  But I don't mind changing that
back or posting the .flags change separately for 3.9.

I think for "runit" it makes sense to keep it that way (i.e. not in
DT properties).  But the ge clocks are really depending on the number
of interfaces on the particular board.  Having a way not to keep them
running for all boards just not to forget the MAC addresses for those
boards who use them would be nice.

> 
> >>and in any other board:
> >>
> >>gate_clk: clock-gating-control at 2011c {
> >>	/* don't lose eth0 mac address */
> >>	ungateable =<0>;
> >>};
> 
> If there is any hang issue with gated ge clk on kirkwood, the
> solution is not to just disable the clock gate but make any
> code that accesses ge registers prepare the clock.

Indeed, there are two issue here. The ge interface forgets its MAC
address (set by the boot loader) when the clock is gated.

In the ge driver, accesses are in the wrong order or there is a
missing delay between the enabling and the hardware access.  Andrew
digged into this at the time. But even if that would work, the
interface would not be usable without a valid MAC address.

- Simon
