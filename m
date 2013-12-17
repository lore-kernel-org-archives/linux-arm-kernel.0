From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 17 Dec 2013 15:36:05 +0200
Subject: [PATCH v4 2/9] mtd: nand: davinci: return ENOMEM if memory allocation
 is failed
In-Reply-To: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1387287365-19731-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case when memory allocation is failed the driver should return
ENOMEM instead of ENODEV.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Taras Kondratiuk <taras@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 584c1f4..4577fb4 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -541,7 +541,7 @@ static struct davinci_nand_pdata
 				GFP_KERNEL);
 		pdev->dev.platform_data = pdata;
 		if (!pdata)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-chipselect", &prop))
 			pdev->id = prop;
@@ -598,6 +598,9 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	nand_ecc_modes_t		ecc_mode;
 
 	pdata = nand_davinci_get_pdata(pdev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
 	/* insist on board-specific configuration */
 	if (!pdata)
 		return -ENODEV;
-- 
1.7.9.5
