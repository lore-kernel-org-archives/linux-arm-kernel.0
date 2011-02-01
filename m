From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 10:54:08 +0000
Subject: [PATCH] mmci: restrict DMA usage to large, even multiblock
	transfers
In-Reply-To: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20110201105408.GA31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 11:41:13AM +0100, Linus Walleij wrote:
> This will restrict the use of DMA to only cover multi-block
> transfers of blocks that are evenly divisible with the FIFO
> halfsize (8 4-byte words, 32 bytes). This will be true for any
> normal, large MMC file transfer, falling back to PIO mode for
> any smallish reads.

That's a very bad idea.  If it's an ARM primecell, and we (by some magical
reason) are using DMA, we want to always use DMA for transfers larger than
the FIFO depth.  If we switch to PIO mode, we will see FIFO overruns/
underruns if the CPU can't keep up with the data rate.

So I think you actually want:

	if (host->size >= variant->fifosize &&
	    !mmci_dma_start_data(host, datactrl))
		return;
