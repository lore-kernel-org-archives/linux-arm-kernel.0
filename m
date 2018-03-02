From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:44 +0100
Subject: [PATCH 36/52] mtd: rawnand: sh_flctl: fix the probe function error
 path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-37-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() call should trigger a nand_release()
call. This is rightly handled in the remove function, but not in the
probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index d14c26cb59df..67f125d56771 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1214,9 +1214,13 @@ static int flctl_probe(struct platform_device *pdev)
 
 	ret = mtd_device_register(flctl_mtd, flctl->pdata->parts,
 				  flctl->pdata->nr_parts);
+	if (ret)
+		goto release_nand;
 
 	return 0;
 
+release_nand:
+	nand_release(flctl_mtd);
 err_chip:
 	flctl_release_dma(flctl);
 	pm_runtime_disable(&pdev->dev);
-- 
2.14.1
