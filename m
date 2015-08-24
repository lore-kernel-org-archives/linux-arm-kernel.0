From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 24 Aug 2015 16:12:26 +0800
Subject: [PATCH] clk: rockchip: disable init state before mmc card
 initialization
Message-ID: <1440403946-13266-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc host controller's IO input/output timing is unpredictable if
bootloader execute tuning for HS200 mode. It might make kernel failed
to initialize mmc card in identification mode. The root cause is
tuning phase and degree setting for HS200 mode in bootloader aren't
applicable to that of identification mode in kernel stage. Anyway, we
can't force all bootloaders to disable tuning phase and degree setting
before into kernel. Simply disable it in rockchip_clk_register_mmc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/clk/rockchip/clk-mmc-phase.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index e9f8df32..02b6f3d 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -38,6 +38,9 @@ static unsigned long rockchip_mmc_recalc(struct clk_hw *hw,
 #define ROCKCHIP_MMC_DEGREE_MASK 0x3
 #define ROCKCHIP_MMC_DELAYNUM_OFFSET 2
 #define ROCKCHIP_MMC_DELAYNUM_MASK (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
+#define ROCKCHIP_MMC_INIT_STATE_DISABLE (0x1)
+#define ROCKCHIP_MMC_INIT_STATE_SHIFT (0)
+#define ROCKCHIP_MMC_INIT_STATE_MASK  (0x1)
 
 #define PSECS_PER_SEC 1000000000000LL
 
@@ -119,6 +122,21 @@ static const struct clk_ops rockchip_mmc_clk_ops = {
 	.set_phase	= rockchip_mmc_set_phase,
 };
 
+static void rockchip_clk_mmc_disable_init(struct rockchip_mmc_clock *mmc_clock)
+{
+	if (mmc_clock->shift != ROCKCHIP_MMC_INIT_STATE_SHIFT)
+		return;
+
+	writel(HIWORD_UPDATE(ROCKCHIP_MMC_INIT_STATE_DISABLE,
+			     ROCKCHIP_MMC_INIT_STATE_MASK,
+			     mmc_clock->shift),
+	       mmc_clock->reg);
+
+	pr_debug("%s: clear mmc init state to %d", __func__,
+		 (readl(mmc_clock->reg) >> (mmc_clock->shift)) &
+		 ROCKCHIP_MMC_INIT_STATE_MASK);
+}
+
 struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift)
@@ -139,6 +157,8 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 	mmc_clock->reg = reg;
 	mmc_clock->shift = shift;
 
+	rockchip_clk_mmc_disable_init(mmc_clock);
+
 	if (name)
 		init.name = name;
 
-- 
2.3.7
