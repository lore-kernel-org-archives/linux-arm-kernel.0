From: markz@nvidia.com (Mark Zhang)
Date: Wed, 7 Aug 2013 19:25:07 +0800
Subject: [PATCH 3/5] clk: tegra: Fix vde/2d/3d clock src offset
In-Reply-To: <1375874709-10438-1-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
Message-ID: <1375874709-10438-3-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra114, vde/gr_2d/gr_3d have 3 bits for clock source selection.
So change the clock init macro for these clocks from
"TEGRA_INIT_DATA_INT" to "TEGRA_INIT_DATA_INT8".

Besides, no one uses "TEGRA_INIT_DATA_INT" after this change, so
remove this macro.

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 7172faf..a45ea68 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -806,13 +806,6 @@ static unsigned long tegra114_input_freq[] = {
 			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
 			_parents##_idx, 0)
 
-#define TEGRA_INIT_DATA_INT(_name, _con_id, _dev_id, _parents, _offset,	\
-			    _clk_num, _regs, _gate_flags, _clk_id)	\
-	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 8, 1, TEGRA_DIVIDER_INT, _regs,\
-			_clk_num, periph_clk_enb_refcnt, _gate_flags,	\
-			_clk_id, _parents##_idx, 0)
-
 #define TEGRA_INIT_DATA_INT_FLAGS(_name, _con_id, _dev_id, _parents, _offset,\
 			    _clk_num, _regs, _gate_flags, _clk_id, flags)\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
@@ -1857,7 +1850,7 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_MUX("sdmmc2", NULL, "sdhci-tegra.1", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC2, 9, &periph_l_regs, 0, sdmmc2),
 	TEGRA_INIT_DATA_MUX("sdmmc3", NULL, "sdhci-tegra.2", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC3, 69, &periph_u_regs, 0, sdmmc3),
 	TEGRA_INIT_DATA_MUX("sdmmc4", NULL, "sdhci-tegra.3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC4, 15, &periph_l_regs, 0, sdmmc4),
-	TEGRA_INIT_DATA_INT("vde", NULL, "vde", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, &periph_h_regs, 0, vde),
+	TEGRA_INIT_DATA_INT8("vde", NULL, "vde", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, &periph_h_regs, 0, vde),
 	TEGRA_INIT_DATA_MUX_FLAGS("csite", NULL, "csite", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_CSITE, 73, &periph_u_regs, TEGRA_PERIPH_ON_APB, csite, CLK_IGNORE_UNUSED),
 	TEGRA_INIT_DATA_MUX("la", NULL, "la", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_LA, 76, &periph_u_regs, TEGRA_PERIPH_ON_APB, la),
 	TEGRA_INIT_DATA_MUX("trace", NULL, "trace", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_TRACE, 77, &periph_u_regs, TEGRA_PERIPH_ON_APB, trace),
@@ -1873,8 +1866,8 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_UART("uartb", NULL, "tegra_uart.1", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTB, 7, &periph_l_regs, uartb),
 	TEGRA_INIT_DATA_UART("uartc", NULL, "tegra_uart.2", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTC, 55, &periph_h_regs, uartc),
 	TEGRA_INIT_DATA_UART("uartd", NULL, "tegra_uart.3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTD, 65, &periph_u_regs, uartd),
-	TEGRA_INIT_DATA_INT("3d", NULL, "3d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_3D, 24, &periph_l_regs, 0, gr_3d),
-	TEGRA_INIT_DATA_INT("2d", NULL, "2d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_2D, 21, &periph_l_regs, 0, gr_2d),
+	TEGRA_INIT_DATA_INT8("3d", NULL, "3d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_3D, 24, &periph_l_regs, 0, gr_3d),
+	TEGRA_INIT_DATA_INT8("2d", NULL, "2d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_2D, 21, &periph_l_regs, 0, gr_2d),
 	TEGRA_INIT_DATA_MUX("vi_sensor", "vi_sensor", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 20, &periph_l_regs, TEGRA_PERIPH_NO_RESET, vi_sensor),
 	TEGRA_INIT_DATA_INT8("vi", "vi", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, &periph_l_regs, 0, vi),
 	TEGRA_INIT_DATA_INT8("epp", NULL, "epp", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_EPP, 19, &periph_l_regs, 0, epp),
-- 
1.7.9.5
