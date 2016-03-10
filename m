From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:50 -0800
Subject: [PATCH 09/18] ARM: vf610: clk: add suspend/resume support
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-10-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock register are lost when enterying LPSTOPx, hence provide
suspend/resume functions restoring them. The clock gates get
restored by the individual driver, hence we do not need to restore
them here.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 610a724..e2e2c43 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -10,6 +10,7 @@
 
 #include <linux/of_address.h>
 #include <linux/clk.h>
+#include <linux/syscore_ops.h>
 #include <dt-bindings/clock/vf610-clock.h>
 
 #include "clk.h"
@@ -40,6 +41,7 @@
 #define CCM_CCGR9		(ccm_base + 0x64)
 #define CCM_CCGR10		(ccm_base + 0x68)
 #define CCM_CCGR11		(ccm_base + 0x6c)
+#define CCM_CCGRx(x)		(CCM_CCGR0 + (x) * 4)
 #define CCM_CMEOR0		(ccm_base + 0x70)
 #define CCM_CMEOR1		(ccm_base + 0x74)
 #define CCM_CMEOR2		(ccm_base + 0x78)
@@ -115,6 +117,13 @@ static struct clk_div_table pll4_audio_div_table[] = {
 static struct clk *clk[VF610_CLK_END];
 static struct clk_onecell_data clk_data;
 
+static u32 cscmr1;
+static u32 cscmr2;
+static u32 cscdr1;
+static u32 cscdr2;
+static u32 cscdr3;
+static u32 ccgr[12];
+
 static unsigned int const clks_init_on[] __initconst = {
 	VF610_CLK_SYS_BUS,
 	VF610_CLK_DDR_SEL,
@@ -134,6 +143,43 @@ static struct clk * __init vf610_get_fixed_clock(
 	return clk;
 };
 
+static int vf610_clk_suspend(void)
+{
+	int i;
+
+	cscmr1 = readl_relaxed(CCM_CSCMR1);
+	cscmr2 = readl_relaxed(CCM_CSCMR2);
+
+	cscdr1 = readl_relaxed(CCM_CSCDR1);
+	cscdr2 = readl_relaxed(CCM_CSCDR2);
+	cscdr3 = readl_relaxed(CCM_CSCDR3);
+
+	for (i = 0; i < 12; i++)
+		ccgr[i] = readl_relaxed(CCM_CCGRx(i));
+
+	return 0;
+}
+
+static void vf610_clk_resume(void)
+{
+	int i;
+
+	writel_relaxed(cscmr1, CCM_CSCMR1);
+	writel_relaxed(cscmr2, CCM_CSCMR2);
+
+	writel_relaxed(cscdr1, CCM_CSCDR1);
+	writel_relaxed(cscdr2, CCM_CSCDR2);
+	writel_relaxed(cscdr3, CCM_CSCDR3);
+
+	for (i = 0; i < 12; i++)
+		writel_relaxed(ccgr[i], CCM_CCGRx(i));
+}
+
+static struct syscore_ops vf610_clk_syscore_ops = {
+	.suspend = vf610_clk_suspend,
+	.resume = vf610_clk_resume,
+};
+
 static void __init vf610_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -414,9 +460,12 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clk[clks_init_on[i]]);
 
+	register_syscore_ops(&vf610_clk_syscore_ops);
+
 	/* Add the clocks to provider list */
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
 CLK_OF_DECLARE(vf610, "fsl,vf610-ccm", vf610_clocks_init);
+
-- 
2.7.2
