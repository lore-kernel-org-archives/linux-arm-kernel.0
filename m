From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 00:48:05 +0800
Subject: [PATCH 1/2] clk: sunxi: Add sun8i MBUS clock support
In-Reply-To: <1410540486-22243-1-git-send-email-wens@csie.org>
References: <1410540486-22243-1-git-send-email-wens@csie.org>
Message-ID: <1410540486-22243-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-mod0.c                      | 55 +++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 425b109..fb3b7aa 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -50,6 +50,7 @@ Required properties:
 	"allwinner,sun4i-a10-mmc-output-clk" - for the MMC output clock on A10
 	"allwinner,sun4i-a10-mmc-sample-clk" - for the MMC sample clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
+	"allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
 	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 4a56385..9850887 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -94,6 +94,61 @@ static void __init sun5i_a13_mbus_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(sun5i_a13_mbus, "allwinner,sun5i-a13-mbus-clk", sun5i_a13_mbus_setup);
 
+/**
+ * sun8i_a23_get_mbus_factors() - calculates m factor for MBUS clocks
+ * MBUS rate is calculated as follows
+ * rate = parent_rate / (m + 1);
+ */
+
+static void sun8i_a23_get_mbus_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	if (div > 8)
+		div = 8;
+
+	*freq = parent_rate / div;
+
+	/* we were called to round the frequency, we can now return */
+	if (m == NULL)
+		return;
+
+	*m = div - 1;
+}
+
+static struct clk_factors_config sun8i_a23_mbus_config = {
+	.mshift = 0,
+	.mwidth = 3,
+};
+
+static const struct factors_data sun8i_a23_mbus_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.table = &sun8i_a23_mbus_config,
+	.getter = sun8i_a23_get_mbus_factors,
+};
+
+static DEFINE_SPINLOCK(sun8i_a23_mbus_lock);
+
+static void __init sun8i_a23_mbus_setup(struct device_node *node)
+{
+	struct clk *mbus = sunxi_factors_register(node, &sun8i_a23_mbus_data,
+						  &sun8i_a23_mbus_lock);
+
+	/* The MBUS clocks needs to be always enabled */
+	__clk_get(mbus);
+	clk_prepare_enable(mbus);
+}
+CLK_OF_DECLARE(sun8i_a23_mbus, "allwinner,sun8i-a23-mbus-clk", sun8i_a23_mbus_setup);
+
 struct mmc_phase_data {
 	u8	offset;
 };
-- 
2.1.0
