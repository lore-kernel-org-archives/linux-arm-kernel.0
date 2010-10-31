From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 31 Oct 2010 23:30:36 +0100
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit
	5bc23d32d
In-Reply-To: <20101031205210.GB30636@n2100.arm.linux.org.uk>
References: <20101031182157.GY15069@ibawizard.net>
	<20101031183140.GA30636@n2100.arm.linux.org.uk>
	<20101031190034.GZ15069@ibawizard.net>
	<20101031190833.GA15069@ibawizard.net>
	<20101031205210.GB30636@n2100.arm.linux.org.uk>
Message-ID: <20101031223036.GB15069@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> [2010-10-31 20:52:10]:

> It's being a little too over-cautious.  In arch/arm/mm/dma-mapping.c
> __dma_alloc_remap, remove the + 1 from "bit = fls(size - 1) + 1;".

Hm, that was really fast :-) It works now, thank you!

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4bc43e5..7012105 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -198,7 +198,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t
gfp, pgprot_t prot)
         * fragmentation of the DMA space, and also prevents allocations
         * smaller than a section from crossing a section boundary.
         */
-       bit = fls(size - 1) + 1;
+       bit = fls(size - 1);
        if (bit > SECTION_SHIFT)
                bit = SECTION_SHIFT;
        align = 1 << bit;

-- ynezz
