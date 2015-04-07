From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Apr 2015 15:32:45 +0200
Subject: [PATCH v2] mtd: nand: pxa3xx: Switch FIFO draining to jiffies-based
 timeout
Message-ID: <1428413565-27644-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver handles the FIFO draining in a threaded interrupt, we can
base our timeout on jiffies and sleeping, instead of using mdelay.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes from v1:
  - Switch to readl_relaxed_poll_timeout() instead of using our own custom
    implementation of it.

 drivers/mtd/nand/pxa3xx_nand.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 10b1f7a4fe50..55eb1334675b 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -22,6 +22,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -483,7 +484,8 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
 static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
 {
 	if (info->ecc_bch) {
-		int timeout;
+		u32 val;
+		int ret;
 
 		/*
 		 * According to the datasheet, when reading from NDDB
@@ -496,16 +498,12 @@ static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
 		while (len > 8) {
 			__raw_readsl(info->mmio_base + NDDB, data, 8);
 
-			for (timeout = 0;
-			     !(nand_readl(info, NDSR) & NDSR_RDDREQ);
-			     timeout++) {
-				if (timeout >= 5) {
-					dev_err(&info->pdev->dev,
-						"Timeout on RDDREQ while draining the FIFO\n");
-					return;
-				}
-
-				mdelay(1);
+			ret = readl_relaxed_poll_timeout(info->mmio_base + NDSR, val,
+							 val & NDSR_RDDREQ, 1000, 5000);
+			if (ret) {
+				dev_err(&info->pdev->dev,
+					"Timeout on RDDREQ while draining the FIFO\n");
+				return;
 			}
 
 			data += 32;
-- 
2.3.5
