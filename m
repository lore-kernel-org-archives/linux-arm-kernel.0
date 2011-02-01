From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 14:28:45 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <1296567299.2768.40.camel@hornet.cambridge.arm.com>
References: <20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
	<20110124231050.GP24104@n2100.arm.linux.org.uk>
	<20110201111821.GC31216@n2100.arm.linux.org.uk>
	<1296567299.2768.40.camel@hornet.cambridge.arm.com>
Message-ID: <20110201142845.GJ31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 01:34:59PM +0000, Pawel Moll wrote:
> > And to prove the point, I have MMCI running at up to 4Mbps, an 8 fold
> > increase over what the current fixed upper-rate implementation does.
> > The adaptive rate implementation is just a proof of concept at the
> > moment and requires further work to improve the rate selection algorithm.
> 
> Great, I've terribly glad you managed to have a go at this (I honestly
> wanted to, but simply had no time). I'm looking forward to see the
> patches and will be more than happy to backport them for the sake of the
> Linaro guys using 2.6.35 and 2.6.37 right now.
> 
> On our side we did extend the FIFO and performed some tests (not very
> extensive yet though). The change seems not to break anything and help
> in the pathological (heavy USB traffic) scenario.
> 
> When I get your changes and some official FPGA release, I'll try to push
> the bandwidth limits even further - hopefully changes will complement.

You can't push it any further without increasing the CPU/bus clock rates.
My measurements show that it takes the CPU in the region of 6-9us to
unload 32 bytes from the FIFO, which gives a theoretical limit of 2.8
to 4.2Mbps, depending on how the platform booted (some reboots its
consistently in the order of 6us, some boots its consistently around 9us.)

> > The real solution to this is for there to be proper working DMA support
> > implemented on ARM platforms,
> 
> In case of VE this is all about getting an engine into the test chips,
> what didn't happen for A9 (the request lines are routed between the
> motherboard and the tile and IO FPGA can - theoretically - use the MMCI
> requests). As far as I'm told this cell is simply huge (silicon-wise)
> and therefore it's the first candidate to cut down when area is
> scarce... Anyway, I've spoken to guys around and asked them to keep the
> problem in mind, so we may get something with the next releases.

Bear in mind that PL18x + PL08x doesn't work.  Catalin forwarded my
concerns over this to ARM Support - where I basically ask how to program
the hardware up to DMA a single 64K transfer off a MMC card into a set
of scattered memory locations.

I've yet to have a response, so I'll take it that it's just possible
(the TRMs say as much).

The problem is that for a transfer, the MMCI produces BREQ * n + LBREQ,
and the DMAC will only listen for a LBREQ if it's in peripheral flow
control.  If it's in peripheral flow control, then it ignores the transfer
length field in the control register, only moving to the next LLI when it
sees LBREQ or LSREQ.

It ignores LBREQ and LSREQ in DMAC flow control mode..  You can DMA almost
all the data too/from the MMCI, but you miss the last half-fifo-size worth
of data.  While you can unload that manually for a read, you can't load
it manually for a write.

With peripheral flow control, you can only DMA the requested data to a
single contiguous buffer without breaking the MMC request into much
smaller chunks.  As Peter Pearse's PL08x code seems to suggest, the
maximum size of those chunks is 1K.

This seems to be a fundamental problem with the way each primecell has
been designed.

So, I do hope that someone decides to implement something more reasonable
if Versatile Express were to get a DMA controller.  If it's another PL08x
then it isn't worth it - it won't work.
