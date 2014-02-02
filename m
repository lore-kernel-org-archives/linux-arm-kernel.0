From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:52:05 +0100
Subject: [PATCH 1/2] misc: eeprom: sunxi: Add new compatibles
Message-ID: <1391349126-10903-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Add compatibles
matching the other pattern to the SID driver for consistency, and keep the
older one for backward compatibility.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt | 5 +++--
 drivers/misc/eeprom/sunxi_sid.c                                | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
index 68ba372..c10a61a 100644
--- a/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
@@ -1,12 +1,13 @@
 Allwinner sunxi-sid
 
 Required properties:
-- compatible: "allwinner,sun4i-sid" or "allwinner,sun7i-a20-sid".
+- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
+              (Deprecated: "allwinner,sun4i-sid").
 - reg: Should contain registers location and length
 
 Example for sun4i:
 	sid at 01c23800 {
-		compatible = "allwinner,sun4i-sid";
+		compatible = "allwinner,sun4i-a10-sid";
 		reg = <0x01c23800 0x10>
 	};
 
diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/misc/eeprom/sunxi_sid.c
index 9c34e57..e137e75 100644
--- a/drivers/misc/eeprom/sunxi_sid.c
+++ b/drivers/misc/eeprom/sunxi_sid.c
@@ -96,8 +96,11 @@ static int sunxi_sid_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_sid_of_match[] = {
-	{ .compatible = "allwinner,sun4i-sid", .data = (void *)16},
+	{ .compatible = "allwinner,sun4i-a10-sid", .data = (void *)16},
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = (void *)512},
+
+	/* Deprecated */
+	{ .compatible = "allwinner,sun4i-sid", .data = (void *)16},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
1.8.4.2
