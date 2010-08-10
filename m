From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 10 Aug 2010 13:34:07 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
Message-ID: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the NFC registers for spare size and pages per block.

This patch is against the latest patches from Sascha Hauer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Index: linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-2.6-454a740.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
@@ -68,6 +68,8 @@
 #define NFC_V1_V2_CONFIG1_RST		(1 << 6)
 #define NFC_V1_V2_CONFIG1_CE		(1 << 7)
 #define NFC_V1_V2_CONFIG1_ONE_CYCLE	(1 << 8)
+#define NFC_V1_V2_CONFIG1_PPB_SHIFT	9
+#define NFC_V1_V2_CONFIG1_PPB_MASK	0x3
 
 #define NFC_V1_V2_CONFIG2_INT		(1 << 15)
 
@@ -749,7 +751,37 @@ static void preset_v1_v2(struct mtd_info
 		host->eccsize = 1;
 	}
 
+	if (nfc_is_v21() && mtd->writesize) {
+		/* setup pages per block */
+		tmp &= ~(NFC_V1_V2_CONFIG1_PPB_MASK <<
+					NFC_V1_V2_CONFIG1_PPB_SHIFT);
+		switch (mtd->erasesize / mtd->writesize) {
+		case 32:
+			/* PPB set to 0 */
+			break;
+		case 64:
+			tmp |= 1 << NFC_V1_V2_CONFIG1_PPB_SHIFT;
+			break;
+		case 256:
+			tmp |= 3 << NFC_V1_V2_CONFIG1_PPB_SHIFT;
+			break;
+		default:
+			/* 128 (reset value) */
+			tmp |= 2 << NFC_V1_V2_CONFIG1_PPB_SHIFT;
+			break;
+		}
+	}
+
 	writew(tmp, NFC_V1_V2_CONFIG1);
+
+	if (nfc_is_v21()) {
+		/* configure spare size (in 16-bit units) */
+		tmp = readw(NFC_V1_V2_RSLTSPARE_AREA);
+		tmp &= ~0xff;
+		tmp |= host->spare_len >> 1;
+		writew(tmp, NFC_V1_V2_RSLTSPARE_AREA);
+	}
+
 	/* preset operation */
 
 	/* Unlock the internal RAM Buffer */
