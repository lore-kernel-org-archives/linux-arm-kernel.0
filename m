From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  6 Jan 2015 16:47:43 +0100
Subject: [PATCH 1/3] ARM: imx6: Mask mmdc_ch1 handshake for periph2_sel and
 mmdc_ch1_axi_podf
Message-ID: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMDC CH1 is not used on i.MX6Q, so the handshake needed to change the parent
of periph2_sel or the divider of mmdc_ch1_axi_podf will never succeed.
Disable the handshake mechanism to allow changing the frequency of mmdc_ch1_axi,
allowing to use it as a possible source for the LDB DI clock.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5951660..f2e7cfc 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -120,6 +120,19 @@ static unsigned int share_count_ssi1;
 static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 
+#define CCM_CCDR		0x04
+
+#define CCDR_MMDC_CH1_MASK	BIT(16)
+
+static void __init imx6q_mmdc_ch1_mask_handshake(void __iomem *ccm_base)
+{
+	unsigned int reg;
+
+	reg = readl_relaxed(ccm_base + CCM_CCDR);
+	reg |= CCDR_MMDC_CH1_MASK;
+	writel_relaxed(reg, ccm_base + CCM_CCDR);
+}
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -261,6 +274,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 
 	imx6q_pm_set_ccm_base(base);
+	imx6q_mmdc_ch1_mask_handshake(base);
 
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clk[IMX6QDL_CLK_STEP]             = imx_clk_mux("step",	            base + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
-- 
2.1.4
