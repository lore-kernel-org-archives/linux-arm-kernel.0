From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:36 +0100
Subject: [PATCH 28/52] mtd: rawnand: mxc: fix probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-29-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() should trigger a nand_release().
The helper mtd_device_parse_register() returns an error code that should
be checked and nand_release() called accordingly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 944ecf03d3b1..948fe3e9d8da 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1911,15 +1911,18 @@ static int mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 
 	/* Register the partitions */
-	mtd_device_parse_register(mtd, part_probes,
-			NULL,
-			host->pdata.parts,
-			host->pdata.nr_parts);
+	err = mtd_device_parse_register(mtd, part_probes, NULL,
+					host->pdata.parts,
+					host->pdata.nr_parts);
+	if (err)
+		goto release_nand;
 
 	platform_set_drvdata(pdev, host);
 
 	return 0;
 
+release_nand:
+	nand_release(mtd);
 escan:
 	if (host->clk_act)
 		clk_disable_unprepare(host->clk);
-- 
2.14.1
