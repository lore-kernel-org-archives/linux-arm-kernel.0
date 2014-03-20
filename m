From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 20 Mar 2014 19:06:23 +0200
Subject: [PATCH 2/3] mtd: davinci-nand: add dts property for
 NAND_NO_SUBPAGE_WRITE option
In-Reply-To: <1395335184-4745-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1395335184-4745-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1395335184-4745-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

After testing NAND flash with ubifs for k2hk-emv board were committed
that flash doesn't support subpage writing, so we can fix it by
adding a property to disable subpage write.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 2 ++
 drivers/mtd/nand/davinci_nand.c                        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
index cfb18ab..50af930 100644
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
@@ -53,6 +53,8 @@ Recommended properties :
 				identifier is saved in OOB area. If not present
 				false.
 
+- ti,davinci-nosubpage-write:	disable subpage write for the device
+
 Deprecated properties:
 
 - ti,davinci-ecc-mode:		operation mode of the NAND ecc mode. ECC mode
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 4615d79..3ba058d 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -581,6 +581,9 @@ static struct davinci_nand_pdata
 		    of_property_read_bool(pdev->dev.of_node,
 			"ti,davinci-nand-use-bbt"))
 			pdata->bbt_options = NAND_BBT_USE_FLASH;
+		if (of_property_read_bool(pdev->dev.of_node,
+			"ti,davinci-no-subpage-write"))
+			pdata->options |= NAND_NO_SUBPAGE_WRITE;
 	}
 
 	return dev_get_platdata(&pdev->dev);
-- 
1.8.3.2
