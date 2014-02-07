From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Feb 2014 16:21:50 +0100
Subject: [PATCH v4 2/5] clk: sunxi: Add USB clock register defintions
In-Reply-To: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
References: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1391786513-20780-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add register definitions for the usb-clk register found on sun4i, sun5i and
sun7i SoCs.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  5 +++++
 drivers/clk/sunxi/clk-sunxi.c                     | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 27f19f1..5aa8d6d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -38,6 +38,8 @@ Required properties:
 	"allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
+	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
+	"allwinner,sun5i-a13-usb-clk" - for usb gates + resets on A13
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
@@ -54,6 +56,9 @@ Required properties for all clocks:
 For "allwinner,sun7i-a20-gmac-clk", the parent clocks shall be fixed rate
 dummy clocks at 25 MHz and 125 MHz, respectively. See example.
 
+And "allwinner,*-usb-clk" clocks also require:
+- reset-cells : shall be set to 1
+
 Clock consumers should specify the desired clocks they use with a
 "clocks" phandle cell. Consumers that are using a gated clock should
 provide an additional ID in their clock property. This ID is the
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 1e15e4c..61e57d2 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -910,6 +910,16 @@ static const struct gates_data sun4i_ahb_gates_data __initconst = {
 	.mask = {0x7F77FFF, 0x14FB3F},
 };
 
+static const struct gates_data sun4i_a10_usb_gates_data __initconst = {
+	.mask = {0x1C0},
+	.reset_mask = 0x07,
+};
+
+static const struct gates_data sun5i_a13_usb_gates_data __initconst = {
+	.mask = {0x140},
+	.reset_mask = 0x03,
+};
+
 static const struct gates_data sun5i_a10s_ahb_gates_data __initconst = {
 	.mask = {0x147667e7, 0x185915},
 };
@@ -1257,6 +1267,8 @@ static const struct of_device_id clk_gates_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-apb1-gates-clk", .data = &sun6i_a31_apb1_gates_data,},
 	{.compatible = "allwinner,sun7i-a20-apb1-gates-clk", .data = &sun7i_a20_apb1_gates_data,},
 	{.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
+	{.compatible = "allwinner,sun4i-a10-usb-clk", .data = &sun4i_a10_usb_gates_data,},
+	{.compatible = "allwinner,sun5i-a13-usb-clk", .data = &sun5i_a13_usb_gates_data,},
 	{}
 };
 
-- 
1.8.4.2
