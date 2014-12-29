From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 29 Dec 2014 14:39:15 +0800
Subject: [PATCH RFC v6 08/21] ARM: imx6q: clk: Add support for mipi_core_cfg
 clock as a shared clock gate
In-Reply-To: <1419835168-9034-1-git-send-email-Ying.Liu@freescale.com>
References: <1419835168-9034-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419835168-9034-9-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CG8 field of the CCM CCGR3 register is named as 'mipi_core_cfg' clock,
according to the i.MX6q/sdl reference manuals.  This clock is actually the
gate for several clocks, including the hsi_tx_sel clock's output and the
video_27m clock's output.  The MIPI DSI host controller embedded in the
i.MX6q/sdl SoCs uses the video_27m clock to generate PLL reference clock and
MIPI core configuration clock.  In order to gate/ungate the two MIPI DSI
host controller relevant clocks, this patch adds the mipi_core_cfg clock as
a shared clock gate.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v5->v6:
 * Add two spaces in the clock driver to eliminate two errors reported by
   the checkpatch.pl script.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * Newly introduced in v3.

 arch/arm/mach-imx/clk-imx6q.c             | 1 +
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 080d5b7..0f4d07c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -418,6 +418,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_LDB_DI1]      = imx_clk_gate2("ldb_di1",       "ldb_di1_podf",      base + 0x74, 14);
 	clk[IMX6QDL_CLK_IPU2_DI1]     = imx_clk_gate2("ipu2_di1",      "ipu2_di1_sel",      base + 0x74, 10);
 	clk[IMX6QDL_CLK_HSI_TX]       = imx_clk_gate2_shared("hsi_tx", "hsi_tx_podf",       base + 0x74, 16, &share_count_mipi_core_cfg);
+	clk[IMX6QDL_CLK_MIPI_CORE_CFG] = imx_clk_gate2_shared("mipi_core_cfg", "video_27m", base + 0x74, 16, &share_count_mipi_core_cfg);
 	if (cpu_is_imx6dl())
 		/*
 		 * The multiplexer and divider of the imx6q clock gpu2d get
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 25625bf..dbc828c 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -249,6 +249,7 @@
 #define IMX6QDL_PLL7_BYPASS			236
 #define IMX6QDL_CLK_GPT_3M			237
 #define IMX6QDL_CLK_VIDEO_27M			238
-#define IMX6QDL_CLK_END				239
+#define IMX6QDL_CLK_MIPI_CORE_CFG		239
+#define IMX6QDL_CLK_END				240
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.1.0
