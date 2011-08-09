From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 10:19:03 +0100
Subject: [PATCH] ARM: tegra: fix i2c-tegra compilation when !CONFIG_OF
Message-ID: <1312881543-3467-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5c470f39ee (i2c: Tegra: Add DeviceTree support) broke
the non-DT case.

Fix it by using of_property_read_u32() instead of of_get_property(),
as this is defined in all cases.

Cc: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: OIof Johansson <olof@lixom.net>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/i2c/busses/i2c-tegra.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 2440b74..34c9951 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -547,7 +547,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	struct clk *clk;
 	struct clk *i2c_clk;
-	const unsigned int *prop;
 	void *base;
 	int irq;
 	int ret = 0;
@@ -610,12 +609,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	if (pdata) {
 		i2c_dev->bus_clk_rate = pdata->bus_clk_rate;
 
-	} else if (i2c_dev->dev->of_node) {    /* if there is a device tree node ... */
-		prop = of_get_property(i2c_dev->dev->of_node,
-				"clock-frequency", NULL);
-		if (prop)
-			i2c_dev->bus_clk_rate = be32_to_cpup(prop);
-	}
+	} else if (i2c_dev->dev->of_node) /* if there is a device tree node ... */
+		of_property_read_u32(i2c_dev->dev->of_node, "clock-frequency",
+				     (u32 *)&i2c_dev->bus_clk_rate);
 
 	if (pdev->id == 3)
 		i2c_dev->is_dvc = 1;
-- 
1.7.0.4
