From: chris@sageembedded.com (Chris Cole)
Date: Fri, 09 Nov 2018 10:15:00 -0800
Subject: [PATCH v2] mm: improve/fix ARM v7_dma_inv_range() unaligned
 address handling
In-Reply-To: <16a08785-4999-ea6c-83cd-3e15775ef641@arm.com>
References: <1541626010.537.49.camel@sageembedded.com>
 <16a08785-4999-ea6c-83cd-3e15775ef641@arm.com>
Message-ID: <1541787300.537.67.camel@sageembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Thu, 2018-11-08 at 09:34 +0000, Vladimir Murzin wrote:
> Hi Chris,
> 
> On 07/11/18 21:26, Chris Cole wrote:
> > This patch addresses possible memory corruption when
> > v7_dma_inv_range(start_address, end_address) address parameters are not
> > aligned to whole cache lines. This function issues "invalidate" cache
> > management operations to all cache lines from start_address (inclusive)
> > to end_address (exclusive). When start_address and/or end_address are
> > not aligned, the start and/or end cache lines are first issued "clean &
> > invalidate" operation. The assumption is this is done to ensure that any
> > dirty data addresses outside the address range (but part of the first or
> > last cache lines) are cleaned/flushed so that data is not lost, which
> > could happen if just an invalidate is issued.
> > 
> > The problem is that these first/last partial cache lines are issued
> > "clean & invalidate" and then "invalidate". This second "invalidate" is
> > not required and worse can cause "lost" writes to addresses outside the
> > address range but part of the cache line. If another component writes to
> > its part of the cache line between the "clean & invalidate" and
> > "invalidate" operations, the write can get lost. This fix is to remove
> > the extra "invalidate" operation when unaligned addressed are used.
> > 
> > A kernel module is available that has a stress test to reproduce the
> > issue and a unit test of the updated v7_dma_inv_range(). It can be
> > downloaded from
> > http://ftp.sageembedded.com/outgoing/linux/cache-test-20181107.tgz.
> > 
> > v7_dma_inv_range() is call by dmac_[un]map_area(addr, len, direction)
> > when the direction is DMA_FROM_DEVICE. One can (I believe) successfully
> > argue that DMA from a device to main memory should use buffers aligned
> > to cache line size, because the "clean & invalidate" might overwrite
> > data that the device just wrote using DMA. But if a driver does use
> > unaligned buffers, at least this fix will prevent memory corruption
> > outside the buffer.
> > 
> > Signed-off-by: Chris Cole <chris@sageembedded.com>
> > Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
> > ---
> > 
> > V2: Use simpler assembly code suggested by Russel King
> 
> I'm wondering if you can update v7m_dma_inv_range as well? The whole
> cache-v7m.S was lifted form cache-v7.S, so it is likely suffers from
> the same issue.

My preference would be to have someone else create a separate patch
for v7m. I am not totally comfortable including v7m since I don't
have any hardware to test the changes.

But this is my first patch to Linux and not sure what the preference
is. If this is strong desire include in the same patch, I can do that.

> 
> This is build tested diff (I have no access to DMA capable platform
> I can test the diff on; hope Alex or Andr?s can give it a go)

In terms of the patch for arch/arm/mm/cache-v7m.S, I believe 
a "cmp r0, r1" needs to be added before the "1:" label.
Like the following.

diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 788486e830d3..32aa2a2aa260 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -73,9 +73,11 @@
 /*
  * dcimvac: Invalidate data cache line by MVA to PoC
  */
-.macro dcimvac, rt, tmp
-	v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC
+.irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
+.macro dcimvac\c, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC, \c
 .endm
+.endr
 
 /*
  * dccmvau: Clean data cache line by MVA to PoU
@@ -369,14 +371,16 @@ v7m_dma_inv_range:
 	tst	r0, r3
 	bic	r0, r0, r3
 	dccimvacne r0, r3
+	addne	r0, r0, r2
 	subne	r3, r2, #1	@ restore r3, corrupted by v7m's dccimvac
 	tst	r1, r3
 	bic	r1, r1, r3
 	dccimvacne r1, r3
-1:
-	dcimvac r0, r3
-	add	r0, r0, r2
 	cmp	r0, r1
+1:
+	dcimvaclo r0, r3
+	addlo	r0, r0, r2
+	cmplo	r0, r1
 	blo	1b
 	dsb	st
 	ret	lr
