From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 15:20:45 +0200
Subject: [PATCH 01/12] mxc_nand: remove 0xe00 offset from registers
In-Reply-To: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
References: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281360053-8386-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the offset to the register base instead. This is done
in preparation for v3 controller support.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 0d76b16..abec73a 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -41,22 +41,22 @@
 #define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
 
 /* Addresses for NFC registers */
-#define NFC_BUF_SIZE		0xE00
-#define NFC_BUF_ADDR		0xE04
-#define NFC_FLASH_ADDR		0xE06
-#define NFC_FLASH_CMD		0xE08
-#define NFC_CONFIG		0xE0A
-#define NFC_ECC_STATUS_RESULT	0xE0C
-#define NFC_RSLTMAIN_AREA	0xE0E
-#define NFC_RSLTSPARE_AREA	0xE10
-#define NFC_WRPROT		0xE12
-#define NFC_V1_UNLOCKSTART_BLKADDR	0xe14
-#define NFC_V1_UNLOCKEND_BLKADDR	0xe16
-#define NFC_V21_UNLOCKSTART_BLKADDR	0xe20
-#define NFC_V21_UNLOCKEND_BLKADDR	0xe22
-#define NFC_NF_WRPRST		0xE18
-#define NFC_CONFIG1		0xE1A
-#define NFC_CONFIG2		0xE1C
+#define NFC_BUF_SIZE			0x00
+#define NFC_BUF_ADDR			0x04
+#define NFC_FLASH_ADDR			0x06
+#define NFC_FLASH_CMD			0x08
+#define NFC_CONFIG			0x0a
+#define NFC_ECC_STATUS_RESULT		0x0c
+#define NFC_RSLTMAIN_AREA		0x0e
+#define NFC_RSLTSPARE_AREA		0x10
+#define NFC_WRPROT			0x12
+#define NFC_V1_UNLOCKSTART_BLKADDR	0x14
+#define NFC_V1_UNLOCKEND_BLKADDR	0x16
+#define NFC_V21_UNLOCKSTART_BLKADDR	0x20
+#define NFC_V21_UNLOCKEND_BLKADDR	0x22
+#define NFC_NF_WRPRST			0x18
+#define NFC_CONFIG1			0x1a
+#define NFC_CONFIG2			0x1c
 
 /* Set INT to 0, FCMD to 1, rest to 0 in NFC_CONFIG2 Register
  * for Command operation */
@@ -764,14 +764,14 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->main_area1 = host->base + 0x200;
 
 	if (nfc_is_v21()) {
-		host->regs = host->base + 0x1000;
+		host->regs = host->base + 0x1e00;
 		host->spare0 = host->base + 0x1000;
 		host->spare_len = 64;
 		oob_smallpage = &nandv2_hw_eccoob_smallpage;
 		oob_largepage = &nandv2_hw_eccoob_largepage;
 		this->ecc.bytes = 9;
 	} else if (nfc_is_v1()) {
-		host->regs = host->base;
+		host->regs = host->base + 0xe00;
 		host->spare0 = host->base + 0x800;
 		host->spare_len = 16;
 		oob_smallpage = &nandv1_hw_eccoob_smallpage;
-- 
1.7.1
