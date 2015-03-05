From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu,  5 Mar 2015 12:31:19 +0100
Subject: [PATCH v3 3/9] mtd: pxa3xx_nand: add a default chunk size
In-Reply-To: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425555085-29531-4-git-send-email-antoine.tenart@free-electrons.com>
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
index 55fce9527c2e..dc0edbc406bb 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1429,6 +1429,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
 		goto KEEP_CONFIG;
 
+	/* Set a default chunk size */
+	info->chunk_size = 512;
+
 	ret = pxa3xx_nand_sensing(info);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
-- 
2.3.1
