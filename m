From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:24:58 +0900
Subject: [PATCH 2/8] ARM: shmobile: Move dma-register.h
In-Reply-To: <cover.1403487267.git.horms+renesas@verge.net.au>
References: <cover.1403487267.git.horms+renesas@verge.net.au>
Message-ID: <74ac0de8b7ee41246b8d6aae1df0618a64451435.1403487267.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of dma-register.h so it can be used as #include
"dma-register.h" instead of the old style #include <mach/dma-register.h>.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/dma-register.h              | 84 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/dma-register.h | 84 ----------------------
 arch/arm/mach-shmobile/setup-r8a73a4.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c             |  2 +-
 arch/arm/mach-shmobile/setup-sh7372.c              |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  2 +-
 7 files changed, 89 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/dma-register.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/dma-register.h

diff --git a/arch/arm/mach-shmobile/dma-register.h b/arch/arm/mach-shmobile/dma-register.h
new file mode 100644
index 0000000..97c40bd
--- /dev/null
+++ b/arch/arm/mach-shmobile/dma-register.h
@@ -0,0 +1,84 @@
+/*
+ * SH-ARM CPU-specific DMA definitions, used by both DMA drivers
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp
+ *
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * Based on arch/sh/include/cpu-sh4/cpu/dma-register.h
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef DMA_REGISTER_H
+#define DMA_REGISTER_H
+
+/*
+ *		Direct Memory Access Controller
+ */
+
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_512BIT		= 5,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+static const unsigned int dma_ts_shift[] = {
+	[XMIT_SZ_8BIT]		= 0,
+	[XMIT_SZ_16BIT]		= 1,
+	[XMIT_SZ_32BIT]		= 2,
+	[XMIT_SZ_64BIT]		= 3,
+	[XMIT_SZ_128BIT]	= 4,
+	[XMIT_SZ_256BIT]	= 5,
+	[XMIT_SZ_512BIT]	= 6,
+};
+
+#define TS_LOW_BIT	0x3 /* --xx */
+#define TS_HI_BIT	0xc /* xx-- */
+
+#define TS_LOW_SHIFT	(3)
+#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+
+#define TS_INDEX2VAL(i) \
+	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
+	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
+
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+
+
+/*
+ *		USB High-Speed DMAC
+ */
+/* Transmit sizes and respective CHCR register values */
+enum {
+	USBTS_XMIT_SZ_8BYTE		= 0,
+	USBTS_XMIT_SZ_16BYTE		= 1,
+	USBTS_XMIT_SZ_32BYTE		= 2,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+static const unsigned int dma_usbts_shift[] = {
+	[USBTS_XMIT_SZ_8BYTE]	= 3,
+	[USBTS_XMIT_SZ_16BYTE]	= 4,
+	[USBTS_XMIT_SZ_32BYTE]	= 5,
+};
+
+#define USBTS_LOW_BIT	0x3 /* --xx */
+#define USBTS_HI_BIT	0x0 /* ---- */
+
+#define USBTS_LOW_SHIFT	6
+#define USBTS_HI_SHIFT	0
+
+#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
+
+#endif /* DMA_REGISTER_H */
diff --git a/arch/arm/mach-shmobile/include/mach/dma-register.h b/arch/arm/mach-shmobile/include/mach/dma-register.h
deleted file mode 100644
index 97c40bd..0000000
--- a/arch/arm/mach-shmobile/include/mach/dma-register.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * SH-ARM CPU-specific DMA definitions, used by both DMA drivers
- *
- * Copyright (C) 2012 Renesas Solutions Corp
- *
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * Based on arch/sh/include/cpu-sh4/cpu/dma-register.h
- * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef DMA_REGISTER_H
-#define DMA_REGISTER_H
-
-/*
- *		Direct Memory Access Controller
- */
-
-/* Transmit sizes and respective CHCR register values */
-enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_512BIT		= 5,
-};
-
-/* log2(size / 8) - used to calculate number of transfers */
-static const unsigned int dma_ts_shift[] = {
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_64BIT]		= 3,
-	[XMIT_SZ_128BIT]	= 4,
-	[XMIT_SZ_256BIT]	= 5,
-	[XMIT_SZ_512BIT]	= 6,
-};
-
-#define TS_LOW_BIT	0x3 /* --xx */
-#define TS_HI_BIT	0xc /* xx-- */
-
-#define TS_LOW_SHIFT	(3)
-#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
-
-#define TS_INDEX2VAL(i) \
-	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
-	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
-
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
-
-
-/*
- *		USB High-Speed DMAC
- */
-/* Transmit sizes and respective CHCR register values */
-enum {
-	USBTS_XMIT_SZ_8BYTE		= 0,
-	USBTS_XMIT_SZ_16BYTE		= 1,
-	USBTS_XMIT_SZ_32BYTE		= 2,
-};
-
-/* log2(size / 8) - used to calculate number of transfers */
-static const unsigned int dma_usbts_shift[] = {
-	[USBTS_XMIT_SZ_8BYTE]	= 3,
-	[USBTS_XMIT_SZ_16BYTE]	= 4,
-	[USBTS_XMIT_SZ_32BYTE]	= 5,
-};
-
-#define USBTS_LOW_BIT	0x3 /* --xx */
-#define USBTS_HI_BIT	0x0 /* ---- */
-
-#define USBTS_LOW_SHIFT	6
-#define USBTS_HI_SHIFT	0
-
-#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
-
-#endif /* DMA_REGISTER_H */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 9333770..985739e 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -25,10 +25,10 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
+#include "dma-register.h"
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6050000, 0x9000),
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 35dec23..7cf4bbd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -31,7 +31,6 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/dma-register.h>
 #include <mach/r8a7740.h>
 #include <mach/pm-rmobile.h>
 #include <mach/common.h>
@@ -40,6 +39,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "dma-register.h"
 
 static struct map_desc r8a7740_io_desc[] __initdata = {
 	 /*
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 6bd08b1..3eed626 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -27,10 +27,10 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
-#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
+#include "dma-register.h"
 
 /* Audio-DMAC */
 #define AUDIO_DMAC_SLAVE(_id, _addr, t, r)			\
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 3b23ced..062929b 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -33,7 +33,6 @@
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
 #include <mach/common.h>
@@ -41,6 +40,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "dma-register.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index a758d2a..370d55c 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -32,7 +32,6 @@
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
-#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -40,6 +39,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include "dma-register.h"
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
-- 
2.0.0.rc2
