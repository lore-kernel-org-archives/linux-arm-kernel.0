From: error27@gmail.com (Dan Carpenter)
Date: Thu, 6 Jan 2011 15:45:25 +0300
Subject: [patch] mtd: pxa3xx_nand: NULL dereference in pxa3xx_nand_probe
In-Reply-To: <1294227801.3996.62.camel@sven>
References: <1294227801.3996.62.camel@sven>
Message-ID: <20110106124525.GA1717@bicker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sven,

Could you test this patch?  I don't have an arm so I can't compile this.

This was introduced in 18c81b1828f8 "mtd: pxa3xx_nand: remove the flash
info in driver structure"

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 17f8518..ea2c288 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -885,6 +885,7 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 	/* set info fields needed to __readid */
 	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr;
+	info->cmdset = &default_cmdset;
 
 	if (__readid(info, &id))
 		return -ENODEV;
@@ -915,7 +916,6 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 
 	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
 	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
-	info->cmdset = &default_cmdset;
 
 	return 0;
 }
