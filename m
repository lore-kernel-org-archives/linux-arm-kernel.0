From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 11 Dec 2017 14:48:51 +0800
Subject: [PATCH v6 4/6] clk: meson: make the spinlock naming more specific
In-Reply-To: <20171211064853.32111-1-yixun.lan@amlogic.com>
References: <20171211064853.32111-1-yixun.lan@amlogic.com>
Message-ID: <20171211064853.32111-5-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the spinlock more specific, so better for lockdep
debugging and ctags/grep.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---

this patch try to address the issue which bring up by Stephen at [1]
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005534.html
---
 drivers/clk/meson/axg.c     |  34 +++++++-------
 drivers/clk/meson/clkc.h    |   2 +-
 drivers/clk/meson/gxbb.c    | 112 ++++++++++++++++++++++----------------------
 drivers/clk/meson/meson8b.c |  24 +++++-----
 4 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index cba75409f929..8d8758089472 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -19,7 +19,7 @@
 #include "clkc.h"
 #include "axg.h"
 
-static DEFINE_SPINLOCK(clk_lock);
+static DEFINE_SPINLOCK(meson_clk_lock);
 
 static const struct pll_rate_table sys_pll_rate_table[] = {
 	PLL_RATE(24000000, 56, 1, 2),
@@ -129,7 +129,7 @@ static struct meson_clk_pll axg_fixed_pll = {
 		.shift   = 16,
 		.width   = 2,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -157,7 +157,7 @@ static struct meson_clk_pll axg_sys_pll = {
 	},
 	.rate_table = sys_pll_rate_table,
 	.rate_count = ARRAY_SIZE(sys_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -291,7 +291,7 @@ static struct meson_clk_pll axg_gp0_pll = {
 	},
 	.rate_table = axg_gp0_pll_rate_table,
 	.rate_count = ARRAY_SIZE(axg_gp0_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -383,7 +383,7 @@ static struct meson_clk_mpll axg_mpll0 = {
 		.shift   = 25,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -413,7 +413,7 @@ static struct meson_clk_mpll axg_mpll1 = {
 		.shift   = 14,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -443,7 +443,7 @@ static struct meson_clk_mpll axg_mpll2 = {
 		.shift   = 14,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -473,7 +473,7 @@ static struct meson_clk_mpll axg_mpll3 = {
 		.shift   = 0,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3",
 		.ops = &meson_clk_mpll_ops,
@@ -499,7 +499,7 @@ static struct clk_mux axg_mpeg_clk_sel = {
 	.shift = 12,
 	.flags = CLK_MUX_READ_ONLY,
 	.table = mux_table_clk81,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
 		.ops = &clk_mux_ro_ops,
@@ -518,7 +518,7 @@ static struct clk_divider axg_mpeg_clk_div = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
 		.ops = &clk_divider_ops,
@@ -531,7 +531,7 @@ static struct clk_divider axg_mpeg_clk_div = {
 static struct clk_gate axg_clk81 = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
 		.ops = &clk_gate_ops,
@@ -557,7 +557,7 @@ static struct clk_mux axg_sd_emmc_b_clk0_sel = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.mask = 0x7,
 	.shift = 25,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_sel",
 		.ops = &clk_mux_ops,
@@ -571,7 +571,7 @@ static struct clk_divider axg_sd_emmc_b_clk0_div = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.shift = 16,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_div",
@@ -585,7 +585,7 @@ static struct clk_divider axg_sd_emmc_b_clk0_div = {
 static struct clk_gate axg_sd_emmc_b_clk0 = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.bit_idx = 23,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_b_clk0",
 		.ops = &clk_gate_ops,
@@ -600,7 +600,7 @@ static struct clk_mux axg_sd_emmc_c_clk0_sel = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.mask = 0x7,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_sel",
 		.ops = &clk_mux_ops,
@@ -614,7 +614,7 @@ static struct clk_divider axg_sd_emmc_c_clk0_div = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_div",
@@ -628,7 +628,7 @@ static struct clk_divider axg_sd_emmc_c_clk0_div = {
 static struct clk_gate axg_sd_emmc_c_clk0 = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_c_clk0",
 		.ops = &clk_gate_ops,
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 1629da9b4141..87f06a801a4d 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -134,7 +134,7 @@ struct meson_clk_audio_divider {
 struct clk_gate _name = { 						\
 	.reg = (void __iomem *) _reg, 					\
 	.bit_idx = (_bit), 						\
-	.lock = &clk_lock,						\
+	.lock = &meson_clk_lock,						\
 	.hw.init = &(struct clk_init_data) { 				\
 		.name = #_name,					\
 		.ops = &clk_gate_ops,					\
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ae385310e980..48936fbe7fd0 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -27,7 +27,7 @@
 #include "clkc.h"
 #include "gxbb.h"
 
-static DEFINE_SPINLOCK(clk_lock);
+static DEFINE_SPINLOCK(meson_clk_lock);
 
 static const struct pll_rate_table sys_pll_rate_table[] = {
 	PLL_RATE(24000000, 56, 1, 2),
@@ -294,7 +294,7 @@ static struct meson_clk_pll gxbb_fixed_pll = {
 		.shift   = 16,
 		.width   = 2,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -330,7 +330,7 @@ static struct meson_clk_pll gxbb_hdmi_pll = {
 		.shift   = 22,
 		.width   = 2,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -358,7 +358,7 @@ static struct meson_clk_pll gxbb_sys_pll = {
 	},
 	.rate_table = sys_pll_rate_table,
 	.rate_count = ARRAY_SIZE(sys_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -399,7 +399,7 @@ static struct meson_clk_pll gxbb_gp0_pll = {
 	},
 	.rate_table = gxbb_gp0_pll_rate_table,
 	.rate_count = ARRAY_SIZE(gxbb_gp0_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -442,7 +442,7 @@ static struct meson_clk_pll gxl_gp0_pll = {
 	},
 	.rate_table = gxl_gp0_pll_rate_table,
 	.rate_count = ARRAY_SIZE(gxl_gp0_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -533,7 +533,7 @@ static struct meson_clk_mpll gxbb_mpll0 = {
 		.shift   = 25,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -563,7 +563,7 @@ static struct meson_clk_mpll gxbb_mpll1 = {
 		.shift   = 14,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -593,7 +593,7 @@ static struct meson_clk_mpll gxbb_mpll2 = {
 		.shift   = 14,
 		.width	 = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -620,7 +620,7 @@ static struct clk_mux gxbb_mpeg_clk_sel = {
 	.shift = 12,
 	.flags = CLK_MUX_READ_ONLY,
 	.table = mux_table_clk81,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
 		.ops = &clk_mux_ro_ops,
@@ -639,7 +639,7 @@ static struct clk_divider gxbb_mpeg_clk_div = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
 		.ops = &clk_divider_ops,
@@ -653,7 +653,7 @@ static struct clk_divider gxbb_mpeg_clk_div = {
 static struct clk_gate gxbb_clk81 = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
 		.ops = &clk_gate_ops,
@@ -667,7 +667,7 @@ static struct clk_mux gxbb_sar_adc_clk_sel = {
 	.reg = (void *)HHI_SAR_CLK_CNTL,
 	.mask = 0x3,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk_sel",
 		.ops = &clk_mux_ops,
@@ -681,7 +681,7 @@ static struct clk_divider gxbb_sar_adc_clk_div = {
 	.reg = (void *)HHI_SAR_CLK_CNTL,
 	.shift = 0,
 	.width = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk_div",
 		.ops = &clk_divider_ops,
@@ -693,7 +693,7 @@ static struct clk_divider gxbb_sar_adc_clk_div = {
 static struct clk_gate gxbb_sar_adc_clk = {
 	.reg = (void *)HHI_SAR_CLK_CNTL,
 	.bit_idx = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk",
 		.ops = &clk_gate_ops,
@@ -719,7 +719,7 @@ static struct clk_mux gxbb_mali_0_sel = {
 	.mask = 0x7,
 	.shift = 9,
 	.table = mux_table_mali_0_1,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_sel",
 		.ops = &clk_mux_ops,
@@ -738,7 +738,7 @@ static struct clk_divider gxbb_mali_0_div = {
 	.reg = (void *)HHI_MALI_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_div",
 		.ops = &clk_divider_ops,
@@ -751,7 +751,7 @@ static struct clk_divider gxbb_mali_0_div = {
 static struct clk_gate gxbb_mali_0 = {
 	.reg = (void *)HHI_MALI_CLK_CNTL,
 	.bit_idx = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0",
 		.ops = &clk_gate_ops,
@@ -766,7 +766,7 @@ static struct clk_mux gxbb_mali_1_sel = {
 	.mask = 0x7,
 	.shift = 25,
 	.table = mux_table_mali_0_1,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_sel",
 		.ops = &clk_mux_ops,
@@ -785,7 +785,7 @@ static struct clk_divider gxbb_mali_1_div = {
 	.reg = (void *)HHI_MALI_CLK_CNTL,
 	.shift = 16,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_div",
 		.ops = &clk_divider_ops,
@@ -798,7 +798,7 @@ static struct clk_divider gxbb_mali_1_div = {
 static struct clk_gate gxbb_mali_1 = {
 	.reg = (void *)HHI_MALI_CLK_CNTL,
 	.bit_idx = 24,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1",
 		.ops = &clk_gate_ops,
@@ -818,7 +818,7 @@ static struct clk_mux gxbb_mali = {
 	.mask = 1,
 	.shift = 31,
 	.table = mux_table_mali,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mali",
 		.ops = &clk_mux_ops,
@@ -834,7 +834,7 @@ static struct clk_mux gxbb_cts_amclk_sel = {
 	.shift = 9,
 	/* Default parent unknown (register reset value: 0) */
 	.table = (u32[]){ 1, 2, 3 },
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 		.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_sel",
 		.ops = &clk_mux_ops,
@@ -851,7 +851,7 @@ static struct meson_clk_audio_divider gxbb_cts_amclk_div = {
 		.width   = 8,
 	},
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_div",
 		.ops = &meson_clk_audio_divider_ops,
@@ -864,7 +864,7 @@ static struct meson_clk_audio_divider gxbb_cts_amclk_div = {
 static struct clk_gate gxbb_cts_amclk = {
 	.reg = (void *) HHI_AUD_CLK_CNTL,
 	.bit_idx = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk",
 		.ops = &clk_gate_ops,
@@ -880,7 +880,7 @@ static struct clk_mux gxbb_cts_mclk_i958_sel = {
 	.shift = 25,
 	/* Default parent unknown (register reset value: 0) */
 	.table = (u32[]){ 1, 2, 3 },
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_sel",
 		.ops = &clk_mux_ops,
@@ -894,7 +894,7 @@ static struct clk_divider gxbb_cts_mclk_i958_div = {
 	.reg = (void *)HHI_AUD_CLK_CNTL2,
 	.shift = 16,
 	.width = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_div",
@@ -908,7 +908,7 @@ static struct clk_divider gxbb_cts_mclk_i958_div = {
 static struct clk_gate gxbb_cts_mclk_i958 = {
 	.reg = (void *)HHI_AUD_CLK_CNTL2,
 	.bit_idx = 24,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_mclk_i958",
 		.ops = &clk_gate_ops,
@@ -922,7 +922,7 @@ static struct clk_mux gxbb_cts_i958 = {
 	.reg = (void *)HHI_AUD_CLK_CNTL2,
 	.mask = 0x1,
 	.shift = 27,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 		.hw.init = &(struct clk_init_data){
 		.name = "cts_i958",
 		.ops = &clk_mux_ops,
@@ -940,7 +940,7 @@ static struct clk_divider gxbb_32k_clk_div = {
 	.reg = (void *)HHI_32K_CLK_CNTL,
 	.shift = 0,
 	.width = 14,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_div",
 		.ops = &clk_divider_ops,
@@ -953,7 +953,7 @@ static struct clk_divider gxbb_32k_clk_div = {
 static struct clk_gate gxbb_32k_clk = {
 	.reg = (void *)HHI_32K_CLK_CNTL,
 	.bit_idx = 15,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk",
 		.ops = &clk_gate_ops,
@@ -971,7 +971,7 @@ static struct clk_mux gxbb_32k_clk_sel = {
 	.reg = (void *)HHI_32K_CLK_CNTL,
 	.mask = 0x3,
 	.shift = 16,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 		.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
 		.ops = &clk_mux_ops,
@@ -997,7 +997,7 @@ static struct clk_mux gxbb_sd_emmc_a_clk0_sel = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.mask = 0x7,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_a_clk0_sel",
 		.ops = &clk_mux_ops,
@@ -1011,7 +1011,7 @@ static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_a_clk0_div",
@@ -1025,7 +1025,7 @@ static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
 static struct clk_gate gxbb_sd_emmc_a_clk0 = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_a_clk0",
 		.ops = &clk_gate_ops,
@@ -1050,7 +1050,7 @@ static struct clk_mux gxbb_sd_emmc_b_clk0_sel = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.mask = 0x7,
 	.shift = 25,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_sel",
 		.ops = &clk_mux_ops,
@@ -1064,7 +1064,7 @@ static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.shift = 16,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_div",
@@ -1078,7 +1078,7 @@ static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
 static struct clk_gate gxbb_sd_emmc_b_clk0 = {
 	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
 	.bit_idx = 23,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_b_clk0",
 		.ops = &clk_gate_ops,
@@ -1093,7 +1093,7 @@ static struct clk_mux gxbb_sd_emmc_c_clk0_sel = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.mask = 0x7,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_sel",
 		.ops = &clk_mux_ops,
@@ -1107,7 +1107,7 @@ static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_div",
@@ -1121,7 +1121,7 @@ static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
 static struct clk_gate gxbb_sd_emmc_c_clk0 = {
 	.reg = (void *)HHI_NAND_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_c_clk0",
 		.ops = &clk_gate_ops,
@@ -1142,7 +1142,7 @@ static struct clk_mux gxbb_vpu_0_sel = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.mask = 0x3,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.table = mux_table_vpu,
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_0_sel",
@@ -1161,7 +1161,7 @@ static struct clk_divider gxbb_vpu_0_div = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_0_div",
 		.ops = &clk_divider_ops,
@@ -1174,7 +1174,7 @@ static struct clk_divider gxbb_vpu_0_div = {
 static struct clk_gate gxbb_vpu_0 = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.bit_idx = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "vpu_0",
 		.ops = &clk_gate_ops,
@@ -1188,7 +1188,7 @@ static struct clk_mux gxbb_vpu_1_sel = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.mask = 0x3,
 	.shift = 25,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.table = mux_table_vpu,
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_1_sel",
@@ -1207,7 +1207,7 @@ static struct clk_divider gxbb_vpu_1_div = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.shift = 16,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_1_div",
 		.ops = &clk_divider_ops,
@@ -1220,7 +1220,7 @@ static struct clk_divider gxbb_vpu_1_div = {
 static struct clk_gate gxbb_vpu_1 = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.bit_idx = 24,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "vpu_1",
 		.ops = &clk_gate_ops,
@@ -1234,7 +1234,7 @@ static struct clk_mux gxbb_vpu = {
 	.reg = (void *)HHI_VPU_CLK_CNTL,
 	.mask = 1,
 	.shift = 31,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu",
 		.ops = &clk_mux_ops,
@@ -1259,7 +1259,7 @@ static struct clk_mux gxbb_vapb_0_sel = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.mask = 0x3,
 	.shift = 9,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.table = mux_table_vapb,
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_0_sel",
@@ -1278,7 +1278,7 @@ static struct clk_divider gxbb_vapb_0_div = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_0_div",
 		.ops = &clk_divider_ops,
@@ -1291,7 +1291,7 @@ static struct clk_divider gxbb_vapb_0_div = {
 static struct clk_gate gxbb_vapb_0 = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.bit_idx = 8,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb_0",
 		.ops = &clk_gate_ops,
@@ -1305,7 +1305,7 @@ static struct clk_mux gxbb_vapb_1_sel = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.mask = 0x3,
 	.shift = 25,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.table = mux_table_vapb,
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_1_sel",
@@ -1324,7 +1324,7 @@ static struct clk_divider gxbb_vapb_1_div = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.shift = 16,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_1_div",
 		.ops = &clk_divider_ops,
@@ -1337,7 +1337,7 @@ static struct clk_divider gxbb_vapb_1_div = {
 static struct clk_gate gxbb_vapb_1 = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.bit_idx = 24,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb_1",
 		.ops = &clk_gate_ops,
@@ -1351,7 +1351,7 @@ static struct clk_mux gxbb_vapb_sel = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.mask = 1,
 	.shift = 31,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_sel",
 		.ops = &clk_mux_ops,
@@ -1368,7 +1368,7 @@ static struct clk_mux gxbb_vapb_sel = {
 static struct clk_gate gxbb_vapb = {
 	.reg = (void *)HHI_VAPBCLK_CNTL,
 	.bit_idx = 30,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb",
 		.ops = &clk_gate_ops,
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 20ab7190d328..3ffea80c1308 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -32,7 +32,7 @@
 #include "clkc.h"
 #include "meson8b.h"
 
-static DEFINE_SPINLOCK(clk_lock);
+static DEFINE_SPINLOCK(meson_clk_lock);
 
 static void __iomem *clk_base;
 
@@ -136,7 +136,7 @@ static struct meson_clk_pll meson8b_fixed_pll = {
 		.shift   = 16,
 		.width   = 2,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -162,7 +162,7 @@ static struct meson_clk_pll meson8b_vid_pll = {
 		.shift   = 16,
 		.width   = 2,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -190,7 +190,7 @@ static struct meson_clk_pll meson8b_sys_pll = {
 	},
 	.rate_table = sys_pll_rate_table,
 	.rate_count = ARRAY_SIZE(sys_pll_rate_table),
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ops,
@@ -281,7 +281,7 @@ static struct meson_clk_mpll meson8b_mpll0 = {
 		.shift   = 25,
 		.width   = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -311,7 +311,7 @@ static struct meson_clk_mpll meson8b_mpll1 = {
 		.shift   = 14,
 		.width   = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -341,7 +341,7 @@ static struct meson_clk_mpll meson8b_mpll2 = {
 		.shift   = 14,
 		.width   = 1,
 	},
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -375,7 +375,7 @@ struct clk_mux meson8b_mpeg_clk_sel = {
 	.shift = 12,
 	.flags = CLK_MUX_READ_ONLY,
 	.table = mux_table_clk81,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
 		.ops = &clk_mux_ro_ops,
@@ -395,7 +395,7 @@ struct clk_divider meson8b_mpeg_clk_div = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.shift = 0,
 	.width = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
 		.ops = &clk_divider_ops,
@@ -408,7 +408,7 @@ struct clk_divider meson8b_mpeg_clk_div = {
 struct clk_gate meson8b_clk81 = {
 	.reg = (void *)HHI_MPEG_CLK_CNTL,
 	.bit_idx = 7,
-	.lock = &clk_lock,
+	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
 		.ops = &clk_gate_ops,
@@ -773,7 +773,7 @@ static int meson8b_clk_reset_update(struct reset_controller_dev *rcdev,
 
 	reset = &meson8b_clk_reset_bits[id];
 
-	spin_lock_irqsave(&clk_lock, flags);
+	spin_lock_irqsave(&meson_clk_lock, flags);
 
 	val = readl(meson8b_clk_reset->base + reset->reg);
 	if (assert)
@@ -782,7 +782,7 @@ static int meson8b_clk_reset_update(struct reset_controller_dev *rcdev,
 		val &= ~BIT(reset->bit_idx);
 	writel(val, meson8b_clk_reset->base + reset->reg);
 
-	spin_unlock_irqrestore(&clk_lock, flags);
+	spin_unlock_irqrestore(&meson_clk_lock, flags);
 
 	return 0;
 }
-- 
2.15.1
