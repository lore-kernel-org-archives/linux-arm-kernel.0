From: stefan@agner.ch (Stefan Agner)
Date: Mon, 18 May 2015 00:13:33 +0200
Subject: [PATCH] ARM: imx: clk-vf610: enable debug access port by default
Message-ID: <1431900813-5466-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabled DAP (debug access port) by default. This enables the hw-
breakpoint framework to make use of the breakpoints and watchpoints
supported by hardware.

[    0.215805] hw-breakpoint: found 2 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.224624] hw-breakpoint: maximum watchpoint size is 4 bytes.

Without this clock, the hw-breakpoint driver claims an undefined
instruction during initialization:
[    0.227380] hw-breakpoint: Debug register access (0xee003e17) caused undefined instruction on CPU 0
[    0.227519] hw-breakpoint: CPU 0 failed to disable vector catch

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c             | 2 ++
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 61876ed..1c2d324 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -118,6 +118,7 @@ static struct clk_onecell_data clk_data;
 static unsigned int const clks_init_on[] __initconst = {
 	VF610_CLK_SYS_BUS,
 	VF610_CLK_DDR_SEL,
+	VF610_CLK_DAP,
 };
 
 static struct clk * __init vf610_get_fixed_clock(
@@ -383,6 +384,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DMAMUX3] = imx_clk_gate2("dmamux3", "platform_bus", CCM_CCGR6, CCM_CCGRx_CGn(2));
 
 	clk[VF610_CLK_SNVS] = imx_clk_gate2("snvs-rtc", "ipg_bus", CCM_CCGR6, CCM_CCGRx_CGn(7));
+	clk[VF610_CLK_DAP] = imx_clk_gate("dap", "platform_bus", CCM_CCSR, 24);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 979d24a..d197634 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -193,6 +193,7 @@
 #define VF610_PLL6_BYPASS		180
 #define VF610_PLL7_BYPASS		181
 #define VF610_CLK_SNVS			182
-#define VF610_CLK_END			183
+#define VF610_CLK_DAP			183
+#define VF610_CLK_END			184
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.4.1
