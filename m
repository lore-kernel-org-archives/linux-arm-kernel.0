From: rshitrit@marvell.com (Ronen Shitrit)
Date: Thu, 26 Nov 2009 15:21:56 +0200
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091125162641.GA5136@n2100.arm.linux.org.uk>
References: <20091124200019.GH17481@n2100.arm.linux.org.uk>
	<1259151279.30270.56.camel@pc1117.cambridge.arm.com>
	<20091125162641.GA5136@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A9347E2121F6F5@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was just about to start working on a specific unmap for Kirkwood when I noticed this on going work...
Kirkwood (_ARMv5_) is also using speculative prefetch and need the below unmap invalidate fix.

Regards

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
Sent: Wednesday, November 25, 2009 6:27 PM
To: Catalin Marinas
Cc: saeed bishara; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses

On Wed, Nov 25, 2009 at 12:14:39PM +0000, Catalin Marinas wrote:
> I'm getting confused. Can we not just implement a generic dma_map_range
> and dma_unmap_range in terms of dma_clean_range and dma_inv_range as
> low-level CPU support functions?

That depends if you want to create something like:

static void dma_unmap_range(const void *kaddr, size_t size, enum dma_direction dir)
{
	if ((cpu_is_xxx() || cpu_is_yyy()...) && dir != DMA_TO_DEVICE) {
		outer_inv_range(kaddr, kaddr + size);
		dma_inv_range(kaddr, kaddr + size);
	}
}

static void dma_map_range(const void *kaddr, size_t size, enum dma_direction dir)
{
	if (cpu_is_xxx() || cpu_is_yyy()) {
		if (dir == DMA_TO_DEVICE) {
			dma_clean_range(kaddr, kaddr + size);
			outer_clean_range(kaddr, kaddr + size);
		} else {
			dma_inv_range(kaddr, kaddr + size);
			outer_inv_range(kaddr, kaddr + size);
		}
	} else {
		switch (dir) {
		case DMA_TO_DEVICE:
			dma_clean_range(kaddr, kaddr + size);
			outer_clean_range(kaddr, kaddr + size);
			break;
		case DMA_FROM_DEVICE:
			dma_inv_range(kaddr, kaddr + size);
			outer_inv_range(kaddr, kaddr + size);
			break;
		case DMA_BIDIRECTIONAL:
			dma_flush_range(kaddr, kaddr + size);
			outer_flush_range(kaddr, kaddr + size);
			break;
		}
	}
}

This is utterly stupid, since the functions we're calling are already
CPU specific, and adds extra needless overhead where its plainly not
necessary - just because we have two stupid cases, one where the API
is being mis-used and one where its being used in hacky code.

I'd rather have the decisions about what to do on map/unmap entirely
in CPU specific code, but first we need to eliminate the two hacks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
