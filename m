From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Sep 2015 13:51:35 +0530
Subject: [PATCH v10 1/4] clk: clk-vf610: Add clock for Vybrid OCOTP controller
In-Reply-To: <cover.1441609625.git.maitysanchayan@gmail.com>
References: <cover.1441609625.git.maitysanchayan@gmail.com>
Message-ID: <ca85ab571ba312ea75a4d33543e5dbb8745e7190.1441609625.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support for Vybrid On-Chip One Time Programmable
(OCOTP) controller.

While the OCOTP block does not require explicit clock gating,
for programming the OCOTP timing register the clock rate of
ipg clock is required for timing calculations related to fuse
and shadow register read sequence. We explicitly specify the
ipg clock for OCOTP as a result.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/clk/imx/clk-vf610.c             | 1 +
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index bff45ea..d1b1c95 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -387,6 +387,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 
 	clk[VF610_CLK_SNVS] = imx_clk_gate2("snvs-rtc", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(7));
 	clk[VF610_CLK_DAP] = imx_clk_gate("dap", "platform_bus", CCM_CCSR, 24);
+	clk[VF610_CLK_OCOTP] = imx_clk_gate("ocotp", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(5));
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index d197634..56c16aa 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -194,6 +194,7 @@
 #define VF610_PLL7_BYPASS		181
 #define VF610_CLK_SNVS			182
 #define VF610_CLK_DAP			183
-#define VF610_CLK_END			184
+#define VF610_CLK_OCOTP         184
+#define VF610_CLK_END			185
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.5.1
