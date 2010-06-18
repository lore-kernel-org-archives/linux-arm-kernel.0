From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 18 Jun 2010 19:00:27 +0200
Subject: [PATCH 2/5] mtd: mxc_nand fixups
Message-ID: <80d3vob7is.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the NFC registers for spare size and pages per block.
For NFCv21 it also sets the ECC mode to 4-bit, since this driver only
supports up to 16 OOB bytes per 512 data bytes.

The patch is against linux-next 20100618.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   48 +++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

Index: linux-next-20100618/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-next-20100618.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-next-20100618/drivers/mtd/nand/mxc_nand.c
@@ -86,6 +86,7 @@
  * Status operation */
 #define NFC_INT            0x8000
 
+#define NFC_ECC_4BIT        (1 << 0)
 #define NFC_SP_EN           (1 << 2)
 #define NFC_ECC_EN          (1 << 3)
 #define NFC_INT_MSK         (1 << 4)
@@ -94,6 +95,11 @@
 #define NFC_CE              (1 << 7)
 #define NFC_ONE_CYCLE       (1 << 8)
 
+#define NFC_PPB_SHIFT       9
+#define NFC_PPB_MASK        (3 << NFC_PPB_SHIFT)
+
+#define NFC_RSLTSPARE_AREA_MASK  0xff
+
 struct mxc_nand_host {
 	struct mtd_info		mtd;
 	struct nand_chip	nand;
@@ -557,21 +563,35 @@ static void preset(struct mtd_info *mtd)
 	struct mxc_nand_host *host = nand_chip->priv;
 	uint16_t tmp;
 
-	/* enable interrupt, disable spare enable */
+	/* enable interrupt, disable spare enable, setup ECC */
 	tmp = readw(host->regs + NFC_CONFIG1);
 	tmp &= ~NFC_INT_MSK;
 	tmp &= ~NFC_SP_EN;
 	if (nand_chip->ecc.mode == NAND_ECC_HW) {
 		tmp |= NFC_ECC_EN;
+
+		if (nfc_is_v21()) {
+			/* use 4-bit ECC mode */
+			tmp |= NFC_ECC_4BIT;
+		}
 	} else {
 		tmp &= ~NFC_ECC_EN;
 	}
 	writew(tmp, host->regs + NFC_CONFIG1);
+
 	/* preset operation */
 
 	/* Unlock the internal RAM Buffer */
 	writew(0x2, host->regs + NFC_CONFIG);
 
+	if (nfc_is_v21()) {
+		/* configure spare size (in 16-bit blocks) */
+		tmp = readw(host->regs + NFC_RSLTSPARE_AREA);
+		tmp &= ~NFC_RSLTSPARE_AREA_MASK;
+		tmp |= host->spare_len / 2;
+		writew(tmp, host->regs + NFC_RSLTSPARE_AREA);
+	}
+
 	/* Blocks to be unlocked */
 	if (nfc_is_v21()) {
 		writew(0x0, host->regs + NFC_V21_UNLOCKSTART_BLKADDR);
@@ -817,6 +837,32 @@ static int __init mxcnd_probe(struct pla
 		goto escan;
 	}
 
+	if (nfc_is_v21()) {
+		/* setup PPB */
+
+		uint16_t pages_per_block = mtd->erasesize / mtd->writesize;
+		uint16_t tmp;
+
+		tmp = readw(host->regs + NFC_CONFIG1);
+		tmp &= ~NFC_PPB_MASK;
+		switch (pages_per_block) {
+		case 32:
+			/* PPB set to 0 */
+			break;
+		case 64:
+			tmp |= 1 << NFC_PPB_SHIFT;
+			break;
+		case 256:
+			tmp |= 3 << NFC_PPB_SHIFT;
+			break;
+		default:
+			/* 128 (reset value) */
+			tmp |= 2 << NFC_PPB_SHIFT;
+			break;
+		}
+		writew(tmp, host->regs + NFC_CONFIG1);
+	}
+
 	if (mtd->writesize == 2048)
 		this->ecc.layout = oob_largepage;
 
