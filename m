From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:30 +0800
Subject: [PATCH RFC v9 07/20] ARM: imx6q: clk: Add support for mipi_ipg clock
 as a shared clock gate
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423720903-24806-8-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CG8 field of the CCM CCGR3 register is the 'mipi_core_cfg' gate clock,
according to the i.MX6q/sdl reference manuals.  This clock is actually the
gate for several clocks, including the ipg clock's output.  The MIPI DSI host
controller embedded in the i.MX6q/sdl SoCs takes the ipg clock as the pclk -
the APB clock signal .  In order to gate/ungate the ipg clock, this patch adds
a new shared clock gate named as "mipi_ipg".

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v8->v9:
 * Newly introduced in v9.

 arch/arm/mach-imx/clk-imx6q.c             | 1 +
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index cbdbe2a..909828d 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -419,6 +419,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_IPU2_DI1]     = imx_clk_gate2("ipu2_di1",      "ipu2_di1_sel",      base + 0x74, 10);
 	clk[IMX6QDL_CLK_HSI_TX]       = imx_clk_gate2_shared("hsi_tx", "hsi_tx_podf",       base + 0x74, 16, &share_count_mipi_core_cfg);
 	clk[IMX6QDL_CLK_MIPI_CORE_CFG] = imx_clk_gate2_shared("mipi_core_cfg", "video_27m", base + 0x74, 16, &share_count_mipi_core_cfg);
+	clk[IMX6QDL_CLK_MIPI_IPG]     = imx_clk_gate2_shared("mipi_ipg", "ipg",             base + 0x74, 16, &share_count_mipi_core_cfg);
 	if (cpu_is_imx6dl())
 		/*
 		 * The multiplexer and divider of the imx6q clock gpu2d get
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index dbc828c..8780868 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -250,6 +250,7 @@
 #define IMX6QDL_CLK_GPT_3M			237
 #define IMX6QDL_CLK_VIDEO_27M			238
 #define IMX6QDL_CLK_MIPI_CORE_CFG		239
-#define IMX6QDL_CLK_END				240
+#define IMX6QDL_CLK_MIPI_IPG			240
+#define IMX6QDL_CLK_END				241
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.1.0
