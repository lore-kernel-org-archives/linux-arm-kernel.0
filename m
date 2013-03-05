From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:23 +0100
Subject: [PATCH 13/23] mtd: onenand/samsung: make regs-onenand.h file local
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing uses the NAND register definitions other than the
actual driver, so we can move the header file into the
same local directory, which lets us build it in a multiplatform
configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-samsung/include/plat/regs-onenand.h | 63 -----------------------
 drivers/mtd/onenand/samsung.c                     |  4 +-
 drivers/mtd/onenand/samsung.h                     | 61 ++++++++++++++++++++++
 3 files changed, 63 insertions(+), 65 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-onenand.h
 create mode 100644 drivers/mtd/onenand/samsung.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-onenand.h b/arch/arm/plat-samsung/include/plat/regs-onenand.h
deleted file mode 100644
index 930ea8b..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-onenand.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * linux/arch/arm/plat-s3c/include/plat/regs-onenand.h
- *
- *  Copyright (C) 2008-2010 Samsung Electronics
- *  Kyungmin Park <kyungmin.park@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __SAMSUNG_ONENAND_H__
-#define __SAMSUNG_ONENAND_H__
-
-#include <mach/hardware.h>
-
-/*
- * OneNAND Controller
- */
-#define MEM_CFG_OFFSET		0x0000
-#define BURST_LEN_OFFSET	0x0010
-#define MEM_RESET_OFFSET	0x0020
-#define INT_ERR_STAT_OFFSET	0x0030
-#define INT_ERR_MASK_OFFSET	0x0040
-#define INT_ERR_ACK_OFFSET	0x0050
-#define ECC_ERR_STAT_OFFSET	0x0060
-#define MANUFACT_ID_OFFSET	0x0070
-#define DEVICE_ID_OFFSET	0x0080
-#define DATA_BUF_SIZE_OFFSET	0x0090
-#define BOOT_BUF_SIZE_OFFSET	0x00A0
-#define BUF_AMOUNT_OFFSET	0x00B0
-#define TECH_OFFSET		0x00C0
-#define FBA_WIDTH_OFFSET	0x00D0
-#define FPA_WIDTH_OFFSET	0x00E0
-#define FSA_WIDTH_OFFSET	0x00F0
-#define TRANS_SPARE_OFFSET	0x0140
-#define DBS_DFS_WIDTH_OFFSET	0x0160
-#define INT_PIN_ENABLE_OFFSET	0x01A0
-#define ACC_CLOCK_OFFSET	0x01C0
-#define FLASH_VER_ID_OFFSET	0x01F0
-#define FLASH_AUX_CNTRL_OFFSET	0x0300		/* s3c64xx only */
-
-#define ONENAND_MEM_RESET_HOT	0x3
-#define ONENAND_MEM_RESET_COLD	0x2
-#define ONENAND_MEM_RESET_WARM	0x1
-
-#define CACHE_OP_ERR		(1 << 13)
-#define RST_CMP			(1 << 12)
-#define RDY_ACT			(1 << 11)
-#define INT_ACT			(1 << 10)
-#define UNSUP_CMD		(1 << 9)
-#define LOCKED_BLK		(1 << 8)
-#define BLK_RW_CMP		(1 << 7)
-#define ERS_CMP			(1 << 6)
-#define PGM_CMP			(1 << 5)
-#define LOAD_CMP		(1 << 4)
-#define ERS_FAIL		(1 << 3)
-#define PGM_FAIL		(1 << 2)
-#define INT_TO			(1 << 1)
-#define LD_FAIL_ECC_ERR		(1 << 0)
-
-#define TSRF			(1 << 0)
-
-#endif
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 33f2a8f..2cf7408 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -23,11 +23,11 @@
 #include <linux/mtd/partitions.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 #include <asm/mach/flash.h>
-#include <plat/regs-onenand.h>
 
-#include <linux/io.h>
+#include "samsung.h"
 
 enum soc_type {
 	TYPE_S3C6400,
diff --git a/drivers/mtd/onenand/samsung.h b/drivers/mtd/onenand/samsung.h
new file mode 100644
index 0000000..c4a80e6
--- /dev/null
+++ b/drivers/mtd/onenand/samsung.h
@@ -0,0 +1,61 @@
+/*
+ * linux/arch/arm/plat-s3c/include/plat/regs-onenand.h
+ *
+ *  Copyright (C) 2008-2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __SAMSUNG_ONENAND_H__
+#define __SAMSUNG_ONENAND_H__
+
+/*
+ * OneNAND Controller
+ */
+#define MEM_CFG_OFFSET		0x0000
+#define BURST_LEN_OFFSET	0x0010
+#define MEM_RESET_OFFSET	0x0020
+#define INT_ERR_STAT_OFFSET	0x0030
+#define INT_ERR_MASK_OFFSET	0x0040
+#define INT_ERR_ACK_OFFSET	0x0050
+#define ECC_ERR_STAT_OFFSET	0x0060
+#define MANUFACT_ID_OFFSET	0x0070
+#define DEVICE_ID_OFFSET	0x0080
+#define DATA_BUF_SIZE_OFFSET	0x0090
+#define BOOT_BUF_SIZE_OFFSET	0x00A0
+#define BUF_AMOUNT_OFFSET	0x00B0
+#define TECH_OFFSET		0x00C0
+#define FBA_WIDTH_OFFSET	0x00D0
+#define FPA_WIDTH_OFFSET	0x00E0
+#define FSA_WIDTH_OFFSET	0x00F0
+#define TRANS_SPARE_OFFSET	0x0140
+#define DBS_DFS_WIDTH_OFFSET	0x0160
+#define INT_PIN_ENABLE_OFFSET	0x01A0
+#define ACC_CLOCK_OFFSET	0x01C0
+#define FLASH_VER_ID_OFFSET	0x01F0
+#define FLASH_AUX_CNTRL_OFFSET	0x0300		/* s3c64xx only */
+
+#define ONENAND_MEM_RESET_HOT	0x3
+#define ONENAND_MEM_RESET_COLD	0x2
+#define ONENAND_MEM_RESET_WARM	0x1
+
+#define CACHE_OP_ERR		(1 << 13)
+#define RST_CMP			(1 << 12)
+#define RDY_ACT			(1 << 11)
+#define INT_ACT			(1 << 10)
+#define UNSUP_CMD		(1 << 9)
+#define LOCKED_BLK		(1 << 8)
+#define BLK_RW_CMP		(1 << 7)
+#define ERS_CMP			(1 << 6)
+#define PGM_CMP			(1 << 5)
+#define LOAD_CMP		(1 << 4)
+#define ERS_FAIL		(1 << 3)
+#define PGM_FAIL		(1 << 2)
+#define INT_TO			(1 << 1)
+#define LD_FAIL_ECC_ERR		(1 << 0)
+
+#define TSRF			(1 << 0)
+
+#endif
-- 
1.8.1.2
