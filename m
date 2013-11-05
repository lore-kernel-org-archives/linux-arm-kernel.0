From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:15 -0300
Subject: [PATCH v3 08/28] mtd: nand: pxa3xx: Use chip->cmdfunc instead of the
 internal
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever possible, it's always better to use the generic chip->cmdfunc
instead of the internal pxa3xx_nand_cmdfunc().
In this particular case, this will allow to have multiple cmdfunc()
implementations for different SoC variants.

Reviewed-by: Huang Shijie <shijie8@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d4937b2..12174c3 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1011,14 +1011,18 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 {
 	struct mtd_info *mtd;
+	struct nand_chip *chip;
 	int ret;
+
 	mtd = info->host[info->cs]->mtd;
+	chip = mtd->priv;
+
 	/* use the common timing to make a try */
 	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
 	if (ret)
 		return ret;
 
-	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
+	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
 	if (info->is_ready)
 		return 0;
 
-- 
1.8.1.5
