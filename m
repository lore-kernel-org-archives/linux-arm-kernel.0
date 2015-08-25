From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 25 Aug 2015 08:34:36 +0800
Subject: [PATCH v2] clk: rockchip: reset init state before mmc card
 initialization
Message-ID: <1440462876-5457-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc host controller's IO input/output timing is unpredictable if
bootloader execute tuning for HS200 mode. It might make kernel failed
to initialize mmc card in identification mode. The root cause is
tuning phase and degree setting for HS200 mode in bootloader aren't
applicable to that of identification mode in kernel stage. Anyway, we
can't force all bootloaders to reset tuning phase and degree setting
before into kernel. Simply reset it in rockchip_clk_register_mmc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rename to rockchip_clk_mmc_reset
- simplifying the code

 drivers/clk/rockchip/clk-mmc-phase.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index e9f8df32..1d3e8fe6 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -38,6 +38,8 @@ static unsigned long rockchip_mmc_recalc(struct clk_hw *hw,
 #define ROCKCHIP_MMC_DEGREE_MASK 0x3
 #define ROCKCHIP_MMC_DELAYNUM_OFFSET 2
 #define ROCKCHIP_MMC_DELAYNUM_MASK (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
+#define ROCKCHIP_MMC_INIT_STATE_RESET 0x1
+#define ROCKCHIP_MMC_INIT_STATE_SHIFT 1
 
 #define PSECS_PER_SEC 1000000000000LL
 
@@ -119,6 +121,14 @@ static const struct clk_ops rockchip_mmc_clk_ops = {
 	.set_phase	= rockchip_mmc_set_phase,
 };
 
+static void rockchip_clk_mmc_reset(struct rockchip_mmc_clock *mmc_clock)
+{
+	if (mmc_clock->shift == ROCKCHIP_MMC_INIT_STATE_SHIFT)
+		writel(HIWORD_UPDATE(ROCKCHIP_MMC_INIT_STATE_RESET,
+				     ROCKCHIP_MMC_INIT_STATE_RESET,
+				     mmc_clock->shift), mmc_clock->reg);
+}
+
 struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift)
@@ -139,6 +149,12 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 	mmc_clock->reg = reg;
 	mmc_clock->shift = shift;
 
+	/*
+	* Assert init_state to soft reset the CLKGEN
+	* for mmc tuning phase and degree
+	*/
+	rockchip_clk_mmc_reset(mmc_clock);
+
 	if (name)
 		init.name = name;
 
-- 
2.3.7
