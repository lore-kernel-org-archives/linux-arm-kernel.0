From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 10:14:37 +0000
Subject: [PATCH] mm: improve/fix ARM v7_dma_inv_range() unaligned address
 handling
In-Reply-To: <1541444814.537.8.camel@sageembedded.com>
References: <1541444814.537.8.camel@sageembedded.com>
Message-ID: <20181106101437.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 11:06:54AM -0800, Chris Cole wrote:
> This patch addresses possible memory corruption when
> v7_dma_inv_range(start_address, end_address) address parameters are not
> aligned to whole cache lines. This function issues "invalidate" cache
> management operations to all cache lines from start_address (inclusive)
> to end_address (exclusive). When start_address and/or end_address are
> not aligned, the start and/or end cache lines are first issued "clean &
> invalidate" operation. The assumption is this is done to ensure that any
> dirty data addresses outside the address range (but part of the first or
> last cache lines) are cleaned/flushed so that data is not lost, which
> could happen if just an invalidate is issued.
> 
> The problem is that these first/last partial cache lines are issued
> "clean & invalidate" and then "invalidate". This second "invalidate" is
> not required and worse can cause "lost" writes to addresses outside the
> address range but part of the cache line. If another component writes to
> its part of the cache line between the "clean & invalidate" and
> "invalidate" operations, the write can get lost. This fix is to remove
> the extra "invalidate" operation when unaligned addressed are used.
> 
> A kernel module is available that has a stress test to reproduce the
> issue and a unit test of the updated v7_dma_inv_range(). It can be
> downloaded from
> http://ftp.sageembedded.com/outgoing/linux/cache-test-20181102.tgz.
> 
> v7_dma_inv_range() is call by dmac_[un]map_area(addr, len, direction)
> when the direction is DMA_FROM_DEVICE. One can (I believe) successfully
> argue that DMA from a device to main memory should use buffers aligned
> to cache line size, because the "clean & invalidate" might overwrite
> data that the device just wrote using DMA. But if a driver does use
> unaligned buffers, at least this fix will prevent memory corruption
> outside the buffer.
> 
> Signed-off-by: chris at sageembedded.com

I think there's a simpler patch to this:

 arch/arm/mm/cache-v7.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 215df435bfb9..2149b47a0c5a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -360,14 +360,16 @@ ENDPROC(v7_flush_kern_dcache_area)
 	ALT_UP(W(nop))
 #endif
 	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
+	addne	r0, r0, r2			@ next cache line
 
 	tst	r1, r3
 	bic	r1, r1, r3
 	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
-1:
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
-	add	r0, r0, r2
 	cmp	r0, r1
+1:
+	mcrlo	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
+	addlo	r0, r0, r2
+	cmplo	r0, r1
 	blo	1b
 	dsb	st
 	ret	lr

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
