From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 23:10:50 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
References: <000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
Message-ID: <20110124231050.GP24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 07:59:03PM +0000, Pawel Moll wrote:
> > If you're flooding the system with USB traffic, enlargening the
> > FIFO size won't help.  Making the FIFO larger just decreases the
> > _interrupt_ _latency_ requirements.  It doesn't mean you can
> > cope with the amount of data being transferred.
> 
> On VE both ISP and MMCI are sharing the same static memory interface,

What has that to do with it?  If the static memory controller was the
bottleneck, don't you think that two CPUs running in parallel, one
reading data from the ISP1761 and the other reading the MMCI would
suffer bus starvation?  Your "HACK HACK HACK" patch shows that clearly
isn't the case.

You've already told me that you've measured the ISP1761 interrupt
handler taking 1.3ms to empty data off of the chip.  If that's 60K
of data, that's a data rate of around 47MiB/s.

At 521kHz transfer rate, it takes about 490us for MMCI to half-fill
its FIFO, or 980us to fully fill it.  It takes (measured) about 6-9us
to unload 32 bytes of data from the FIFO.

Translating the CPU read rate, that's a data rate of around 4MiB/s.

So I put it to you that there's plenty of bus bandwidth present to
service both the ISP1761 and MMCI.  What we're lacking is CPU
bandwidth.

I guess you haven't thought about moving MMCI to an adaptive clocking
solution?  What I'm suggesting is halve the clock rate on FIFO error
and retry.  Increase the clock rate on each successful transfer up
to the maximum provided by the core MMC code.

That should _significantly_ increase the achievable PIO data rate
way beyond what a deeper FIFO could ever hope to achieve, and will
allow it to adapt to situations where you load the system up beyond
the maximum latency which the MMCI can stand.

This would benefit a whole range of platforms, improving performance
across the board, which as you've already indicated merely going for
a deeper FIFO would be unable to do.
