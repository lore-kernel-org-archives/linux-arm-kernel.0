From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 21 Dec 2013 00:02:27 +0800
Subject: [PATCH 1/4] mtd: mxc-nand: kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
In-Reply-To: <1387555350-989-1-git-send-email-shijie8@gmail.com>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
Message-ID: <1387555350-989-2-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We kill the NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE by the following way:
 1.) Before we call the nand_scan_ident, we allocate a temporary buffer
     whose size is PAGE_SIZE.
 2.) After we finish the nand_scan_ident, we have already getten the
     page size and oob size. We will allocate the right buffer size
     again.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/mtd/nand/mxc_nand.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 567a5e5..e9a4835 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1399,12 +1399,15 @@ static int mxcnd_probe(struct platform_device *pdev)
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
-	host = devm_kzalloc(&pdev->dev, sizeof(struct mxc_nand_host) +
-			NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE, GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(struct mxc_nand_host),
+			GFP_KERNEL);
 	if (!host)
 		return -ENOMEM;
 
-	host->data_buf = (uint8_t *)(host + 1);
+	/* allocate a temporary buffer for the nand_scan_ident() */
+	host->data_buf = devm_kzalloc(&pdev->dev, PAGE_SIZE, GFP_KERNEL);
+	if (!host->data_buf)
+		return -ENOMEM;
 
 	host->dev = &pdev->dev;
 	/* structures must be linked */
@@ -1532,6 +1535,15 @@ static int mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 	}
 
+	/* allocate the right size buffer now */
+	devm_kfree(&pdev->dev, (void *)host->data_buf);
+	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
+					GFP_KERNEL);
+	if (!host->data_buf) {
+		err = -ENOMEM;
+		goto escan;
+	}
+
 	/* Call preset again, with correct writesize this time */
 	host->devtype_data->preset(mtd);
 
-- 
1.8.3.1
