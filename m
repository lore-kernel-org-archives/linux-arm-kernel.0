From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:19 -0700
Subject: [PATCH 4/8] OMAP2420 IO mapping: move IVA mapping virtual address out
	of vmalloc space
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042018.27280.57238.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 10db25fea4c11661070b97832b8cc3d2af495092 causes the following
kernel messages during N800 boot (and presumably all other 2420
boards):

[    0.000000] BUG: mapping for 0x58000000 at 0xe0000000 overlaps vmalloc space
[    0.000000] BUG: mapping for 0x59000000 at 0xe1000000 overlaps vmalloc space
[    0.000000] BUG: mapping for 0x5a000000 at 0xe2000000 overlaps vmalloc space

Fix by remapping the IVA memory areas somewhere outside vmalloc space.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/io.h |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 7d6f45f..a3e7b47 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -123,14 +123,17 @@
 #define OMAP243X_SMS_SIZE	SZ_1M
 
 /* 2420 IVA */
-#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
-#define DSP_MEM_2420_VIRT	0xe0000000
+#define DSP_MEM_2420_PHYS	OMAP2420_DSP_MEM_BASE
+						/* 0x58000000 --> 0xfc100000 */
+#define DSP_MEM_2420_VIRT	0xfc100000
 #define DSP_MEM_2420_SIZE	0x28000
-#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE	/* 0x59000000 */
-#define DSP_IPI_2420_VIRT	0xe1000000
+#define DSP_IPI_2420_PHYS	OMAP2420_DSP_IPI_BASE
+						/* 0x59000000 --> 0xfc128000 */
+#define DSP_IPI_2420_VIRT	0xfc128000
 #define DSP_IPI_2420_SIZE	SZ_4K
-#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE	/* 0x5a000000 */
-#define DSP_MMU_2420_VIRT	0xe2000000
+#define DSP_MMU_2420_PHYS	OMAP2420_DSP_MMU_BASE
+						/* 0x5a000000 --> 0xfc129000 */
+#define DSP_MMU_2420_VIRT	0xfc129000
 #define DSP_MMU_2420_SIZE	SZ_4K
 
 /* 2430 IVA2.1 - currently unmapped */
