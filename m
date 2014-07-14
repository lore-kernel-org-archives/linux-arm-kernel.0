From: sassmann@kpanic.de (Stefan Assmann)
Date: Mon, 14 Jul 2014 13:50:55 +0200
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
Message-ID: <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This partly reverts the following commits to get the wifi working on
the Pandaboard OMAP4430 ES2.2.

0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4 regulator: twl: Remove references to 32kHz clock from DT bindings
d1924519fe1dada0cfd9a228bf2ff1ea15840c84 regulator: twl: Remove TWL6030_FIXED_RESOURCE
029dd3cefa46ecdd879f9b4e2df3bdf4371cc22c regulator: twl: Remove another unused variable warning
e76ab829cc2d8b6350a3f01fffb208df4d7d8c1b regulator: twl: Remove references to the twl4030 regulator

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../bindings/regulator/twl-regulator.txt           |  1 +
 drivers/regulator/twl-regulator.c                  | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index 75b0c16..e627860 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -15,6 +15,7 @@ For twl6030 regulators/LDOs
   - "ti,twl6030-vusb" for VUSB LDO
   - "ti,twl6030-v1v8" for V1V8 LDO
   - "ti,twl6030-v2v1" for V2V1 LDO
+  - "ti,twl6030-clk32kg" for CLK32KG RESOURCE
   - "ti,twl6030-vdd1" for VDD1 SMPS
   - "ti,twl6030-vdd2" for VDD2 SMPS
   - "ti,twl6030-vdd3" for VDD3 SMPS
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index fed28ab..c745d96 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -633,6 +633,13 @@ static struct regulator_ops twl6030fixed_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
+static struct regulator_ops twl6030_fixed_resource = {
+	.enable		= twl6030reg_enable,
+	.disable	= twl6030reg_disable,
+	.is_enabled	= twl6030reg_is_enabled,
+	.get_status	= twl6030reg_get_status,
+};
+
 /*
  * SMPS status and control
  */
@@ -948,6 +955,19 @@ static const struct twlreg_info TWLSMPS_INFO_##label = { \
 		}, \
 	}
 
+#define TWL6030_FIXED_RESOURCE(label, offset, turnon_delay) \
+static struct twlreg_info TWLRES_INFO_##label = { \
+	.base = offset, \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030_fixed_resource, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		.enable_time = turnon_delay, \
+		}, \
+	}
+
 /*
  * We list regulators here if systems need some level of
  * software control over them after boot.
@@ -1001,6 +1021,7 @@ TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
 TWL6030_FIXED_LDO(VUSB, 0x70, 3300, 0);
 TWL6030_FIXED_LDO(V1V8, 0x16, 1800, 0);
 TWL6030_FIXED_LDO(V2V1, 0x1c, 2100, 0);
+TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);
 TWL6032_ADJUSTABLE_SMPS(SMPS3, 0x34);
 TWL6032_ADJUSTABLE_SMPS(SMPS4, 0x10);
 TWL6032_ADJUSTABLE_SMPS(VIO, 0x16);
@@ -1033,6 +1054,7 @@ static u8 twl_get_smps_mult(void)
 #define TWL6030_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6030, label)
 #define TWL6032_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWL6032, label)
 #define TWLFIXED_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLFIXED, label)
+#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
 #define TWLSMPS_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLSMPS, label)
 
 static const struct of_device_id twl_of_match[] = {
@@ -1080,6 +1102,7 @@ static const struct of_device_id twl_of_match[] = {
 	TWLFIXED_OF_MATCH("ti,twl6030-vusb", VUSB),
 	TWLFIXED_OF_MATCH("ti,twl6030-v1v8", V1V8),
 	TWLFIXED_OF_MATCH("ti,twl6030-v2v1", V2V1),
+	TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),
 	TWLSMPS_OF_MATCH("ti,twl6032-smps3", SMPS3),
 	TWLSMPS_OF_MATCH("ti,twl6032-smps4", SMPS4),
 	TWLSMPS_OF_MATCH("ti,twl6032-vio", VIO),
-- 
1.9.3
