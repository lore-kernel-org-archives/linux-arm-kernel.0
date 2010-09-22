From: grfstrm@users.sourceforge.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Wed, 22 Sep 2010 16:49:22 +0200
Subject: [RFC] ARM: DMA coherent allocator: align remapped addresses
In-Reply-To: <20100725135024.GA6609@n2100.arm.linux.org.uk>
References: <20100725135024.GA6609@n2100.arm.linux.org.uk>
Message-ID: <4C9A1772.4000502@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-07-25 15:50, Russell King - ARM Linux wrote:
> +	 * Align the virtual region allocation - maximum alignment is
> +	 * a section size, minimum is a page size.  This helps reduce
> +	 * fragmentation of the DMA space, and also prevents allocations
> +	 * smaller than a section from crossing a section boundary.
> +	 */
> +	bit = fls(size - 1) + 1;
> +	if (bit > SECTION_SHIFT)
> +		bit = SECTION_SHIFT;
> +	align = 1 << bit;

A size of 4096 results in an alignment of 8192. Is that really intended?
ixp4xx seems to run out of vmregion due to this. The patch below makes it work again.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4bc43e5..7012105 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -198,7 +198,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 	 * fragmentation of the DMA space, and also prevents allocations
 	 * smaller than a section from crossing a section boundary.
 	 */
-	bit = fls(size - 1) + 1;
+	bit = fls(size - 1);
 	if (bit > SECTION_SHIFT)
 		bit = SECTION_SHIFT;
 	align = 1 << bit;
