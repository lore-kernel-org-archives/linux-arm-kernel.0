From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 15 Jan 2015 18:45:53 +0800
Subject: [PATCH] mtd: atmel_nand: check NFC busy flag by HSMC_SR instead of
 NFC cmd regs
Message-ID: <1421318753-14960-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver read NFC command registers to get NFC busy flag.
Actually this flag also can be get by reading HSMC_SR register.

Use the read NFC command registers need mapping a huge memory region.
To save the mapped memory region, we change to check NFC busy flag by
reading HSMC_SR register.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Josh Wu <josh.wu@atmel.com>
---

 drivers/mtd/nand/atmel_nand.c     | 3 +--
 drivers/mtd/nand/atmel_nand_nfc.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 3853597..125330b 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1699,8 +1699,7 @@ static int nfc_send_command(struct atmel_nand_host *host,
 		cmd, addr, cycle0);
 
 	timeout = jiffies + msecs_to_jiffies(NFC_TIME_OUT_MS);
-	while (nfc_cmd_readl(NFCADDR_CMD_NFCBUSY, host->nfc->base_cmd_regs)
-			& NFCADDR_CMD_NFCBUSY) {
+	while (nfc_readl(host->nfc->hsmc_regs, SR) & NFC_SR_BUSY) {
 		if (time_after(jiffies, timeout)) {
 			dev_err(host->dev,
 				"Time out to wait CMD_NFCBUSY ready!\n");
diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
index 85b8ca6..4d5d262 100644
--- a/drivers/mtd/nand/atmel_nand_nfc.h
+++ b/drivers/mtd/nand/atmel_nand_nfc.h
@@ -35,6 +35,7 @@
 #define		NFC_CTRL_DISABLE	(1 << 1)
 
 #define ATMEL_HSMC_NFC_SR	0x08		/* NFC Status Register */
+#define		NFC_SR_BUSY		(1 << 8)
 #define		NFC_SR_XFR_DONE		(1 << 16)
 #define		NFC_SR_CMD_DONE		(1 << 17)
 #define		NFC_SR_DTOE		(1 << 20)
-- 
1.9.1
