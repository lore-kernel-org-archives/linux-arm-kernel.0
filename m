From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Dec 2010 16:50:01 -0800
Subject: [PATCH 17/22] msm: Migrate to clock rate voting
In-Reply-To: <1292547006-19741-1-git-send-email-sboyd@codeaurora.org>
References: <1292547006-19741-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1292547006-19741-18-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the appropriate clock voters and integrate clock.c with the
voting driver so that voting works appropriately.

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/clock.c           |   23 +++++++++++++----------
 arch/arm/mach-msm/devices-msm7x30.c |   10 ++++++++++
 arch/arm/mach-msm/devices-qsd8x50.c |    9 +++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index b6b7e7c..c505e30 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -18,7 +18,10 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/spinlock.h>
-#include <linux/pm_qos_params.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/string.h>
+#include <linux/module.h>
 
 #include "clock.h"
 
@@ -139,16 +142,10 @@ int clk_set_flags(struct clk *clk, unsigned long flags)
 }
 EXPORT_SYMBOL(clk_set_flags);
 
-/* EBI1 is the only shared clock that several clients want to vote on as of
- * this commit. If this changes in the future, then it might be better to
- * make clk_min_rate handle the voting or make ebi1_clk_set_min_rate more
- * generic to support different clocks.
- */
-static struct clk *ebi1_clk;
-
 void __init msm_clock_init(struct clk *clock_tbl, unsigned num_clocks)
 {
 	unsigned n;
+	struct clk *clk;
 
 	/* Do SoC-speficic clock init operations. */
 	msm_clk_soc_init();
@@ -160,9 +157,15 @@ void __init msm_clock_init(struct clk *clock_tbl, unsigned num_clocks)
 	}
 	mutex_unlock(&clocks_mutex);
 
-	ebi1_clk = clk_get(NULL, "ebi1_clk");
-	BUG_ON(ebi1_clk == NULL);
+	for (n = 0; n < num_clocks; n++) {
+		clk = &clock_tbl[n];
+		if (clk->flags & CLKFLAG_HANDLE) {
+			struct clk *agg_clk = clk_get(NULL, clk->aggregator);
+			BUG_ON(IS_ERR(agg_clk));
 
+			clk_set_parent(clk, agg_clk);
+		}
+	}
 }
 
 /* The bootloader and/or AMSS may have left various clocks enabled.
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 72da7cc..f18d86b 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -23,6 +23,7 @@
 #include <mach/board.h>
 
 #include "devices.h"
+#include "clock-voter.h"
 #include "smd_private.h"
 
 #include <asm/mach/flash.h>
@@ -156,6 +157,15 @@ struct clk msm_clocks_7x30[] = {
 	CLK_7X30("vfe_pclk",	VFE_P_CLK,	NULL, OFF),
 	CLK_7X30("vpe_clk",	VPE_CLK,	NULL, 0),
 
+	CLK_VOTER("ebi1_dtv_clk", EBI_DTV, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_kgsl_clk", EBI_KGSL, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_lcdc_clk", EBI_LCDC, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_mddi_clk", EBI_MDDI, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_tv_clk", EBI_TV, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_usb_clk", EBI_USB, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_vcd_clk", EBI_VCD, "pbus_clk", NULL, 0),
+	CLK_VOTER("ebi1_vfe_clk", EBI_VFE, "pbus_clk", NULL, 0),
+
 	/* 7x30 v2 hardware only. */
 	CLK_7X30("csi_clk",	CSI0_CLK,	NULL, 0),
 	CLK_7X30("csi_pclk",	CSI0_P_CLK,	NULL, 0),
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 271c8bb..3b11d28 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -28,6 +28,7 @@
 
 #include <mach/mmc.h>
 #include "clock-pcom.h"
+#include "clock-voter.h"
 
 static struct resource resources_uart3[] = {
 	{
@@ -106,6 +107,14 @@ struct clk msm_clocks_8x50[] = {
 	CLK_PCOM("usb_hs3_clk",	USB_HS3_CLK,	NULL, OFF),
 	CLK_PCOM("usb_hs3_pclk",	USB_HS3_P_CLK,	NULL, OFF),
 	CLK_PCOM("usb_phy_clk",	USB_PHY_CLK,	NULL, 0),
+
+	CLK_VOTER("ebi1_acpu_clk", EBI_ACPU, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_kgsl_clk", EBI_KGSL, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_lcdc_clk", EBI_LCDC, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_mddi_clk", EBI_MDDI, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_tv_clk", EBI_TV, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_usb_clk", EBI_USB, "ebi1_clk", NULL, 0),
+	CLK_VOTER("ebi1_vfe_clk", EBI_VFE, "ebi1_clk", NULL, 0),
 };
 
 unsigned msm_num_clocks_8x50 = ARRAY_SIZE(msm_clocks_8x50);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
