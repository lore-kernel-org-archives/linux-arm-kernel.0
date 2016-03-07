From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:18 +0100
Subject: [PATCH 01/16] mtd: nand: sunxi: fix call order in
 sunxi_nand_chip_init()
In-Reply-To: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367513-26069-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_nand_chip_set_timings() is extracting a pointer to the nfc from the
nand->controller field, but this field is initialized after
sunxi_nand_chip_set_timings() call.
Reorder the calls to avoid any problem.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1c03eee..4d01e65 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1536,21 +1536,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 		}
 	}
 
-	timings = onfi_async_timing_mode_to_sdr_timings(0);
-	if (IS_ERR(timings)) {
-		ret = PTR_ERR(timings);
-		dev_err(dev,
-			"could not retrieve timings for ONFI mode 0: %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = sunxi_nand_chip_set_timings(chip, timings);
-	if (ret) {
-		dev_err(dev, "could not configure chip timings: %d\n", ret);
-		return ret;
-	}
-
 	nand = &chip->nand;
 	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
 	nand->chip_delay = 200;
@@ -1570,6 +1555,21 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	mtd = nand_to_mtd(nand);
 	mtd->dev.parent = dev;
 
+	timings = onfi_async_timing_mode_to_sdr_timings(0);
+	if (IS_ERR(timings)) {
+		ret = PTR_ERR(timings);
+		dev_err(dev,
+			"could not retrieve timings for ONFI mode 0: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = sunxi_nand_chip_set_timings(chip, timings);
+	if (ret) {
+		dev_err(dev, "could not configure chip timings: %d\n", ret);
+		return ret;
+	}
+
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
 		return ret;
-- 
2.1.4
