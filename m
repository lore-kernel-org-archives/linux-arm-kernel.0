From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  2 Jul 2012 11:30:34 +0200
Subject: [PATCH] ARM: imx: assert SCC gate stays enabled
Message-ID: <1341221434-15233-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCC clock is needed in internal boot mode and so must keep enabled.
This same issue was fixed for the pre-common-clk code in commit

	3d6e614 (mx35: Fix boot ROM hang in internal boot mode)

Cc: John Ogness <jogness@linutronix.de>
Cc: Hans J. Koch <hjk@hansjkoch.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx35.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 920a8cc..c6422fb 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -201,7 +201,6 @@ int __init mx35_clocks_init()
 			pr_err("i.MX35 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
-
 	clk_register_clkdev(clk[pata_gate], NULL, "pata_imx");
 	clk_register_clkdev(clk[can1_gate], NULL, "flexcan.0");
 	clk_register_clkdev(clk[can2_gate], NULL, "flexcan.1");
@@ -264,6 +263,14 @@ int __init mx35_clocks_init()
 	clk_prepare_enable(clk[iim_gate]);
 	clk_prepare_enable(clk[emi_gate]);
 
+	/*
+	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
+	 * before conversion to common clk also enabled UART1 (which isn't
+	 * handled here and not needed for mmc) and IIM (which is enabled
+	 * unconditionally above).
+	 */
+	clk_prepare_enable(clk[scc_gate]);
+
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
 #ifdef CONFIG_MXC_USE_EPIT
-- 
1.7.10
