From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:39:46 +0100
Subject: [PATCH 1/2] i2c: sunxi: Add new i2c compatibles
Message-ID: <1391348387-9577-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Add compatibles
matching the other pattern to the i2c driver for consistency, and keep the
older one for backward compatibility.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 4 ++--
 drivers/i2c/busses/i2c-mv64xxx.c                      | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 82e8f6f..bd08d67 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -4,8 +4,8 @@
 Required properties :
 
  - reg             : Offset and length of the register set for the device
- - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
-                     or "marvell,mv78230-i2c"
+ - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-a10-i2c"
+                     or "marvell,mv78230-i2c" (Deprecated "allwinner,sun4i-i2c")
  - interrupts      : The interrupt number
 
 Optional properties :
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42..e37a042 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -689,9 +689,12 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  *****************************************************************************
  */
 static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
-	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
+	{ .compatible = "allwinner,sun4i-a10-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
+
+	/* Deprecated */
+	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
-- 
1.8.4.2
