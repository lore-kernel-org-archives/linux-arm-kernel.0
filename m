From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 17:53:38 +0200
Subject: [PATCH 1/4] mtd: pxa3xx_nand: add a default chunk size
In-Reply-To: <1433260421-18002-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433260421-18002-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433260421-18002-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When keeping the configuration set by the bootloader (by using
the marvell,nand-keep-config property), the pxa3xx_nand_detect_config()
function is called and set the chunk size to 512 as a default value if
NDCR_PAGE_SZ is not set.

In the other case, when not keeping the bootloader configuration, no
chunk size is set. Fix this by adding a default chunk size of 512.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index a4615fcc3d00..94a357d93bab 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1475,6 +1475,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
 		goto KEEP_CONFIG;
 
+	/* Set a default chunk size */
+	info->chunk_size = 512;
+
 	ret = pxa3xx_nand_sensing(info);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
-- 
2.4.2
