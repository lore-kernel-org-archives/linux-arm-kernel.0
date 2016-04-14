From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 14 Apr 2016 14:07:52 +0300
Subject: [PATCHv2 03/28] ARM: OMAP2+: omap_device: create clock alias purely
 from DT data
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Message-ID: <1460632097-25727-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids the need to add most of the clock aliases under
drivers/clk/ti/clk-xyz.c files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index f7ff3b9..b32d7c8 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -63,7 +63,22 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
-	rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev), clk_name, NULL);
+	r = clk_get_sys(NULL, clk_name);
+
+	if (IS_ERR(r) && of_have_populated_dt()) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = of_find_node_by_name(NULL, clk_name);
+
+		r = of_clk_get_from_provider(&clkspec);
+
+		rc = clk_register_clkdev(r, clk_alias,
+					 dev_name(&od->pdev->dev));
+	} else {
+		rc = clk_add_alias(clk_alias, dev_name(&od->pdev->dev),
+				   clk_name, NULL);
+	}
+
 	if (rc) {
 		if (rc == -ENODEV || rc == -ENOMEM)
 			dev_err(&od->pdev->dev,
-- 
1.7.9.5
