From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Mar 2016 18:59:56 -0700
Subject: [PATCH v2 2/8] ARM: imx: clk-vf610: add TCON ipg clock
In-Reply-To: <1459216802-32094-1-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
Message-ID: <1459216802-32094-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ipg (bus) clock for the TCON modules (Timing Controller). This
module is required by the new DCU DRM driver, since the display signals
pass through TCON.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c             | 3 +++
 include/dt-bindings/clock/vf610-clock.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 426fde2..43be1cf 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -327,6 +327,9 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DCU1_DIV] = imx_clk_divider("dcu1_div", "dcu1_en", CCM_CSCDR3, 20, 3);
 	clk[VF610_CLK_DCU1] = imx_clk_gate2("dcu1", "ipg_bus", CCM_CCGR9, CCM_CCGRx_CGn(8));
 
+	clk[VF610_CLK_TCON0] = imx_clk_gate2("tcon0", "platform_bus", CCM_CCGR1, CCM_CCGRx_CGn(13));
+	clk[VF610_CLK_TCON1] = imx_clk_gate2("tcon1", "platform_bus", CCM_CCGR7, CCM_CCGRx_CGn(13));
+
 	clk[VF610_CLK_ESAI_SEL] = imx_clk_mux("esai_sel", CCM_CSCMR1, 20, 2, esai_sels, 4);
 	clk[VF610_CLK_ESAI_EN] = imx_clk_gate("esai_en", "esai_sel", CCM_CSCDR2, 30);
 	clk[VF610_CLK_ESAI_DIV] = imx_clk_divider("esai_div", "esai_en", CCM_CSCDR2, 24, 4);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 56c16aa..fbe17cc 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -195,6 +195,8 @@
 #define VF610_CLK_SNVS			182
 #define VF610_CLK_DAP			183
 #define VF610_CLK_OCOTP         184
-#define VF610_CLK_END			185
+#define VF610_CLK_TCON0			185
+#define VF610_CLK_TCON1			186
+#define VF610_CLK_END			187
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.7.4
