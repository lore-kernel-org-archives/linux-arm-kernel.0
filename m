From: jernej.turnsek@gmail.com (Jernej Turnsek)
Date: Mon, 28 Sep 2009 08:41:32 +0200
Subject: Problem with mxc_nand driver
Message-ID: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Yesterday I have updated my linux kernel for ARM MX27 platform from
git repository and I have observed some strange behaviour regarding
nand driver.
I have a jffs2 partition on Samsung K9F1G08U0B and when I load a root
fs for the first time, it works, but after another reset I got
messages: "Bad erase block %d at"...
These messages are only for the blocks which are still empty.

After investigating problem I found that mxc_nand.c file was changed:

---
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 76beea4..65b26d5 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -857,6 +857,17 @@ static void mxc_nand_command(struct mtd_info
*mtd, unsigned command,
     }
 }

+/* Define some generic bad / good block scan pattern which are used
+ * while scanning a device for factory marked good / bad blocks. */
+static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
+
+static struct nand_bbt_descr smallpage_memorybased = {
+    .options = NAND_BBT_SCAN2NDPAGE,
+    .offs = 5,
+    .len = 1,
+    .pattern = scan_ff_pattern
+};
+
 static int __init mxcnd_probe(struct platform_device *pdev)
 {
     struct nand_chip *this;
@@ -973,7 +984,10 @@ static int __init mxcnd_probe(struct platform_device *pdev)
         goto escan;
     }

-    host->pagesize_2k = (mtd->writesize == 2048) ? 1 : 0;
+    if (mtd->writesize == 2048) {
+        host->pagesize_2k = 1;
+        this->badblock_pattern = &smallpage_memorybased;
+    }

     if (this->ecc.mode == NAND_ECC_HW) {
         switch (mtd->oobsize) {

---

I found a bit strange to set badblock_pattern parameter to
smallpage_memorybased although pagesize is 2k. Or am I wrong?

When I revert this patch, everything works as it should.

BR,
Jernej
