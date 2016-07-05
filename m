From: t.remmet@phytec.de (Teresa Remmet)
Date: Tue, 5 Jul 2016 11:32:30 +0200
Subject: [PATCH 2/2] mtd: nand: omap2: Add check for old elm binding
In-Reply-To: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1467711150-23356-2-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit c9711ec5250b ("mtd: nand: omap: Clean up device tree support")
removes the check for the old elm phandle binding.
Add it again to keep backward compatibility.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 drivers/mtd/nand/omap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 08e1588..d788663 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1658,7 +1658,9 @@ static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
 	/* detect availability of ELM module. Won't be present pre-OMAP4 */
 	info->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
 	if (!info->elm_of_node)
-		dev_dbg(dev, "ti,elm-id not in DT\n");
+		info->elm_of_node = of_parse_phandle(child, "elm_id", 0);
+		if (!info->elm_of_node)
+			dev_dbg(dev, "ti,elm-id not in DT\n");
 
 	/* select ecc-scheme for NAND */
 	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
-- 
1.9.1
