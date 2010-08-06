From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 15:53:08 +0200
Subject: [PATCH 5/8] mxc_nand: add V1_V2 namespace to registers
In-Reply-To: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281102791-8089-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares the driver for v3 support. The v3 controller
has a completely different register layout, so add a V1_V2_
namespace to the register defines to avoid confusion with
the v3 regs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |  141 +++++++++++++++++++------------------------
 1 files changed, 63 insertions(+), 78 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 70f64dc..48b6dca 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -41,58 +41,43 @@
 #define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
 
 /* Addresses for NFC registers */
-#define NFC_BUF_SIZE			0x00
-#define NFC_BUF_ADDR			0x04
-#define NFC_FLASH_ADDR			0x06
-#define NFC_FLASH_CMD			0x08
-#define NFC_CONFIG			0x0a
-#define NFC_ECC_STATUS_RESULT		0x0c
-#define NFC_RSLTMAIN_AREA		0x0e
-#define NFC_RSLTSPARE_AREA		0x10
-#define NFC_WRPROT			0x12
-#define NFC_V1_UNLOCKSTART_BLKADDR	0x14
-#define NFC_V1_UNLOCKEND_BLKADDR	0x16
-#define NFC_V21_UNLOCKSTART_BLKADDR	0x20
-#define NFC_V21_UNLOCKEND_BLKADDR	0x22
-#define NFC_NF_WRPRST			0x18
-#define NFC_CONFIG1			0x1a
-#define NFC_CONFIG2			0x1c
-
-/* Set INT to 0, FCMD to 1, rest to 0 in NFC_CONFIG2 Register
- * for Command operation */
-#define NFC_CMD            0x1
-
-/* Set INT to 0, FADD to 1, rest to 0 in NFC_CONFIG2 Register
- * for Address operation */
-#define NFC_ADDR           0x2
-
-/* Set INT to 0, FDI to 1, rest to 0 in NFC_CONFIG2 Register
- * for Input operation */
-#define NFC_INPUT          0x4
-
-/* Set INT to 0, FDO to 001, rest to 0 in NFC_CONFIG2 Register
- * for Data Output operation */
-#define NFC_OUTPUT         0x8
-
-/* Set INT to 0, FD0 to 010, rest to 0 in NFC_CONFIG2 Register
- * for Read ID operation */
-#define NFC_ID             0x10
-
-/* Set INT to 0, FDO to 100, rest to 0 in NFC_CONFIG2 Register
- * for Read Status operation */
-#define NFC_STATUS         0x20
-
-/* Set INT to 1, rest to 0 in NFC_CONFIG2 Register for Read
- * Status operation */
-#define NFC_INT            0x8000
-
-#define NFC_SP_EN           (1 << 2)
-#define NFC_ECC_EN          (1 << 3)
-#define NFC_INT_MSK         (1 << 4)
-#define NFC_BIG             (1 << 5)
-#define NFC_RST             (1 << 6)
-#define NFC_CE              (1 << 7)
-#define NFC_ONE_CYCLE       (1 << 8)
+#define NFC_V1_V2_BUF_SIZE		(host->regs + 0x00)
+#define NFC_V1_V2_BUF_ADDR		(host->regs + 0x04)
+#define NFC_V1_V2_FLASH_ADDR		(host->regs + 0x06)
+#define NFC_V1_V2_FLASH_CMD		(host->regs + 0x08)
+#define NFC_V1_V2_CONFIG		(host->regs + 0x0a)
+#define NFC_V1_V2_ECC_STATUS_RESULT	(host->regs + 0x0c)
+#define NFC_V1_V2_RSLTMAIN_AREA		(host->regs + 0x0e)
+#define NFC_V1_V2_RSLTSPARE_AREA	(host->regs + 0x10)
+#define NFC_V1_V2_WRPROT		(host->regs + 0x12)
+#define NFC_V1_UNLOCKSTART_BLKADDR	(host->regs + 0x14)
+#define NFC_V1_UNLOCKEND_BLKADDR	(host->regs + 0x16)
+#define NFC_V21_UNLOCKSTART_BLKADDR	(host->regs + 0x20)
+#define NFC_V21_UNLOCKEND_BLKADDR	(host->regs + 0x22)
+#define NFC_V1_V2_NF_WRPRST		(host->regs + 0x18)
+#define NFC_V1_V2_CONFIG1		(host->regs + 0x1a)
+#define NFC_V1_V2_CONFIG2		(host->regs + 0x1c)
+
+#define NFC_V1_V2_CONFIG1_SP_EN		(1 << 2)
+#define NFC_V1_V2_CONFIG1_ECC_EN	(1 << 3)
+#define NFC_V1_V2_CONFIG1_INT_MSK	(1 << 4)
+#define NFC_V1_V2_CONFIG1_BIG		(1 << 5)
+#define NFC_V1_V2_CONFIG1_RST		(1 << 6)
+#define NFC_V1_V2_CONFIG1_CE		(1 << 7)
+#define NFC_V1_V2_CONFIG1_ONE_CYCLE	(1 << 8)
+
+#define NFC_V1_V2_CONFIG2_INT		(1 << 15)
+
+/*
+ * Operation modes for the NFC. Valid for v1, v2 and v3
+ * type controllers.
+ */
+#define NFC_CMD				(1 << 0)
+#define NFC_ADDR			(1 << 1)
+#define NFC_INPUT			(1 << 2)
+#define NFC_OUTPUT			(1 << 3)
+#define NFC_ID				(1 << 4)
+#define NFC_STATUS			(1 << 5)
 
 struct mxc_nand_host {
 	struct mtd_info		mtd;
@@ -186,11 +171,11 @@ static int check_int_v1_v2(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
 
-	tmp = readw(host->regs + NFC_CONFIG2);
-	if (!(tmp & NFC_INT))
+	tmp = readw(NFC_V1_V2_CONFIG2);
+	if (!(tmp & NFC_V1_V2_CONFIG2_INT))
 		return 0;
 
-	writew(tmp & ~NFC_INT, NFC_CONFIG2);
+	writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
 
 	return 1;
 }
@@ -228,15 +213,15 @@ static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 {
 	DEBUG(MTD_DEBUG_LEVEL3, "send_cmd(host, 0x%x, %d)\n", cmd, useirq);
 
-	writew(cmd, host->regs + NFC_FLASH_CMD);
-	writew(NFC_CMD, host->regs + NFC_CONFIG2);
+	writew(cmd, NFC_V1_V2_FLASH_CMD);
+	writew(NFC_CMD, NFC_V1_V2_CONFIG2);
 
 	if (cpu_is_mx21() && (cmd == NAND_CMD_RESET)) {
 		int max_retries = 100;
 		/* Reset completion is indicated by NFC_CONFIG2 */
 		/* being set to 0 */
 		while (max_retries-- > 0) {
-			if (readw(host->regs + NFC_CONFIG2) == 0) {
+			if (readw(NFC_V1_V2_CONFIG2) == 0) {
 				break;
 			}
 			udelay(1);
@@ -257,8 +242,8 @@ static void send_addr_v1_v2(struct mxc_nand_host *host, uint16_t addr, int islas
 {
 	DEBUG(MTD_DEBUG_LEVEL3, "send_addr(host, 0x%x %d)\n", addr, islast);
 
-	writew(addr, host->regs + NFC_FLASH_ADDR);
-	writew(NFC_ADDR, host->regs + NFC_CONFIG2);
+	writew(addr, NFC_V1_V2_FLASH_ADDR);
+	writew(NFC_ADDR, NFC_V1_V2_CONFIG2);
 
 	/* Wait for operation to complete */
 	wait_op_done(host, islast);
@@ -278,9 +263,9 @@ static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
 	for (i = 0; i < bufs; i++) {
 
 		/* NANDFC buffer 0 is used for page read/write */
-		writew(i, host->regs + NFC_BUF_ADDR);
+		writew(i, NFC_V1_V2_BUF_ADDR);
 
-		writew(ops, host->regs + NFC_CONFIG2);
+		writew(ops, NFC_V1_V2_CONFIG2);
 
 		/* Wait for operation to complete */
 		wait_op_done(host, true);
@@ -293,9 +278,9 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
 	struct nand_chip *this = &host->nand;
 
 	/* NANDFC buffer 0 is used for device ID output */
-	writew(0x0, host->regs + NFC_BUF_ADDR);
+	writew(0x0, NFC_V1_V2_BUF_ADDR);
 
-	writew(NFC_ID, host->regs + NFC_CONFIG2);
+	writew(NFC_ID, NFC_V1_V2_CONFIG2);
 
 	/* Wait for operation to complete */
 	wait_op_done(host, true);
@@ -329,7 +314,7 @@ static uint16_t get_dev_status_v1_v2(struct mxc_nand_host *host)
 	 */
 	store = readl(main_buf);
 
-	writew(NFC_STATUS, host->regs + NFC_CONFIG2);
+	writew(NFC_STATUS, NFC_V1_V2_CONFIG2);
 	wait_op_done(host, true);
 
 	ret = readw(main_buf);
@@ -368,7 +353,7 @@ static int mxc_nand_correct_data(struct mtd_info *mtd, u_char *dat,
 	 * additional correction.  2-Bit errors cannot be corrected by
 	 * HW ECC, so we need to return failure
 	 */
-	uint16_t ecc_status = readw(host->regs + NFC_ECC_STATUS_RESULT);
+	uint16_t ecc_status = readw(NFC_V1_V2_ECC_STATUS_RESULT);
 
 	if (((ecc_status & 0x3) == 2) || ((ecc_status >> 2) == 2)) {
 		DEBUG(MTD_DEBUG_LEVEL0,
@@ -568,32 +553,32 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	uint16_t tmp;
 
 	/* enable interrupt, disable spare enable */
-	tmp = readw(host->regs + NFC_CONFIG1);
-	tmp &= ~NFC_INT_MSK;
-	tmp &= ~NFC_SP_EN;
+	tmp = readw(NFC_V1_V2_CONFIG1);
+	tmp &= ~NFC_V1_V2_CONFIG1_INT_MSK;
+	tmp &= ~NFC_V1_V2_CONFIG1_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
-		tmp |= NFC_ECC_EN;
+		tmp |= NFC_V1_V2_CONFIG1_ECC_EN;
 	} else {
-		tmp &= ~NFC_ECC_EN;
+		tmp &= ~NFC_V1_V2_CONFIG1_ECC_EN;
 	}
-	writew(tmp, host->regs + NFC_CONFIG1);
+	writew(tmp, NFC_V1_V2_CONFIG1);
 	/* preset operation */
 
 	/* Unlock the internal RAM Buffer */
-	writew(0x2, host->regs + NFC_CONFIG);
+	writew(0x2, NFC_V1_V2_CONFIG);
 
 	/* Blocks to be unlocked */
 	if (nfc_is_v21()) {
-		writew(0x0, host->regs + NFC_V21_UNLOCKSTART_BLKADDR);
-		writew(0xffff, host->regs + NFC_V21_UNLOCKEND_BLKADDR);
+		writew(0x0, NFC_V21_UNLOCKSTART_BLKADDR);
+		writew(0xffff, NFC_V21_UNLOCKEND_BLKADDR);
 	} else if (nfc_is_v1()) {
-		writew(0x0, host->regs + NFC_V1_UNLOCKSTART_BLKADDR);
-		writew(0x4000, host->regs + NFC_V1_UNLOCKEND_BLKADDR);
+		writew(0x0, NFC_V1_UNLOCKSTART_BLKADDR);
+		writew(0x4000, NFC_V1_UNLOCKEND_BLKADDR);
 	} else
 		BUG();
 
 	/* Unlock Block Command for given address range */
-	writew(0x4, host->regs + NFC_WRPROT);
+	writew(0x4, NFC_V1_V2_WRPROT);
 }
 
 /* Used by the upper layer to write command to NAND Flash for
-- 
1.7.1
