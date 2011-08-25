From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 25 Aug 2011 12:57:36 +0200
Subject: [PATCH] arm: mach-imx: enable all uart clocks for DEBUG_LL
Message-ID: <1314269856-20000-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you want to move the DEBUG_LL uart, simply changing the base address
in debug-macro.S will not be enough. One needs to enable the correct
clock during clock init, too, otherwise the kernel remains silent. This
is too easy to forget, so enable all uart clocks for DEBUG_LL to save
precious developer time.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx21.c |    3 +++
 arch/arm/mach-imx/clock-imx25.c |    4 ++++
 arch/arm/mach-imx/clock-imx27.c |    5 +++++
 arch/arm/mach-imx/clock-imx35.c |    2 +-
 4 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index ee15d8c..e04c264 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1231,6 +1231,9 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart_clk[0]);
+	clk_enable(&uart_clk[1]);
+	clk_enable(&uart_clk[2]);
+	clk_enable(&uart_clk[3]);
 #endif
 
 	mxc_timer_init(&gpt_clk[0], MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR),
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index e63e235..9c3e655 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -325,6 +325,10 @@ int __init mx25_clocks_init(void)
 	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart1_clk);
+	clk_enable(&uart2_clk);
+	clk_enable(&uart3_clk);
+	clk_enable(&uart4_clk);
+	clk_enable(&uart5_clk);
 #endif
 
 	/* Clock source for lcdc and csi is upll */
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 6912b82..561f88e 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -754,6 +754,11 @@ int __init mx27_clocks_init(unsigned long fref)
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart1_clk);
+	clk_enable(&uart2_clk);
+	clk_enable(&uart3_clk);
+	clk_enable(&uart4_clk);
+	clk_enable(&uart5_clk);
+	clk_enable(&uart6_clk);
 #endif
 
 	mxc_timer_init(&gpt1_clk, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 88b62a0..4957778 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -510,7 +510,7 @@ int __init mx35_clocks_init()
 	unsigned int cgr2 = 3 << 26, cgr3 = 0;
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
-	cgr2 |= 3 << 16;
+	cgr2 |= 3 << 16 | 3 << 18 | 3 << 20;
 #endif
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.5.4
