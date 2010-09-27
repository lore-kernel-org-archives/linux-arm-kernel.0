From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:47 +0200
Subject: [PATCH 11/40] ARM: mx51: use IMX_IO_ADDRESS to define MX51_IO_ADDRESS
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx51.h |   53 +++++++--------------------------
 1 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index d0fda39..f602650 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -163,6 +163,17 @@
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
 
+#define MX51_IO_ADDRESS(x) (						\
+	IMX_IO_ADDRESS(x, MX51_IRAM) ?:					\
+	IMX_IO_ADDRESS(x, MX51_DEBUG) ?:				\
+	IMX_IO_ADDRESS(x, MX51_SPBA0) ?:				\
+	IMX_IO_ADDRESS(x, MX51_AIPS1) ?:				\
+	IMX_IO_ADDRESS(x, MX51_AIPS2))
+
+/* This is currently used in <mach/debug-macro.S>, but should go away */
+#define MX51_AIPS1_IO_ADDRESS(x)  \
+	(((x) - MX51_AIPS1_BASE_ADDR) + MX51_AIPS1_BASE_ADDR_VIRT)
+
 /*
  * defines for SPBA modules
  */
@@ -210,48 +221,6 @@
 #define MX51_MXC_DMA_CHANNEL_ATA_TX	MXC_DMA_DYNAMIC_CHANNEL
 #define MX51_MXC_DMA_CHANNEL_MEMORY	MXC_DMA_DYNAMIC_CHANNEL
 
-/* Does given address belongs to the specified memory region? */
-#define ADDRESS_IN_REGION(addr, start, size)			\
-	(((addr) >= (start)) && ((addr) < (start)+(size)))
-
-/* Does given address belongs to the specified named `module'? */
-#define MX51_IS_MODULE(addr, module)			       \
-	ADDRESS_IN_REGION(addr, MX51_ ## module ## _BASE_ADDR, \
-				MX51_ ## module ## _SIZE)
-/*
- * This macro defines the physical to virtual address mapping for all the
- * peripheral modules. It is used by passing in the physical address as x
- * and returning the virtual address. If the physical address is not mapped,
- * it returns 0xdeadbeef
- */
-
-#define MX51_IO_ADDRESS(x)					\
-	(void __iomem *)					\
-	(MX51_IS_MODULE(x, IRAM) ? MX51_IRAM_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, DEBUG) ? MX51_DEBUG_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, SPBA0) ? MX51_SPBA0_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, AIPS2) ? MX51_AIPS2_IO_ADDRESS(x) : \
-	0xdeadbeef)
-
-/*
- * define the address mapping macros: in physical address order
- */
-#define MX51_IRAM_IO_ADDRESS(x)  \
-	(((x) - MX51_IRAM_BASE_ADDR) + MX51_IRAM_BASE_ADDR_VIRT)
-
-#define MX51_DEBUG_IO_ADDRESS(x)  \
-	(((x) - MX51_DEBUG_BASE_ADDR) + MX51_DEBUG_BASE_ADDR_VIRT)
-
-#define MX51_SPBA0_IO_ADDRESS(x)  \
-	(((x) - MX51_SPBA0_BASE_ADDR) + MX51_SPBA0_BASE_ADDR_VIRT)
-
-#define MX51_AIPS1_IO_ADDRESS(x)  \
-	(((x) - MX51_AIPS1_BASE_ADDR) + MX51_AIPS1_BASE_ADDR_VIRT)
-
-#define MX51_AIPS2_IO_ADDRESS(x)  \
-	(((x) - MX51_AIPS2_BASE_ADDR) + MX51_AIPS2_BASE_ADDR_VIRT)
-
 #define MX51_IS_MEM_DEVICE_NONSHARED(x)		0
 
 /*
-- 
1.7.2.3
