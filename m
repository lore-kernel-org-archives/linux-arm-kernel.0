From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Apr 2012 09:57:44 +0530
Subject: [PATCH] OMAP: fix DMA vs memory ordering
In-Reply-To: <20120414132435.GS24211@n2100.arm.linux.org.uk>
References: <20120414132435.GS24211@n2100.arm.linux.org.uk>
Message-ID: <4F8B9FC0.6090406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 April 2012 06:54 PM, Russell King - ARM Linux wrote:
> Using coherent DMA memory with the OMAP DMA engine results in
> unpredictable behaviour due to memory ordering issues; as things stand,
> there is no guarantee that data written to coherent DMA memory will be
> visible to the DMA hardware.
> 
> This is because the OMAP dma_write() accessor contains no barriers,
> necessary on ARMv6 and above.  The effect of this can be seen in comments
> in the OMAP serial driver, which incorrectly talks about cache flushing
> for the coherent DMA stuff.
> 
> Rather than adding barriers to the accessors, add it in the DMA support
> code just before we enable DMA, and just after we disable DMA.  This
> avoids having barriers for every DMA register access.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
I don't why the synchronisation in dma_[start/stop] was
missing. The patch indeed make complete sense.



> Is this why no one uses DMA with the serial driver?
>
Will check if this patch helps in some of the DMA issues
seen in serial driver.

Regards
Santosh
