From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 13:42:14 +0100
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC
	controller driver
In-Reply-To: <20110629122942.GH1992@pengutronix.de>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110629100658.GE1992@pengutronix.de>
	<20110629103337.GF1992@pengutronix.de>
	<4E0B0296.6060902@freescale.com>
	<20110629122942.GH1992@pengutronix.de>
Message-ID: <20110629124214.GN21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 02:29:42PM +0200, Wolfram Sang wrote:
> 
> > > Still, the problem exists: When a second channel GPMI channel is
> > > requested, dmaengine will return -EBUSY, because the DMAIRQ is already
> > > taken.
> > >
> > Yes, we should change the DMA code, it is a DMA bug.
> > I ever submitted a patch about the issue:
> > http://patchwork.ozlabs.org/patch/87145/
> 
> That approach was rejected because it would register the same handler
> n-times where one time would do. Your other approach puts too much
> mach-specific details into the driver IMO and probably won't scale very
> well. Maybe we should add something to the private dma_data (like flags
> indicating SHARED) and then do some refcounting?

Why not just request the interrupt once when the mxs-dma stuff probes,
rather than requesting it every time a channel is allocated?

The interrupt handler itself is written to process all channels on the
device anyway, so you only need it registered once.  Using IRQF_SHARED
to register multiple identical handlers is just idiotic, and adding
refcounting is needless complexity.
