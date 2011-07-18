From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2011 11:10:30 +0100
Subject: [PATCH v3] pxa2xx_spi: fix memory corruption
In-Reply-To: <20110715213106.GM2833@ponder.secretlab.ca>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
	<20110715081242.GM23270@n2100.arm.linux.org.uk>
	<20110715195003.GG2833@ponder.secretlab.ca>
	<20110715202421.GE24628@n2100.arm.linux.org.uk>
	<20110715213106.GM2833@ponder.secretlab.ca>
Message-ID: <20110718101030.GS23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 03:31:06PM -0600, Grant Likely wrote:
> ... plus care must be taken not to accidentally reload the line into
> cache after it has been pushed out for DMA, which is a risk on
> structures with embedded DMA buffers if other non-DMA elements end up
> in the same cache line.  This is the situation I was wondering about.

I don't think it matters one bit in this case - we're not caring about
the actual data read/written in the DMA, we just need to do DMA to
keep the controller happy.  That's especially true as we don't set the
address increment bit in the DMA command register, so we end up accessing
the same RAM location time and time again for each DMA transfer.

So please, merge the patch - it fixes a serious memory-scribbling bug.
