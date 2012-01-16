From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 16 Jan 2012 17:01:17 -0200
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
Message-ID: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Selecting audio on a mx28evk the saif driver was failing:

[    0.660000] saif0_clk_set_rate: divider writing timeout                     
[    0.670000] mxs-sgtl5000: probe of mxs-sgtl5000.0 failed with error -110    
[    0.670000] ALSA device list:                                               
[    0.680000]   No soundcards found.    

The timeout on saif0_clk_set_rate was due to the wrong condition for the end of loop.

After fixing it, the audio driver can be correctly probed and becomes functional.

While at it, fix the other locations where the similar issue occurs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..ee9e04b 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -396,7 +396,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	}								\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 									\
-	for (i = 10000; i; i--)						\
+	for (i = 10000; i < 0; i--)					\
 		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
 			HW_CLKCTRL_##dr) & bm_busy))			\
 			break;						\
@@ -439,7 +439,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	}								\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 									\
-	for (i = 10000; i; i--)						\
+	for (i = 10000; i < 0; i--)					\
 		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
 			HW_CLKCTRL_##dr) & BM_CLKCTRL_##dr##_BUSY))	\
 			break;						\
@@ -479,7 +479,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
 									\
-	for (i = 10000; i; i--)						\
+	for (i = 10000; i < 0; i--)					\
 		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
 			HW_CLKCTRL_##rs) & BM_CLKCTRL_##rs##_BUSY))	\
 			break;						\
@@ -756,7 +756,7 @@ static int clk_misc_init(void)
 	reg |= 3 << BP_CLKCTRL_HBUS_DIV;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_HBUS);
 
-	for (i = 10000; i; i--)
+	for (i = 10000; i < 0; i--)
 		if (!(__raw_readl(CLKCTRL_BASE_ADDR +
 			HW_CLKCTRL_HBUS) & BM_CLKCTRL_HBUS_ASM_BUSY))
 			break;
-- 
1.7.1
