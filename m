From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:23 -0600
Subject: [PATCH 10/15] ARM: tegra: clean-up mach/io.h
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move tegra specific mach/io.h parts into iomap.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-tegra/include/mach/io.h    |   48 ------------------------------
 arch/arm/mach-tegra/include/mach/iomap.h |   48 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/io.c                 |    1 +
 3 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
index f15deff..47b4b61 100644
--- a/arch/arm/mach-tegra/include/mach/io.h
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -23,56 +23,8 @@
 
 #define IO_SPACE_LIMIT 0xffff
 
-/* On TEGRA, many peripherals are very closely packed in
- * two 256MB io windows (that actually only use about 64KB
- * at the start of each).
- *
- * We will just map the first 1MB of each window (to minimize
- * pt entries needed) and provide a macro to transform physical
- * io addresses to an appropriate void __iomem *.
- *
- */
-
-#ifdef __ASSEMBLY__
-#define IOMEM(x)	(x)
-#else
-#define IOMEM(x)	((void __force __iomem *)(x))
-#endif
-
-#define IO_IRAM_PHYS	0x40000000
-#define IO_IRAM_VIRT	IOMEM(0xFE400000)
-#define IO_IRAM_SIZE	SZ_256K
-
-#define IO_CPU_PHYS     0x50040000
-#define IO_CPU_VIRT     IOMEM(0xFE000000)
-#define IO_CPU_SIZE	SZ_16K
-
-#define IO_PPSB_PHYS	0x60000000
-#define IO_PPSB_VIRT	IOMEM(0xFE200000)
-#define IO_PPSB_SIZE	SZ_1M
-
-#define IO_APB_PHYS	0x70000000
-#define IO_APB_VIRT	IOMEM(0xFE300000)
-#define IO_APB_SIZE	SZ_1M
-
-#define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
-#define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
-
-#define IO_TO_VIRT(n) ( \
-	IO_TO_VIRT_BETWEEN((n), IO_PPSB_PHYS, IO_PPSB_SIZE) ?		\
-		IO_TO_VIRT_XLATE((n), IO_PPSB_PHYS, IO_PPSB_VIRT) :	\
-	IO_TO_VIRT_BETWEEN((n), IO_APB_PHYS, IO_APB_SIZE) ?		\
-		IO_TO_VIRT_XLATE((n), IO_APB_PHYS, IO_APB_VIRT) :	\
-	IO_TO_VIRT_BETWEEN((n), IO_CPU_PHYS, IO_CPU_SIZE) ?		\
-		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
-	IO_TO_VIRT_BETWEEN((n), IO_IRAM_PHYS, IO_IRAM_SIZE) ?		\
-		IO_TO_VIRT_XLATE((n), IO_IRAM_PHYS, IO_IRAM_VIRT) :	\
-	NULL)
-
 #ifndef __ASSEMBLER__
 
-#define IO_ADDRESS(n) (IO_TO_VIRT(n))
-
 #ifdef CONFIG_TEGRA_PCI
 extern void __iomem *tegra_pcie_io_base;
 
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 19dec3a..082b4d1 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -271,4 +271,52 @@
 # define TEGRA_DEBUG_UART_BASE TEGRA_UARTE_BASE
 #endif
 
+/* On TEGRA, many peripherals are very closely packed in
+ * two 256MB io windows (that actually only use about 64KB
+ *@the start of each).
+ *
+ * We will just map the first 1MB of each window (to minimize
+ * pt entries needed) and provide a macro to transform physical
+ * io addresses to an appropriate void __iomem *.
+ *
+ */
+
+#ifdef __ASSEMBLY__
+#define IOMEM(x)	(x)
+#else
+#define IOMEM(x)	((void __force __iomem *)(x))
+#endif
+
+#define IO_IRAM_PHYS	0x40000000
+#define IO_IRAM_VIRT	IOMEM(0xFE400000)
+#define IO_IRAM_SIZE	SZ_256K
+
+#define IO_CPU_PHYS     0x50040000
+#define IO_CPU_VIRT     IOMEM(0xFE000000)
+#define IO_CPU_SIZE	SZ_16K
+
+#define IO_PPSB_PHYS	0x60000000
+#define IO_PPSB_VIRT	IOMEM(0xFE200000)
+#define IO_PPSB_SIZE	SZ_1M
+
+#define IO_APB_PHYS	0x70000000
+#define IO_APB_VIRT	IOMEM(0xFE300000)
+#define IO_APB_SIZE	SZ_1M
+
+#define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
+#define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
+
+#define IO_TO_VIRT(n) ( \
+	IO_TO_VIRT_BETWEEN((n), IO_PPSB_PHYS, IO_PPSB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_PPSB_PHYS, IO_PPSB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_APB_PHYS, IO_APB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_APB_PHYS, IO_APB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_CPU_PHYS, IO_CPU_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_IRAM_PHYS, IO_IRAM_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_IRAM_PHYS, IO_IRAM_VIRT) :	\
+	NULL)
+
+#define IO_ADDRESS(n) (IO_TO_VIRT(n))
+
 #endif
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index d23ee2d..58b4baf 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -26,6 +26,7 @@
 
 #include <asm/page.h>
 #include <asm/mach/map.h>
+#include <mach/iomap.h>
 
 #include "board.h"
 
-- 
1.7.5.4
