From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 21:59:34 +0800
Subject: [PATCH 2/2] clk: mxs: remove the use of mach level IO accessor
In-Reply-To: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
References: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364306374-10481-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It removes the use of mach level IO accessor __mxs_setl/clrl, and hence
removes mach header inclusion from clock driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/mxs/clk-imx23.c |   11 +++++------
 drivers/clk/mxs/clk-imx28.c |   13 ++++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 0c8fda4..f6a7487 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <mach/mx23.h>
 #include "clk.h"
 
 static void __iomem *clkctrl;
@@ -52,10 +51,10 @@ static void __init clk_misc_init(void)
 	u32 val;
 
 	/* Gate off cpu clock in WFI for power saving */
-	__mxs_setl(1 << BP_CPU_INTERRUPT_WAIT, CPU);
+	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
 
 	/* Clear BYPASS for SAIF */
-	__mxs_clrl(1 << BP_CLKSEQ_BYPASS_SAIF, CLKSEQ);
+	writel_relaxed(1 << BP_CLKSEQ_BYPASS_SAIF, CLKSEQ + CLR);
 
 	/* SAIF has to use frac div for functional operation */
 	val = readl_relaxed(SAIF);
@@ -66,14 +65,14 @@ static void __init clk_misc_init(void)
 	 * Source ssp clock from ref_io than ref_xtal,
 	 * as ref_xtal only provides 24 MHz as maximum.
 	 */
-	__mxs_clrl(1 << BP_CLKSEQ_BYPASS_SSP, CLKSEQ);
+	writel_relaxed(1 << BP_CLKSEQ_BYPASS_SSP, CLKSEQ + CLR);
 
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac to get a 288 MHz ref_io.
 	 */
-	__mxs_clrl(0x3f << BP_FRAC_IOFRAC, FRAC);
-	__mxs_setl(30 << BP_FRAC_IOFRAC, FRAC);
+	writel_relaxed(0x3f << BP_FRAC_IOFRAC, FRAC + CLR);
+	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
 }
 
 static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index f623fdd..d0e5eed 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <mach/mx28.h>
 #include "clk.h"
 
 static void __iomem *clkctrl;
@@ -75,8 +74,8 @@ int mxs_saif_clkmux_select(unsigned int clkmux)
 	if (clkmux > 0x3)
 		return -EINVAL;
 
-	__mxs_clrl(0x3 << BP_SAIF_CLKMUX, DIGCTRL);
-	__mxs_setl(clkmux << BP_SAIF_CLKMUX, DIGCTRL);
+	writel_relaxed(0x3 << BP_SAIF_CLKMUX, DIGCTRL + CLR);
+	writel_relaxed(clkmux << BP_SAIF_CLKMUX, DIGCTRL + SET);
 
 	return 0;
 }
@@ -86,13 +85,13 @@ static void __init clk_misc_init(void)
 	u32 val;
 
 	/* Gate off cpu clock in WFI for power saving */
-	__mxs_setl(1 << BP_CPU_INTERRUPT_WAIT, CPU);
+	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
 
 	/* 0 is a bad default value for a divider */
-	__mxs_setl(1 << BP_ENET_DIV_TIME, ENET);
+	writel_relaxed(1 << BP_ENET_DIV_TIME, ENET + SET);
 
 	/* Clear BYPASS for SAIF */
-	__mxs_clrl(0x3 << BP_CLKSEQ_BYPASS_SAIF0, CLKSEQ);
+	writel_relaxed(0x3 << BP_CLKSEQ_BYPASS_SAIF0, CLKSEQ + CLR);
 
 	/* SAIF has to use frac div for functional operation */
 	val = readl_relaxed(SAIF0);
@@ -112,7 +111,7 @@ static void __init clk_misc_init(void)
 	 * Source ssp clock from ref_io than ref_xtal,
 	 * as ref_xtal only provides 24 MHz as maximum.
 	 */
-	__mxs_clrl(0xf << BP_CLKSEQ_BYPASS_SSP0, CLKSEQ);
+	writel_relaxed(0xf << BP_CLKSEQ_BYPASS_SSP0, CLKSEQ + CLR);
 
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
-- 
1.7.9.5
