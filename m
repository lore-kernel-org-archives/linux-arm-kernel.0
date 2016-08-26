From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:20:59 +0100
Subject: [PATCH 3/8] arm: orion5x: Generalise mv88f5181l pinctrl support for
 88f5181
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-4-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As far as I'm aware the mv88f5181-b1 and mv88f5181l are the same at the
pinctrl level, so re-use the definitions for both.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  4 +++-
 drivers/pinctrl/mvebu/pinctrl-orion.c              | 23 +++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
index 27570a3..ec8aa3c 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
@@ -4,7 +4,9 @@ Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
 part and usage.
 
 Required properties:
-- compatible: "marvell,88f5181l-pinctrl", "marvell,88f5182-pinctrl",
+- compatible: "marvell,88f5181-pinctrl",
+              "marvell,88f5181l-pinctrl",
+              "marvell,88f5182-pinctrl",
               "marvell,88f5281-pinctrl"
 
 - reg: two register areas, the first one describing the first two
diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
index 345c3df..84e1441 100644
--- a/drivers/pinctrl/mvebu/pinctrl-orion.c
+++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
@@ -64,11 +64,11 @@ static int orion_mpp_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-#define V(f5181l, f5182, f5281) \
-	((f5181l << 0) | (f5182 << 1) | (f5281 << 2))
+#define V(f5181, f5182, f5281) \
+	((f5181 << 0) | (f5182 << 1) | (f5281 << 2))
 
 enum orion_variant {
-	V_5181L = V(1, 0, 0),
+	V_5181  = V(1, 0, 0),
 	V_5182  = V(0, 1, 0),
 	V_5281  = V(0, 0, 1),
 	V_ALL   = V(1, 1, 1),
@@ -103,13 +103,13 @@ static struct mvebu_mpp_mode orion_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
 		 MPP_VAR_FUNCTION(0x2, "pci", "req5",       V_ALL),
 		 MPP_VAR_FUNCTION(0x4, "nand", "re0",       V_5182 | V_5281),
-		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181L),
+		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181),
 		 MPP_VAR_FUNCTION(0x5, "sata0", "act",      V_5182)),
 	MPP_MODE(7,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
 		 MPP_VAR_FUNCTION(0x2, "pci", "gnt5",       V_ALL),
 		 MPP_VAR_FUNCTION(0x4, "nand", "we0",       V_5182 | V_5281),
-		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181L),
+		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181),
 		 MPP_VAR_FUNCTION(0x5, "sata1", "act",      V_5182)),
 	MPP_MODE(8,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
@@ -165,7 +165,7 @@ static struct mvebu_mpp_ctrl orion_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 19, NULL, orion_mpp_ctrl),
 };
 
-static struct pinctrl_gpio_range mv88f5181l_gpio_ranges[] = {
+static struct pinctrl_gpio_range mv88f5181_gpio_ranges[] = {
 	MPP_GPIO_RANGE(0, 0, 0, 16),
 };
 
@@ -177,14 +177,14 @@ static struct pinctrl_gpio_range mv88f5281_gpio_ranges[] = {
 	MPP_GPIO_RANGE(0, 0, 0, 16),
 };
 
-static struct mvebu_pinctrl_soc_info mv88f5181l_info = {
-	.variant = V_5181L,
+static struct mvebu_pinctrl_soc_info mv88f5181_info = {
+	.variant = V_5181,
 	.controls = orion_mpp_controls,
 	.ncontrols = ARRAY_SIZE(orion_mpp_controls),
 	.modes = orion_mpp_modes,
 	.nmodes = ARRAY_SIZE(orion_mpp_modes),
-	.gpioranges = mv88f5181l_gpio_ranges,
-	.ngpioranges = ARRAY_SIZE(mv88f5181l_gpio_ranges),
+	.gpioranges = mv88f5181_gpio_ranges,
+	.ngpioranges = ARRAY_SIZE(mv88f5181_gpio_ranges),
 };
 
 static struct mvebu_pinctrl_soc_info mv88f5182_info = {
@@ -212,7 +212,8 @@ static struct mvebu_pinctrl_soc_info mv88f5281_info = {
  * muxing, they are identical.
  */
 static const struct of_device_id orion_pinctrl_of_match[] = {
-	{ .compatible = "marvell,88f5181l-pinctrl", .data = &mv88f5181l_info },
+	{ .compatible = "marvell,88f5181-pinctrl", .data = &mv88f5181_info },
+	{ .compatible = "marvell,88f5181l-pinctrl", .data = &mv88f5181_info },
 	{ .compatible = "marvell,88f5182-pinctrl", .data = &mv88f5182_info },
 	{ .compatible = "marvell,88f5281-pinctrl", .data = &mv88f5281_info },
 	{ }
-- 
2.8.1
