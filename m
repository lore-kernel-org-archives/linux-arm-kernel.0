From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 21:28:31 +0100
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <20100528194501.GC5189@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281503260.24526@xanadu.home>
	<20100528194501.GC5189@n2100.arm.linux.org.uk>
Message-ID: <20100528202831.GD5189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 08:45:01PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 28, 2010 at 03:26:21PM -0400, Nicolas Pitre wrote:
> > That is exactly the observed behavior on OMAP and Dove when this patch 
> > is _not_ applied.
> 
> I'm about to test this on my OMAP4 board, which will be a DMA-based test,
> which will be using the same filesystem.

Confirmed - on the OMAP4 board _with_ DMA, this patch fixes a problem
causing various faults in userspace - though it's nowhere near as bad
as the Versatile Express board.

So, we seem to have this behaviour:

- with PIO drivers, with this patch breaks userspace, without fixes userspace
- with DMA drivers, with this patch fixes userspace, without breaks userspace

Note that MMCI does do flush_dcache_page() on PIO read.

Maybe there's something wrong in __flush_dcache_page()?
