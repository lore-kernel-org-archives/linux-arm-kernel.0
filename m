From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:21 +0100
Subject: [PATCH 3/8] clk: renesas: cpg-mssr: Rename cpg_mssr_priv.mstp_lock
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spinlock is used to protect Read-Modify-Write register accesses,
which won't be limited to SMSTPCR register accesses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index eb8534e5ebf3007d..f1161a585c57e433 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -98,7 +98,7 @@
  *
  * @dev: CPG/MSSR device
  * @base: CPG/MSSR register block base address
- * @mstp_lock: protects writes to SMSTPCR
+ * @rmw_lock: protects RMW register accesses
  * @clks: Array containing all Core and Module Clocks
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
@@ -107,7 +107,7 @@
 struct cpg_mssr_priv {
 	struct device *dev;
 	void __iomem *base;
-	spinlock_t mstp_lock;
+	spinlock_t rmw_lock;
 
 	struct clk **clks;
 	unsigned int num_core_clks;
@@ -144,7 +144,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 
 	dev_dbg(dev, "MSTP %u%02u/%pC %s\n", reg, bit, hw->clk,
 		enable ? "ON" : "OFF");
-	spin_lock_irqsave(&priv->mstp_lock, flags);
+	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	value = readl(priv->base + SMSTPCR(reg));
 	if (enable)
@@ -153,7 +153,7 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 		value |= bitmask;
 	writel(value, priv->base + SMSTPCR(reg));
 
-	spin_unlock_irqrestore(&priv->mstp_lock, flags);
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (!enable)
 		return 0;
@@ -550,7 +550,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	spin_lock_init(&priv->mstp_lock);
+	spin_lock_init(&priv->rmw_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(dev, res);
-- 
1.9.1
