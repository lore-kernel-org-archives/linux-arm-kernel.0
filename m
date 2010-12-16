From: jean.pihet@newoldbits.com (jean.pihet at newoldbits.com)
Date: Thu, 16 Dec 2010 18:50:53 +0100
Subject: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
In-Reply-To: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Message-ID: <1292521858-3810-3-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <j-pihet@ti.com>

The SRAM PA addresses are locally defined and used in both the
SRAM management code and the idle sleep code.
A global macro defines the values at a centralized place, for
easier maintenance.

Tested on N900 and Beagleboard with full RET and OFF modes,
using cpuidle and suspend.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/sdrc.h |    7 +++++++
 arch/arm/plat-omap/sram.c  |    7 ++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 68f57bb..ada596b 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -74,5 +74,12 @@ static inline u32 sms_read_reg(u16 reg)
  */
 #define SDRC_MPURATE_LOOPS		96
 
+/*
+ * OMAP2+: define the SRAM PA addresses.
+ * Used by the SRAM management code and the idle sleep code.
+ */
+#define OMAP2_SRAM_PA		0x40200000
+#define OMAP3_SRAM_PA           0x40200000
+#define OMAP4_SRAM_PA		0x40300000
 
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 819ea0c..1a686c8 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -41,15 +41,12 @@
 
 #define OMAP1_SRAM_PA		0x20000000
 #define OMAP1_SRAM_VA		VMALLOC_END
-#define OMAP2_SRAM_PA		0x40200000
-#define OMAP2_SRAM_PUB_PA	0x4020f800
+#define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
 #define OMAP2_SRAM_VA		0xfe400000
 #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
-#define OMAP3_SRAM_PA           0x40200000
 #define OMAP3_SRAM_VA           0xfe400000
-#define OMAP3_SRAM_PUB_PA       0x40208000
+#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
 #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
-#define OMAP4_SRAM_PA		0x40300000
 #define OMAP4_SRAM_VA		0xfe400000
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
-- 
1.7.1
