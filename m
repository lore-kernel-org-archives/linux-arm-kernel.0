From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 15:53:10 +0200
Subject: [PATCH 7/8] mxc_nand: support 8bit ecc
In-Reply-To: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281102791-8089-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nand devices with at least 26 bytes of oob data per 512 byte block
can have 8bit ecc on v2 type controllers. This is currently not tested,
but at least this patch puts the ECC_MODE bit into a well defined state.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index a6dc5a5..030da08 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -58,6 +58,7 @@
 #define NFC_V1_V2_CONFIG1		(host->regs + 0x1a)
 #define NFC_V1_V2_CONFIG2		(host->regs + 0x1c)
 
+#define NFC_V2_CONFIG1_ECC_MODE_4	(1 << 0)
 #define NFC_V1_V2_CONFIG1_SP_EN		(1 << 2)
 #define NFC_V1_V2_CONFIG1_ECC_EN	(1 << 3)
 #define NFC_V1_V2_CONFIG1_INT_MSK	(1 << 4)
@@ -581,6 +582,23 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 	}
 }
 
+/*
+ * v2 and v3 type controllers can do 4bit or 8bit ecc depending
+ * on how much oob the nand chip has. For 8bit ecc we need@least
+ * 26 bytes of oob data per 512 byte block.
+ */
+static int get_eccsize(struct mtd_info *mtd)
+{
+	int oobbytes_per_512 = 0;
+
+	oobbytes_per_512 = mtd->oobsize * 512 / mtd->writesize;
+
+	if (oobbytes_per_512 < 26)
+		return 4;
+	else
+		return 8;
+}
+
 static void preset_v1_v2(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -596,6 +614,15 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	} else {
 		tmp &= ~NFC_V1_V2_CONFIG1_ECC_EN;
 	}
+
+	if (nfc_is_v21() && mtd->writesize) {
+		host->eccsize = get_eccsize(mtd);
+		if (host->eccsize == 4)
+			tmp |= NFC_V2_CONFIG1_ECC_MODE_4;
+	} else {
+		host->eccsize = 1;
+	}
+
 	writew(tmp, NFC_V1_V2_CONFIG1);
 	/* preset operation */
 
@@ -859,6 +886,9 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 	}
 
+	/* Call preset again, with correct writesize this time */
+	host->preset(mtd);
+
 	if (mtd->writesize == 2048)
 		this->ecc.layout = oob_largepage;
 
-- 
1.7.1
