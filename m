From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 11:18:21 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124231050.GP24104@n2100.arm.linux.org.uk>
References: <20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
	<20110124231050.GP24104@n2100.arm.linux.org.uk>
Message-ID: <20110201111821.GC31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 11:10:50PM +0000, Russell King - ARM Linux wrote:
> I guess you haven't thought about moving MMCI to an adaptive clocking
> solution?  What I'm suggesting is halve the clock rate on FIFO error
> and retry.  Increase the clock rate on each successful transfer up
> to the maximum provided by the core MMC code.
> 
> That should _significantly_ increase the achievable PIO data rate
> way beyond what a deeper FIFO could ever hope to achieve, and will
> allow it to adapt to situations where you load the system up beyond
> the maximum latency which the MMCI can stand.

And to prove the point, I have MMCI running at up to 4Mbps, an 8 fold
increase over what the current fixed upper-rate implementation does.
The adaptive rate implementation is just a proof of concept at the
moment and requires further work to improve the rate selection algorithm.

The real solution to this is for there to be proper working DMA support
implemented on ARM platforms, rather than requiring every peripheral to
be driven via CPU intensive PIO all the time.
