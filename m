From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu,  3 Nov 2016 01:07:59 +1030
Subject: [PATCH v2 4/6] pinctrl: aspeed: Read and write bits in LPCHC and GFX
 controllers
In-Reply-To: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
Message-ID: <1478097481-14895-5-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Control Unit IP block in the Aspeed SoCs is typically where
the pinmux configuration is found, but not always. A number of pins
depend on state in one of LPC Host Control (LPCHC) or SoC Display
Controller (GFX) IP blocks, so the Aspeed pinmux drivers should have the
means to adjust these as necessary.

We use syscon to cast a regmap over the GFX and LPCHCR blocks, which is
used as an arbitration layer between the relevant driver and the pinctrl
subsystem. The regmaps are then exposed to the SoC-specific pinctrl
drivers by phandles in the devicetree, and are selected during a mux
request by querying a new 'ip' member in struct aspeed_sig_desc.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
Since v1:

The change is now proactive: instead of reporting that we need to flip bits in
controllers we can't access, the patch provides access via regmaps for the
relevant controllers. The implementation also splits out the IP block ID into
its own variable rather than packing the value into the upper bits of the reg
member of struct aspeed_sig_desc. This drives some churn in the diff, but I've
tried to minimise it.

 .../devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 50 +++++++++++++---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         | 18 +++---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         | 39 ++++++++++---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            | 66 +++++++++++++---------
 drivers/pinctrl/aspeed/pinctrl-aspeed.h            | 32 ++++++++---
 5 files changed, 144 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
index 2ad18c4ea55c..115b0cce6c1c 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
@@ -4,12 +4,19 @@ Aspeed Pin Controllers
 The Aspeed SoCs vary in functionality inside a generation but have a common mux
 device register layout.
 
-Required properties:
-- compatible : Should be any one of the following:
-		"aspeed,ast2400-pinctrl"
-		"aspeed,g4-pinctrl"
-		"aspeed,ast2500-pinctrl"
-		"aspeed,g5-pinctrl"
+Required properties for g4:
+- compatible : 			Should be any one of the following:
+				"aspeed,ast2400-pinctrl"
+				"aspeed,g4-pinctrl"
+
+Required properties for g5:
+- compatible : 			Should be any one of the following:
+				"aspeed,ast2500-pinctrl"
+				"aspeed,g5-pinctrl"
+
+- aspeed,external-nodes:	A cell of phandles to external controller nodes:
+				0: compatible with "aspeed,ast2500-gfx", "syscon"
+				1: compatible with "aspeed,ast2500-lpchc", "syscon"
 
 The pin controller node should be a child of a syscon node with the required
 property:
@@ -47,7 +54,7 @@ RGMII1 RGMII2 RMII1 RMII2 SD1 SPI1 SPI1DEBUG SPI1PASSTHRU TIMER4 TIMER5 TIMER6
 TIMER7 TIMER8 VGABIOSROM
 
 
-Examples:
+g4 Example:
 
 syscon: scu at 1e6e2000 {
 	compatible = "syscon", "simple-mfd";
@@ -63,5 +70,34 @@ syscon: scu at 1e6e2000 {
 	};
 };
 
+g5 Example:
+
+apb {
+	gfx: display at 1e6e6000 {
+		compatible = "aspeed,ast2500-gfx", "syscon";
+		reg = <0x1e6e6000 0x1000>;
+	};
+
+	lpchc: lpchc at 1e7890a0 {
+		compatible = "aspeed,ast2500-lpchc", "syscon";
+		reg = <0x1e7890a0 0xc4>;
+	};
+
+	syscon: scu at 1e6e2000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x1e6e2000 0x1a8>;
+
+		pinctrl: pinctrl {
+			compatible = "aspeed,g5-pinctrl";
+			aspeed,external-nodes = <&gfx, &lpchc>;
+
+			pinctrl_i2c3_default: i2c3_default {
+				function = "I2C3";
+				groups = "I2C3";
+			};
+		};
+	};
+};
+
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices.
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index a21b071ff290..558bd102416c 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -292,7 +292,7 @@ SSSF_PIN_DECL(U18, GPIOG7, FLWP, SIG_DESC_SET(SCU84, 7));
 #define UART6_DESC	SIG_DESC_SET(SCU90, 7)
 #define ROM16_DESC	SIG_DESC_SET(SCU90, 6)
 #define FLASH_WIDE	SIG_DESC_SET(HW_STRAP1, 4)
-#define BOOT_SRC_NOR	{ HW_STRAP1, GENMASK(1, 0), 0, 0 }
+#define BOOT_SRC_NOR	{ ASPEED_IP_SCU, HW_STRAP1, GENMASK(1, 0), 0, 0 }
 
 #define A8 56
 SIG_EXPR_DECL(ROMD8, ROM16, ROM16_DESC);
@@ -418,9 +418,9 @@ FUNC_GROUP_DECL(I2C8, G5, F3);
 #define U1 88
 SSSF_PIN_DECL(U1, GPIOL0, NCTS1, SIG_DESC_SET(SCU84, 16));
 
-#define VPI18_DESC	{ SCU90, GENMASK(5, 4), 1, 0 }
-#define VPI24_DESC	{ SCU90, GENMASK(5, 4), 2, 0 }
-#define VPI30_DESC	{ SCU90, GENMASK(5, 4), 3, 0 }
+#define VPI18_DESC	{ ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 1, 0 }
+#define VPI24_DESC	{ ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 2, 0 }
+#define VPI30_DESC	{ ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 3, 0 }
 
 #define T5 89
 #define T5_DESC         SIG_DESC_SET(SCU84, 17)
@@ -641,11 +641,11 @@ SSSF_PIN_DECL(Y22, GPIOR2, ROMCS3, SIG_DESC_SET(SCU88, 26));
 #define U19 139
 SSSF_PIN_DECL(U19, GPIOR3, ROMCS4, SIG_DESC_SET(SCU88, 27));
 
-#define VPOOFF0_DESC	{ SCU94, GENMASK(1, 0), 0, 0 }
-#define VPO12_DESC	{ SCU94, GENMASK(1, 0), 1, 0 }
-#define VPO24_DESC	{ SCU94, GENMASK(1, 0), 2, 0 }
-#define VPOOFF1_DESC	{ SCU94, GENMASK(1, 0), 3, 0 }
-#define VPO_OFF_12      { SCU94, 0x2, 0, 0 }
+#define VPOOFF0_DESC	{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 0, 0 }
+#define VPO12_DESC	{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 1, 0 }
+#define VPO24_DESC	{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 2, 0 }
+#define VPOOFF1_DESC	{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 3, 0 }
+#define VPO_OFF_12      { ASPEED_IP_SCU, SCU94, 0x2, 0, 0 }
 #define VPO_24_OFF      SIG_DESC_SET(SCU94, 1)
 
 #define V21 140
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 87b46390b695..99c4fa9bf861 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -26,8 +27,8 @@
 
 #define ASPEED_G5_NR_PINS 228
 
-#define COND1		{ SCU90, BIT(6), 0, 0 }
-#define COND2		{ SCU94, GENMASK(1, 0), 0, 0 }
+#define COND1		{ ASPEED_IP_SCU, SCU90, BIT(6), 0, 0 }
+#define COND2		{ ASPEED_IP_SCU, SCU94, GENMASK(1, 0), 0, 0 }
 
 #define B14 0
 SSSF_PIN_DECL(B14, GPIOA0, MAC1LINK, SIG_DESC_SET(SCU80, 0));
@@ -186,9 +187,12 @@ MS_PIN_DECL(C20, GPIOE1, NDCD3, GPIE0OUT);
 
 FUNC_GROUP_DECL(GPIE0, B20, C20);
 
-#define SPI1_DESC		{ HW_STRAP1, GENMASK(13, 12), 1, 0 }
-#define SPI1DEBUG_DESC		{ HW_STRAP1, GENMASK(13, 12), 2, 0 }
-#define SPI1PASSTHRU_DESC	{ HW_STRAP1, GENMASK(13, 12), 3, 0 }
+#define SPI1_DESC \
+	{ ASPEED_IP_SCU, HW_STRAP1, GENMASK(13, 12), 1, 0 }
+#define SPI1DEBUG_DESC \
+	{ ASPEED_IP_SCU, HW_STRAP1, GENMASK(13, 12), 2, 0 }
+#define SPI1PASSTHRU_DESC \
+	{ ASPEED_IP_SCU, HW_STRAP1, GENMASK(13, 12), 3, 0 }
 
 #define C18 64
 SIG_EXPR_DECL(SYSCS, SPI1DEBUG, COND1, SPI1DEBUG_DESC);
@@ -325,10 +329,11 @@ SS_PIN_DECL(R1, GPIOK7, SDA8);
 
 FUNC_GROUP_DECL(I2C8, P2, R1);
 
-#define VPIOFF0_DESC    { SCU90, GENMASK(5, 4), 0, 0 }
-#define VPIOFF1_DESC    { SCU90, GENMASK(5, 4), 1, 0 }
-#define VPI24_DESC      { SCU90, GENMASK(5, 4), 2, 0 }
-#define VPIRSVD_DESC    { SCU90, GENMASK(5, 4), 3, 0 }
+#define VPIOFF0_DESC    { ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 0, 0 }
+#define VPIOFF1_DESC    { ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 1, 0 }
+#define VPI24_DESC      { ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 2, 0 }
+#define VPIRSVD_DESC    { ASPEED_IP_SCU, SCU90, GENMASK(5, 4), 3, 0 }
+
 
 #define V2 104
 #define V2_DESC         SIG_DESC_SET(SCU88, 0)
@@ -848,10 +853,26 @@ static struct pinctrl_desc aspeed_g5_pinctrl_desc = {
 static int aspeed_g5_pinctrl_probe(struct platform_device *pdev)
 {
 	int i;
+	struct regmap **map;
+	struct device_node *node;
 
 	for (i = 0; i < ARRAY_SIZE(aspeed_g5_pins); i++)
 		aspeed_g5_pins[i].number = i;
 
+	map = &aspeed_g5_pinctrl_data.maps[ASPEED_IP_GFX];
+	node = of_parse_phandle(pdev->dev.of_node, "aspeed,external-nodes", 0);
+	*map = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(*map))
+		return PTR_ERR(*map);
+
+	map = &aspeed_g5_pinctrl_data.maps[ASPEED_IP_LPCHC];
+	node = of_parse_phandle(pdev->dev.of_node, "aspeed,external-nodes", 1);
+	*map = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(*map))
+		return PTR_ERR(*map);
+
 	return aspeed_pinctrl_probe(pdev, &aspeed_g5_pinctrl_desc,
 			&aspeed_g5_pinctrl_data);
 }
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 49aeba912531..23586aac7a5a 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -14,6 +14,12 @@
 #include "../core.h"
 #include "pinctrl-aspeed.h"
 
+static const char *const aspeed_pinmux_ips[] = {
+	[ASPEED_IP_SCU] = "SCU",
+	[ASPEED_IP_GFX] = "GFX",
+	[ASPEED_IP_LPCHC] = "LHCR",
+};
+
 int aspeed_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct aspeed_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
@@ -78,7 +84,8 @@ int aspeed_pinmux_get_fn_groups(struct pinctrl_dev *pctldev,
 static inline void aspeed_sig_desc_print_val(
 		const struct aspeed_sig_desc *desc, bool enable, u32 rv)
 {
-	pr_debug("SCU%x[0x%08x]=0x%x, got 0x%x from 0x%08x\n", desc->reg,
+	pr_debug("Want %s%X[0x%08X]=0x%X, got 0x%X from 0x%08X\n",
+			aspeed_pinmux_ips[desc->ip], desc->reg,
 			desc->mask, enable ? desc->enable : desc->disable,
 			(rv & desc->mask) >> __ffs(desc->mask), rv);
 }
@@ -88,7 +95,7 @@ static inline void aspeed_sig_desc_print_val(
  *
  * @desc: The signal descriptor of interest
  * @enabled: True to query the enabled state, false to query disabled state
- * @regmap: The SCU regmap instance
+ * @regmap: The IP block's regmap instance
  *
  * @return True if the descriptor's bitfield is configured to the state
  * selected by @enabled, false otherwise
@@ -119,7 +126,7 @@ static bool aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
  *
  * @expr: An expression controlling the signal for a mux function on a pin
  * @enabled: True to query the enabled state, false to query disabled state
- * @regmap: The SCU regmap instance
+ * @maps: The list of regmap instances
  *
  * @return True if the expression composed by @enabled evaluates true, false
  * otherwise
@@ -136,15 +143,16 @@ static bool aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
  * either condition as required.
  */
 static bool aspeed_sig_expr_eval(const struct aspeed_sig_expr *expr,
-				 bool enabled, struct regmap *map)
+				 bool enabled, struct regmap * const *maps)
 {
 	int i;
 
 	for (i = 0; i < expr->ndescs; i++) {
 		const struct aspeed_sig_desc *desc = &expr->descs[i];
 
-		if (!aspeed_sig_desc_eval(desc, enabled, map))
+		if (!aspeed_sig_desc_eval(desc, enabled, maps[desc->ip]))
 			return false;
+
 	}
 
 	return true;
@@ -158,12 +166,12 @@ static bool aspeed_sig_expr_eval(const struct aspeed_sig_expr *expr,
  *        configured
  * @enable: true to enable an function's signal through a pin's signal
  *          expression, false to disable the function's signal
- * @map: The SCU's regmap instance for pinmux register access.
+ * @maps: The list of regmap instances for pinmux register access.
  *
  * @return true if the expression is configured as requested, false otherwise
  */
 static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
-				bool enable, struct regmap *map)
+				bool enable, struct regmap * const *maps)
 {
 	int i;
 
@@ -171,6 +179,7 @@ static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
 		bool ret;
 		const struct aspeed_sig_desc *desc = &expr->descs[i];
 		u32 pattern = enable ? desc->enable : desc->disable;
+		u32 val = (pattern << __ffs(desc->mask));
 
 		/*
 		 * Strap registers are configured in hardware or by early-boot
@@ -179,48 +188,49 @@ static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
 		 * deconfigured and is the reason we re-evaluate after writing
 		 * all descriptor bits.
 		 */
-		if (desc->reg == HW_STRAP1 || desc->reg == HW_STRAP2)
+		if ((desc->reg == HW_STRAP1 || desc->reg == HW_STRAP2) &&
+				desc->ip == ASPEED_IP_SCU)
 			continue;
 
-		ret = regmap_update_bits(map, desc->reg, desc->mask,
-				pattern << __ffs(desc->mask)) == 0;
+		ret = regmap_update_bits(maps[desc->ip], desc->reg,
+					 desc->mask, val) == 0;
 
 		if (!ret)
 			return ret;
 	}
 
-	return aspeed_sig_expr_eval(expr, enable, map);
+	return aspeed_sig_expr_eval(expr, enable, maps);
 }
 
 static bool aspeed_sig_expr_enable(const struct aspeed_sig_expr *expr,
-				   struct regmap *map)
+				   struct regmap * const *maps)
 {
-	if (aspeed_sig_expr_eval(expr, true, map))
+	if (aspeed_sig_expr_eval(expr, true, maps))
 		return true;
 
-	return aspeed_sig_expr_set(expr, true, map);
+	return aspeed_sig_expr_set(expr, true, maps);
 }
 
 static bool aspeed_sig_expr_disable(const struct aspeed_sig_expr *expr,
-				    struct regmap *map)
+				    struct regmap * const *maps)
 {
-	if (!aspeed_sig_expr_eval(expr, true, map))
+	if (!aspeed_sig_expr_eval(expr, true, maps))
 		return true;
 
-	return aspeed_sig_expr_set(expr, false, map);
+	return aspeed_sig_expr_set(expr, false, maps);
 }
 
 /**
  * Disable a signal on a pin by disabling all provided signal expressions.
  *
  * @exprs: The list of signal expressions (from a priority level on a pin)
- * @map: The SCU's regmap instance for pinmux register access.
+ * @maps: The list of regmap instances for pinmux register access.
  *
  * @return true if all expressions in the list are successfully disabled, false
  * otherwise
  */
 static bool aspeed_disable_sig(const struct aspeed_sig_expr **exprs,
-			       struct regmap *map)
+			       struct regmap * const *maps)
 {
 	bool disabled = true;
 
@@ -230,7 +240,7 @@ static bool aspeed_disable_sig(const struct aspeed_sig_expr **exprs,
 	while (*exprs) {
 		bool ret;
 
-		ret = aspeed_sig_expr_disable(*exprs, map);
+		ret = aspeed_sig_expr_disable(*exprs, maps);
 		disabled = disabled && ret;
 
 		exprs++;
@@ -343,6 +353,8 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 		const struct aspeed_sig_expr **funcs;
 		const struct aspeed_sig_expr ***prios;
 
+		pr_debug("Muxing pin %d for %s\n", pin, pfunc->name);
+
 		if (!pdesc)
 			return -EINVAL;
 
@@ -358,7 +370,7 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 			if (expr)
 				break;
 
-			if (!aspeed_disable_sig(funcs, pdata->map))
+			if (!aspeed_disable_sig(funcs, pdata->maps))
 				return -EPERM;
 
 			prios++;
@@ -377,7 +389,7 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 			return -ENXIO;
 		}
 
-		if (!aspeed_sig_expr_enable(expr, pdata->map))
+		if (!aspeed_sig_expr_enable(expr, pdata->maps))
 			return -EPERM;
 	}
 
@@ -432,7 +444,7 @@ int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
 		if (aspeed_gpio_in_exprs(funcs))
 			break;
 
-		if (!aspeed_disable_sig(funcs, pdata->map))
+		if (!aspeed_disable_sig(funcs, pdata->maps))
 			return -EPERM;
 
 		prios++;
@@ -462,7 +474,7 @@ int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
 	 * If GPIO is not the lowest priority signal type, assume there is only
 	 * one expression defined to enable the GPIO function
 	 */
-	if (!aspeed_sig_expr_enable(expr, pdata->map))
+	if (!aspeed_sig_expr_enable(expr, pdata->maps))
 		return -EPERM;
 
 	return 0;
@@ -481,10 +493,10 @@ int aspeed_pinctrl_probe(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
-	pdata->map = syscon_node_to_regmap(parent->of_node);
-	if (IS_ERR(pdata->map)) {
+	pdata->maps[ASPEED_IP_SCU] = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(pdata->maps[ASPEED_IP_SCU])) {
 		dev_err(&pdev->dev, "No regmap for syscon pincontroller parent\n");
-		return PTR_ERR(pdata->map);
+		return PTR_ERR(pdata->maps[ASPEED_IP_SCU]);
 	}
 
 	pctl = pinctrl_register(pdesc, &pdev->dev, pdata);
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
index 3e72ef8c54bf..727728b86c07 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -232,6 +232,11 @@
  * group.
  */
 
+#define ASPEED_IP_SCU	0
+#define ASPEED_IP_GFX	1
+#define ASPEED_IP_LPCHC	2
+#define ASPEED_NR_PINMUX_IPS	3
+
 /*
  * The "Multi-function Pins Mapping and Control" table in the SoC datasheet
  * references registers by the device/offset mnemonic. The register macros
@@ -261,7 +266,9 @@
   * A signal descriptor, which describes the register, bits and the
   * enable/disable values that should be compared or written.
   *
-  * @reg: The register offset from base in bytes
+  * @ip: The IP block identifier, used as an index into the regmap array in
+  *      struct aspeed_pinctrl_data
+  * @reg: The register offset with respect to the base address of the IP block
   * @mask: The mask to apply to the register. The lowest set bit of the mask is
   *        used to derive the shift value.
   * @enable: The value that enables the function. Value should be in the LSBs,
@@ -270,6 +277,7 @@
   *           LSBs, not at the position of the mask.
   */
 struct aspeed_sig_desc {
+	unsigned int ip;
 	unsigned int reg;
 	u32 mask;
 	u32 enable;
@@ -313,24 +321,30 @@ struct aspeed_pin_desc {
 
 /* Macro hell */
 
+#define SIG_DESC_IP_BIT(ip, reg, idx, val) \
+	{ ip, reg, BIT_MASK(idx), val, (((val) + 1) & 1) }
+
 /**
- * Short-hand macro for describing a configuration enabled by the state of one
- * bit. The disable value is derived.
+ * Short-hand macro for describing an SCU descriptor enabled by the state of
+ * one bit. The disable value is derived.
  *
  * @reg: The signal's associated register, offset from base
  * @idx: The signal's bit index in the register
  * @val: The value (0 or 1) that enables the function
  */
 #define SIG_DESC_BIT(reg, idx, val) \
-	{ reg, BIT_MASK(idx), val, (((val) + 1) & 1) }
+	SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, val)
+
+#define SIG_DESC_IP_SET(ip, reg, idx) SIG_DESC_IP_BIT(ip, reg, idx, 1)
 
 /**
- * A further short-hand macro describing a configuration enabled with a set bit.
+ * A further short-hand macro expanding to an SCU descriptor enabled by a set
+ * bit.
  *
- * @reg: The configuration's associated register, offset from base
- * @idx: The configuration's bit index in the register
+ * @reg: The register, offset from base
+ * @idx: The bit index in the register
  */
-#define SIG_DESC_SET(reg, idx) SIG_DESC_BIT(reg, idx, 1)
+#define SIG_DESC_SET(reg, idx) SIG_DESC_IP_BIT(ASPEED_IP_SCU, reg, idx, 1)
 
 #define SIG_DESC_LIST_SYM(sig, func) sig_descs_ ## sig ## _ ## func
 #define SIG_DESC_LIST_DECL(sig, func, ...) \
@@ -500,7 +514,7 @@ struct aspeed_pin_desc {
 	MS_PIN_DECL_(pin, SIG_EXPR_LIST_PTR(gpio))
 
 struct aspeed_pinctrl_data {
-	struct regmap *map;
+	struct regmap *maps[ASPEED_NR_PINMUX_IPS];
 
 	const struct pinctrl_pin_desc *pins;
 	const unsigned int npins;
-- 
2.7.4
