From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:59:02 +0200
Subject: [PATCH 7/9] [ARM] mmp: move mmp2 specific timer code to mmp2.c
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c |   21 +++++++++++++++++++++
 arch/arm/mach-mmp/time.c |   21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 7f5eb05..b3fddac 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -17,6 +17,7 @@
 
 #include <asm/hardware/cache-tauros2.h>
 
+#include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
@@ -158,6 +159,26 @@ static int __init mmp2_init(void)
 }
 postcore_initcall(mmp2_init);
 
+static void __init mmp2_timer_init(void)
+{
+	unsigned long clk_rst;
+
+	__raw_writel(APBC_APBCLK | APBC_RST, APBC_MMP2_TIMERS);
+
+	/*
+	 * enable bus/functional clock, enable 6.5MHz (divider 4),
+	 * release reset
+	 */
+	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
+	__raw_writel(clk_rst, APBC_MMP2_TIMERS);
+
+	timer_init(IRQ_MMP2_TIMER1);
+}
+
+struct sys_timer mmp2_timer = {
+	.init	= mmp2_timer_init,
+};
+
 /* on-chip devices */
 MMP2_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4030000, 0x30, 4, 5);
 MMP2_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4017000, 0x30, 20, 21);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index cf75694..6652819 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -200,24 +200,3 @@ void __init timer_init(int irq)
 	clocksource_register(&cksrc);
 	clockevents_register_device(&ckevt);
 }
-
-static void __init mmp2_timer_init(void)
-{
-	unsigned long clk_rst;
-
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_MMP2_TIMERS);
-
-	/*
-	 * enable bus/functional clock, enable 6.5MHz (divider 4),
-	 * release reset
-	 */
-	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
-	__raw_writel(clk_rst, APBC_MMP2_TIMERS);
-
-	timer_init(IRQ_MMP2_TIMER1);
-}
-
-struct sys_timer mmp2_timer = {
-	.init	= mmp2_timer_init,
-};
-
-- 
1.7.1
