From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:23 +0800
Subject: [PATCH 04/11] clk: sunxi-ng: Support separately grouped PLL lock
 status register
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Allwinner A80 SoC, the PLL lock status indicators are grouped
together in a separate register, as opposed to being scattered in each
PLL's configuration register.

Add a flag to support this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 8 ++++++--
 drivers/clk/sunxi-ng/ccu_common.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 51d4bac97ab3..3fd0c3331aff 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -25,13 +25,17 @@ static DEFINE_SPINLOCK(ccu_lock);
 
 void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
 {
+	void __iomem *addr;
 	u32 reg;
 
 	if (!lock)
 		return;
 
-	WARN_ON(readl_relaxed_poll_timeout(common->base + common->reg, reg,
-					   reg & lock, 100, 70000));
+	addr = common->base + common->reg;
+	if (common->features & CCU_FEATURE_LOCK_REG)
+		addr = common->base + common->lock_reg;
+
+	WARN_ON(readl_relaxed_poll_timeout(addr, reg, reg & lock, 100, 70000));
 }
 
 int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index cdd69eb2e0b9..73d81dc58fc5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -22,6 +22,7 @@
 #define CCU_FEATURE_FIXED_PREDIV	BIT(2)
 #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
 #define CCU_FEATURE_ALL_PREDIV		BIT(4)
+#define CCU_FEATURE_LOCK_REG		BIT(5)
 
 struct device_node;
 
@@ -57,6 +58,7 @@ struct device_node;
 struct ccu_common {
 	void __iomem	*base;
 	u16		reg;
+	u16		lock_reg;
 	u32		prediv;
 
 	unsigned long	features;
-- 
2.11.0
