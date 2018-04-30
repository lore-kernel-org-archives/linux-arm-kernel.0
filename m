From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:52 +0200
Subject: [PATCH 11/12] mtd: nand: davinci: stop using pdev->id as chipselect
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Message-ID: <20180430082453.8091-12-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All platform now use the core_chipsel field in platform data. Stop
using pdev->id in the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 7255a0d94374..cd12e5abafde 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -545,7 +545,7 @@ static struct davinci_nand_pdata
 			return ERR_PTR(-ENOMEM);
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-chipselect", &prop))
-			pdev->id = prop;
+			pdata->core_chipsel = prop;
 		else
 			return ERR_PTR(-EINVAL);
 
@@ -627,7 +627,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* which external chipselect will we be managing? */
-	if (pdev->id < 0 || pdev->id > 3)
+	if (pdata->core_chipsel < 0 || pdata->core_chipsel > 3)
 		return -ENODEV;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -683,7 +683,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->ioaddr		= (uint32_t __force) vaddr;
 
 	info->current_cs	= info->ioaddr;
-	info->core_chipsel	= pdev->id;
+	info->core_chipsel	= pdata->core_chipsel;
 	info->mask_chipsel	= pdata->mask_chipsel;
 
 	/* use nandboot-capable ALE/CLE masks by default */
-- 
2.17.0
