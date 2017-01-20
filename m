From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:22 +0100
Subject: [PATCH 4/8] clk: renesas: cpg-mssr: Add support for reset control
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional support for the Reset Control feature of the Renesas Clock
Pulse Generator / Module Standby and Software Reset module on R-Car
Gen2, R-Car Gen3, and RZ/G1 SoCs.

This allows to reset SoC devices using the Reset Controller API.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 122 +++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index f1161a585c57e433..ea4af714ac14603a 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -25,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
@@ -96,6 +98,7 @@
 /**
  * Clock Pulse Generator / Module Standby and Software Reset Private Data
  *
+ * @rcdev: Optional reset controller entity
  * @dev: CPG/MSSR device
  * @base: CPG/MSSR register block base address
  * @rmw_lock: protects RMW register accesses
@@ -105,6 +108,9 @@
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  */
 struct cpg_mssr_priv {
+#ifdef CONFIG_RESET_CONTROLLER
+	struct reset_controller_dev rcdev;
+#endif
 	struct device *dev;
 	void __iomem *base;
 	spinlock_t rmw_lock;
@@ -494,6 +500,118 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	return 0;
 }
 
+#ifdef CONFIG_RESET_CONTROLLER
+
+#define rcdev_to_priv(x)	container_of(x, struct cpg_mssr_priv, rcdev)
+
+static int cpg_mssr_reset(struct reset_controller_dev *rcdev,
+			  unsigned long id)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+	u32 bitmask = BIT(bit);
+	unsigned long flags;
+	u32 value;
+
+	dev_dbg(priv->dev, "reset %u%02u\n", reg, bit);
+
+	/* Reset module */
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	value = readl(priv->base + SRCR(reg));
+	value |= bitmask;
+	writel(value, priv->base + SRCR(reg));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+	udelay(35);
+
+	/* Release module from reset state */
+	writel(bitmask, priv->base + SRSTCLR(reg));
+
+	return 0;
+}
+
+static int cpg_mssr_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+	unsigned long flags;
+	u32 value;
+
+	dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	value = readl(priv->base + SRCR(reg));
+	writel(value | BIT(bit), priv->base + SRCR(reg));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	return 0;
+}
+
+static int cpg_mssr_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+
+	dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);
+
+	writel(BIT(bit), priv->base + SRSTCLR(reg));
+	return 0;
+}
+
+static int cpg_mssr_status(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+
+	return !!(readl(priv->base + SRCR(reg)) & BIT(bit));
+}
+
+static const struct reset_control_ops cpg_mssr_reset_ops = {
+	.reset = cpg_mssr_reset,
+	.assert = cpg_mssr_assert,
+	.deassert = cpg_mssr_deassert,
+	.status = cpg_mssr_status,
+};
+
+static int cpg_mssr_reset_xlate(struct reset_controller_dev *rcdev,
+				const struct of_phandle_args *reset_spec)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int unpacked = reset_spec->args[0];
+	unsigned int idx = MOD_CLK_PACK(unpacked);
+
+	if (unpacked % 100 > 31 || idx >= rcdev->nr_resets) {
+		dev_err(priv->dev, "Invalid reset index %u\n", unpacked);
+		return -EINVAL;
+	}
+
+	return idx;
+}
+
+static int cpg_mssr_reset_controller_register(struct cpg_mssr_priv *priv)
+{
+	priv->rcdev.ops = &cpg_mssr_reset_ops;
+	priv->rcdev.of_node = priv->dev->of_node;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.of_xlate = cpg_mssr_reset_xlate;
+	priv->rcdev.nr_resets = priv->num_mod_clks;
+	return devm_reset_controller_register(priv->dev, &priv->rcdev);
+}
+
+#else /* !CONFIG_RESET_CONTROLLER */
+static inline int cpg_mssr_reset_controller_register(struct cpg_mssr_priv *priv)
+{
+	return 0;
+}
+#endif /* !CONFIG_RESET_CONTROLLER */
+
+
 static const struct of_device_id cpg_mssr_match[] = {
 #ifdef CONFIG_ARCH_R8A7743
 	{
@@ -591,6 +709,10 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	error = cpg_mssr_reset_controller_register(priv);
+	if (error)
+		return error;
+
 	return 0;
 }
 
-- 
1.9.1
