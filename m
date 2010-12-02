From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 21:14:21 +0000
Subject: Mainline OMAP3 breakage (and other OMAP?)
Message-ID: <20101202211421.GG10461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been around since October:

drivers/video/omap2/vram.c: In function ?omap_vram_reserve_sdram_memblock?:
drivers/video/omap2/vram.c:573: error: ?MEMBLOCK_REAL_LIMIT? undeclared (first use in this function)
drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
drivers/video/omap2/vram.c:573: error: for each function it appears in.)

This requires a trivial one-liner compile fix:

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index fed2a72..a8973f0 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		paddr = memblock_alloc(size, PAGE_SIZE);
 	}
 
 	omap_vram_add_region(paddr, size);

which restores the old behaviour before the X86 memblock changes went
in.  Yes, there may be other changes due to the ioremap stuff, but
that's really no excuse for not fixing the compile error itself.
