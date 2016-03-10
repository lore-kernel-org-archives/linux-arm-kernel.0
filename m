From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:48 -0800
Subject: [PATCH 07/18] ARM: imx: clk-vf610: leave DDR clock on
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-8-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use STOP mode without putting DDR3 into self-refresh mode, we
need to keep the DDR clock enabled. Use the new gate configuration
with a value of 2 to make sure that the clock is enabled in RUN,
WAIT and STOP mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c             | 3 +++
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 0a94d96..f0ff458 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -119,6 +119,7 @@ static unsigned int const clks_init_on[] __initconst = {
 	VF610_CLK_SYS_BUS,
 	VF610_CLK_DDR_SEL,
 	VF610_CLK_DAP,
+	VF610_CLK_DDRMC,
 };
 
 static struct clk * __init vf610_get_fixed_clock(
@@ -233,6 +234,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_PLL4_MAIN_DIV] = clk_register_divider_table(NULL, "pll4_audio_div", "pll4_audio", 0, CCM_CACRR, 6, 3, 0, pll4_audio_div_table, &imx_ccm_lock);
 	clk[VF610_CLK_PLL6_MAIN_DIV] = imx_clk_divider("pll6_video_div", "pll6_video", CCM_CACRR, 21, 1);
 
+	clk[VF610_CLK_DDRMC] = imx_clk_gate2_cgr("ddrmc", "ddr_sel", CCM_CCGR6, CCM_CCGRx_CGn(14), 0x2);
+
 	clk[VF610_CLK_USBPHY0] = imx_clk_gate("usbphy0", "pll3_usb_otg", PLL3_CTRL, 6);
 	clk[VF610_CLK_USBPHY1] = imx_clk_gate("usbphy1", "pll7_usb_host", PLL7_CTRL, 6);
 
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 56c16aa..cf2c00a 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -195,6 +195,7 @@
 #define VF610_CLK_SNVS			182
 #define VF610_CLK_DAP			183
 #define VF610_CLK_OCOTP         184
-#define VF610_CLK_END			185
+#define VF610_CLK_DDRMC			185
+#define VF610_CLK_END			186
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.7.2
