From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 22:15:21 +0100
Subject: [PATCH v2 2/2] ARM i.MX5: set CAN peripheral clock to 24 MHz parent
In-Reply-To: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1385414121-21493-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the parent of CAN peripheral clock (a.k.a. CPI clock) to the
lp_apm clock, which has a rate of 24 MHz.

In the CAN world a base clock with multiple of 8 MHz is suited best for all CIA
recommented bit rates. Without this patch the CAN peripheral clock on i.MX53
has a rate of 66.666 MHz which produces quite large bit rate errors.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index e349fd5..dff5ca9 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -584,6 +584,9 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
 
+	/* move can bus clk to 24MHz */
+	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
+
 	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
 	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
-- 
1.8.4.2
