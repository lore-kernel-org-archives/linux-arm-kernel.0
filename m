From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 17:22:54 +0200
Subject: [PATCH v7 02/13] clk: apn806: Turn the eMMC clock as optional for dts
 backwards compatible
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Message-ID: <b94b2164859fa487a38bcb00e95dd26cc20aef77.1490886907.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First version of the binding didn't have the eMMC clock. This patch
allows to not registering the eMMC clock if it is not present in the
device tree. Then the device tree can be backwards compatible.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index 901d89c4ab4a..103fe18a3c29 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -136,13 +136,19 @@ static int ap806_syscon_clk_probe(struct platform_device *pdev)
 	}
 
 	/* eMMC Clock is fixed clock divided by 3 */
-	of_property_read_string_index(np, "clock-output-names",
-				      4, &name);
-	ap806_clks[4] = clk_register_fixed_factor(NULL, name, fixedclk_name,
-						  0, 1, 3);
-	if (IS_ERR(ap806_clks[4])) {
-		ret = PTR_ERR(ap806_clks[4]);
-		goto fail4;
+	if (of_property_read_string_index(np, "clock-output-names",
+					  4, &name)) {
+		ap806_clk_data.clk_num--;
+		dev_warn(&pdev->dev,
+			 "eMMC clock mising: update the device tree!\n");
+	} else {
+		ap806_clks[4] = clk_register_fixed_factor(NULL, name,
+							  fixedclk_name,
+							  0, 1, 3);
+		if (IS_ERR(ap806_clks[4])) {
+			ret = PTR_ERR(ap806_clks[4]);
+			goto fail4;
+		}
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
-- 
git-series 0.9.1
