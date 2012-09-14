From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:31 +0200
Subject: [PATCH 03/24] ARM: ebsa110: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ebsa110/core.c |    8 ++++----
 arch/arm/mach-ebsa110/core.h |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 6f80686..f0fe6b5 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -74,22 +74,22 @@ static struct map_desc ebsa110_io_desc[] __initdata = {
 	 * sparse external-decode ISAIO space
 	 */
 	{	/* IRQ_STAT/IRQ_MCLR */
-		.virtual	= IRQ_STAT,
+		.virtual	= (unsigned long)IRQ_STAT,
 		.pfn		= __phys_to_pfn(TRICK4_PHYS),
 		.length		= TRICK4_SIZE,
 		.type		= MT_DEVICE
 	}, {	/* IRQ_MASK/IRQ_MSET */
-		.virtual	= IRQ_MASK,
+		.virtual	= (unsigned long)IRQ_MASK,
 		.pfn		= __phys_to_pfn(TRICK3_PHYS),
 		.length		= TRICK3_SIZE,
 		.type		= MT_DEVICE
 	}, {	/* SOFT_BASE */
-		.virtual	= SOFT_BASE,
+		.virtual	= (unsigned long)SOFT_BASE,
 		.pfn		= __phys_to_pfn(TRICK1_PHYS),
 		.length		= TRICK1_SIZE,
 		.type		= MT_DEVICE
 	}, {	/* PIT_BASE */
-		.virtual	= PIT_BASE,
+		.virtual	= (unsigned long)PIT_BASE,
 		.pfn		= __phys_to_pfn(TRICK0_PHYS),
 		.length		= TRICK0_SIZE,
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-ebsa110/core.h b/arch/arm/mach-ebsa110/core.h
index c93c9e4..afe137e 100644
--- a/arch/arm/mach-ebsa110/core.h
+++ b/arch/arm/mach-ebsa110/core.h
@@ -31,11 +31,11 @@
 #define TRICK7_PHYS		0xf3c00000
 
 /* Virtual addresses */
-#define PIT_BASE		0xfc000000	/* trick 0 */
-#define SOFT_BASE		0xfd000000	/* trick 1 */
-#define IRQ_MASK		0xfe000000	/* trick 3 - read */
-#define IRQ_MSET		0xfe000000	/* trick 3 - write */
-#define IRQ_STAT		0xff000000	/* trick 4 - read */
-#define IRQ_MCLR		0xff000000	/* trick 4 - write */
+#define PIT_BASE		IOMEM(0xfc000000)	/* trick 0 */
+#define SOFT_BASE		IOMEM(0xfd000000)	/* trick 1 */
+#define IRQ_MASK		IOMEM(0xfe000000)	/* trick 3 - read */
+#define IRQ_MSET		IOMEM(0xfe000000)	/* trick 3 - write */
+#define IRQ_STAT		IOMEM(0xff000000)	/* trick 4 - read */
+#define IRQ_MCLR		IOMEM(0xff000000)	/* trick 4 - write */
 
 #endif
-- 
1.7.10
