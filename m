From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Apr 2010 11:36:20 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <w2hc70ff3ad1004120056za5960033ja97e2046d17a7f24@mail.gmail.com>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<w2hc70ff3ad1004120056za5960033ja97e2046d17a7f24@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1004121122050.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Apr 2010, saeed bishara wrote:

> Nico, thanks for the patch.
> I've ported it for 2.6.32.9 kernel, can you have a look at the
> attached patch?

That patch is bad.

|diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
|index b9590a7..5286d71 100644
|--- a/arch/arm/mm/dma-mapping.c
|+++ b/arch/arm/mm/dma-mapping.c
|@@ -602,6 +602,11 @@ static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
| 			vaddr += offset;
| 			inner_op(vaddr, vaddr + size);
| 			kunmap_high(page);
|+		} else if (cache_is_vipt()) {
|+			pte_t saved_pte;
|+			vaddr = kmap_high_l1_vipt(page, &saved_pte);
|+			inner_op(vaddr, vaddr + size);
|+			kunmap_high_l1_vipt(page, saved_pte);
| 		}
| 	}

You should add 'offset' to 'vaddr' before passing it to inner_op(), just 
like it is done 6 lines above it.

Also you left out the addition of the unconditional flush in 
v6_copy_user_highpage_nonaliasing() which is needed now that 
kunmap_atomic() doesn't flush the cache anymore on ARMv6.


Nicolas
