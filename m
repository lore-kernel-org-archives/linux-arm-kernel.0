From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:46 +0200
Subject: [PATCH 11/16] arm/mx2/mx21ads: fold board header in its only user
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mach-mx21ads.c               |   36 ++++++++++++++++-
 arch/arm/plat-mxc/include/mach/board-mx21ads.h |   52 ------------------------
 2 files changed, 35 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx21ads.h

diff --git a/arch/arm/mach-mx2/mach-mx21ads.c b/arch/arm/mach-mx2/mach-mx21ads.c
index 113e58d..99f2492 100644
--- a/arch/arm/mach-mx2/mach-mx21ads.c
+++ b/arch/arm/mach-mx2/mach-mx21ads.c
@@ -33,10 +33,44 @@
 #include <mach/iomux-mx21.h>
 #include <mach/mxc_nand.h>
 #include <mach/mmc.h>
-#include <mach/board-mx21ads.h>
 
 #include "devices.h"
 
+/*
+ * Memory-mapped I/O on MX21ADS base board
+ */
+#define MX21ADS_MMIO_BASE_ADDR   0xf5000000
+#define MX21ADS_MMIO_SIZE        SZ_16M
+
+#define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
+		(MX21ADS_MMIO_BASE_ADDR + (offset))
+
+#define MX21ADS_CS8900A_IRQ         IRQ_GPIOE(11)
+#define MX21ADS_CS8900A_IOBASE_REG  MX21ADS_REG_ADDR(0x000000)
+#define MX21ADS_ST16C255_IOBASE_REG MX21ADS_REG_ADDR(0x200000)
+#define MX21ADS_VERSION_REG         MX21ADS_REG_ADDR(0x400000)
+#define MX21ADS_IO_REG              MX21ADS_REG_ADDR(0x800000)
+
+/* MX21ADS_IO_REG bit definitions */
+#define MX21ADS_IO_SD_WP        0x0001 /* read */
+#define MX21ADS_IO_TP6          0x0001 /* write */
+#define MX21ADS_IO_SW_SEL       0x0002 /* read */
+#define MX21ADS_IO_TP7          0x0002 /* write */
+#define MX21ADS_IO_RESET_E_UART 0x0004
+#define MX21ADS_IO_RESET_BASE   0x0008
+#define MX21ADS_IO_CSI_CTL2     0x0010
+#define MX21ADS_IO_CSI_CTL1     0x0020
+#define MX21ADS_IO_CSI_CTL0     0x0040
+#define MX21ADS_IO_UART1_EN     0x0080
+#define MX21ADS_IO_UART4_EN     0x0100
+#define MX21ADS_IO_LCDON        0x0200
+#define MX21ADS_IO_IRDA_EN      0x0400
+#define MX21ADS_IO_IRDA_FIR_SEL 0x0800
+#define MX21ADS_IO_IRDA_MD0_B   0x1000
+#define MX21ADS_IO_IRDA_MD1     0x2000
+#define MX21ADS_IO_LED4_ON      0x4000
+#define MX21ADS_IO_LED3_ON      0x8000
+
 static unsigned int mx21ads_pins[] = {
 
 	/* CS8900A */
diff --git a/arch/arm/plat-mxc/include/mach/board-mx21ads.h b/arch/arm/plat-mxc/include/mach/board-mx21ads.h
deleted file mode 100644
index 0cf4fa2..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx21ads.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX21ADS_H__
-#define __ASM_ARCH_MXC_BOARD_MX21ADS_H__
-
-/*
- * Memory-mapped I/O on MX21ADS base board
- */
-#define MX21ADS_MMIO_BASE_ADDR   0xF5000000
-#define MX21ADS_MMIO_SIZE        SZ_16M
-
-#define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
-		(MX21ADS_MMIO_BASE_ADDR + (offset))
-
-#define MX21ADS_CS8900A_IRQ         IRQ_GPIOE(11)
-#define MX21ADS_CS8900A_IOBASE_REG  MX21ADS_REG_ADDR(0x000000)
-#define MX21ADS_ST16C255_IOBASE_REG MX21ADS_REG_ADDR(0x200000)
-#define MX21ADS_VERSION_REG         MX21ADS_REG_ADDR(0x400000)
-#define MX21ADS_IO_REG              MX21ADS_REG_ADDR(0x800000)
-
-/* MX21ADS_IO_REG bit definitions */
-#define MX21ADS_IO_SD_WP        0x0001 /* read */
-#define MX21ADS_IO_TP6          0x0001 /* write */
-#define MX21ADS_IO_SW_SEL       0x0002 /* read */
-#define MX21ADS_IO_TP7          0x0002 /* write */
-#define MX21ADS_IO_RESET_E_UART 0x0004
-#define MX21ADS_IO_RESET_BASE   0x0008
-#define MX21ADS_IO_CSI_CTL2     0x0010
-#define MX21ADS_IO_CSI_CTL1     0x0020
-#define MX21ADS_IO_CSI_CTL0     0x0040
-#define MX21ADS_IO_UART1_EN     0x0080
-#define MX21ADS_IO_UART4_EN     0x0100
-#define MX21ADS_IO_LCDON        0x0200
-#define MX21ADS_IO_IRDA_EN      0x0400
-#define MX21ADS_IO_IRDA_FIR_SEL 0x0800
-#define MX21ADS_IO_IRDA_MD0_B   0x1000
-#define MX21ADS_IO_IRDA_MD1     0x2000
-#define MX21ADS_IO_LED4_ON      0x4000
-#define MX21ADS_IO_LED3_ON      0x8000
-
-#endif				/* __ASM_ARCH_MXC_BOARD_MX21ADS_H__ */
-- 
1.7.0
