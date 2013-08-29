From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:31 +0300
Subject: [PATCHv6 39/45] ARM: OMAP2+: omap_device: no need to add a clock dev
 for aliases
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-40-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

When we create aliases, we have an handy clk_add_alias which
can be used instead of creating new nodes in the clock tree.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 070d17b..7c796e2 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -45,8 +45,8 @@
 static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		       const char *clk_name)
 {
+	int ret;
 	struct clk *r;
-	struct clk_lookup *l;
 	struct device *dev = &od->pdev->dev;
 
 	if (!clk_alias || !clk_name)
@@ -61,19 +61,10 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		return;
 	}
 
-	r = clk_get(NULL, clk_name);
-	if (IS_ERR(r)) {
-		dev_err(dev, "clk_get for %s failed\n", clk_name);
-		return;
-	}
-
-	l = clkdev_alloc(r, clk_alias, dev_name(dev));
-	if (!l) {
-		dev_err(dev, "clkdev_alloc for %s failed\n", clk_alias);
-		return;
-	}
-
-	clkdev_add(l);
+	ret = clk_add_alias(clk_alias, dev_name(dev), (char *)clk_name, dev);
+	if (ret)
+		dev_err(dev, "Failed to alias %s to %s: %d\n", clk_alias,
+			clk_name, ret);
 }
 
 /**
-- 
1.7.9.5
