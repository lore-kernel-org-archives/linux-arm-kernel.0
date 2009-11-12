From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Nov 2009 22:56:29 +0100
Subject: [PATCH] [ARM] IMX: don't disable the uart clock if DEBUG_LL uses it
Message-ID: <1258062989-14493-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the clock was left enabled only for DEBUG_LL_CONSOLE which
requires an additional patch to exist at all.  With this patch applied
DEBUG_LL_CONSOLE depends on DEBUG_LL, so this doesn't break.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/clock_imx21.c |    2 +-
 arch/arm/mach-mx2/clock_imx27.c |    2 +-
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
index eede798..91901b5 100644
--- a/arch/arm/mach-mx2/clock_imx21.c
+++ b/arch/arm/mach-mx2/clock_imx21.c
@@ -1000,7 +1000,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_enable(&per_clk[0]);
 	clk_enable(&gpio_clk);
 
-#ifdef CONFIG_DEBUG_LL_CONSOLE
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart_clk[0]);
 #endif
 
diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index ff5e332..f79af9b 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -751,7 +751,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_enable(&emi_clk);
 	clk_enable(&iim_clk);
 
-#ifdef CONFIG_DEBUG_LL_CONSOLE
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart1_clk);
 #endif
 
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index c595260..f221b42 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -456,7 +456,7 @@ int __init mx35_clocks_init()
 	int i;
 	unsigned int ll = 0;
 
-#ifdef CONFIG_DEBUG_LL_CONSOLE
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	ll = (3 << 16);
 #endif
 
-- 
1.6.5.2
