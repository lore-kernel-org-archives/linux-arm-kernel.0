From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 15:36:43 -0700
Subject: [PATCH 3/3] ARM: tegra: use section-sized static mappings for LPAE too
In-Reply-To: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1385419003-11348-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The static mappings for Tegra's PPSB and APB regions were sized at 1MB
in order to allow mapping via sections in order to avoid burning RAM for
PTEs. On LPAE, sections are 2MB, so the static mappings need to be
larger in order to gain the same benefit. Set IO_{PPSB,APB}_SIZE to
SECTION_SIZE so this adjusts automatically.

While we're fiddling with iomap.h, compress IO_{IRAM,CPU}_VIRT together
to save virtual address space in the vmalloc region; these two regions
are mapped using PTEs.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/iomap.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 26b1c2ad0ceb..ee79808e93a3 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -19,6 +19,7 @@
 #ifndef __MACH_TEGRA_IOMAP_H
 #define __MACH_TEGRA_IOMAP_H
 
+#include <asm/pgtable.h>
 #include <asm/sizes.h>
 
 #define TEGRA_IRAM_BASE			0x40000000
@@ -115,27 +116,26 @@
  * two 256MB io windows (that actually only use about 64KB
  * at the start of each).
  *
- * We will just map the first 1MB of each window (to minimize
+ * We will just map the first MMU section of each window (to minimize
  * pt entries needed) and provide a macro to transform physical
  * io addresses to an appropriate void __iomem *.
- *
  */
 
 #define IO_IRAM_PHYS	0x40000000
 #define IO_IRAM_VIRT	IOMEM(0xFE400000)
 #define IO_IRAM_SIZE	SZ_256K
 
-#define IO_CPU_PHYS     0x50040000
-#define IO_CPU_VIRT     IOMEM(0xFE000000)
+#define IO_CPU_PHYS	0x50040000
+#define IO_CPU_VIRT	IOMEM(0xFE440000)
 #define IO_CPU_SIZE	SZ_16K
 
 #define IO_PPSB_PHYS	0x60000000
 #define IO_PPSB_VIRT	IOMEM(0xFE200000)
-#define IO_PPSB_SIZE	SZ_1M
+#define IO_PPSB_SIZE	SECTION_SIZE
 
 #define IO_APB_PHYS	0x70000000
-#define IO_APB_VIRT	IOMEM(0xFE300000)
-#define IO_APB_SIZE	SZ_1M
+#define IO_APB_VIRT	IOMEM(0xFE000000)
+#define IO_APB_SIZE	SECTION_SIZE
 
 #define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
-- 
1.8.1.5
