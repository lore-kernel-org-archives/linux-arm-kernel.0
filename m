From: b20788@freescale.com (Anson Huang)
Date: Wed, 20 Mar 2013 13:39:39 -0400
Subject: [PATCH 2/3] ARM: imx: enable periphery well bias for suspend
In-Reply-To: <1363801180-8284-1-git-send-email-b20788@freescale.com>
References: <1363801180-8284-1-git-send-email-b20788@freescale.com>
Message-ID: <1363801180-8284-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable periphery charge pump for well biasing
at suspend to reduce periphery leakage.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |   22 +++++++++++++++++++++-
 arch/arm/mach-imx/common.h    |    4 ++--
 arch/arm/mach-imx/pm-imx6q.c  |    4 +++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2f9ff93..b365efc 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -23,6 +23,9 @@
 #include "clk.h"
 #include "common.h"
 
+#define CCR				0x0
+#define BM_CCR_WB_COUNT			(0x7 << 16)
+
 #define CCGR0				0x68
 #define CCGR1				0x6c
 #define CCGR2				0x70
@@ -67,6 +70,23 @@ void imx6q_set_chicken_bit(void)
 	writel_relaxed(val, ccm_base + CGPR);
 }
 
+void imx6q_set_wb(bool enable)
+{
+	u32 val;
+
+	/* configurate well bias enable bit */
+	val = readl_relaxed(ccm_base + CLPCR);
+	val &= ~BM_CLPCR_WB_PER_AT_LPM;
+	val |= enable ? BM_CLPCR_WB_PER_AT_LPM : 0;
+	writel_relaxed(val, ccm_base + CLPCR);
+
+	/* configurate well bias count */
+	val = readl_relaxed(ccm_base + CCR);
+	val &= ~BM_CCR_WB_COUNT;
+	val |= enable ? BM_CCR_WB_COUNT : 0;
+	writel_relaxed(val, ccm_base + CCR);
+}
+
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
 	u32 val = readl_relaxed(ccm_base + CLPCR);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 004c2b3..b9125cf 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2013 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -134,7 +134,7 @@ extern void imx_anatop_pre_suspend(void);
 extern void imx_anatop_post_resume(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_set_chicken_bit(void);
-
+extern void imx6q_set_wb(bool enable);
 extern void imx_cpu_die(unsigned int cpu);
 extern int imx_cpu_kill(unsigned int cpu);
 
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 05b26cd..57ca274 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2013 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -36,8 +36,10 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_gpc_pre_suspend();
 		imx_anatop_pre_suspend();
 		imx_set_cpu_jump(0, v7_cpu_resume);
+		imx6q_set_wb(true);
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
+		imx6q_set_wb(false);
 		imx_smp_prepare();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
-- 
1.7.9.5
