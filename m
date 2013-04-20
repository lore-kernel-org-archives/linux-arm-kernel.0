From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 16:09:17 +0200
Subject: [PATCH 1/4] clocksource: nomadik-mtu: fix up clocksource/timer
Message-ID: <1366466957-16053-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik clocksource driver has had a bad define making it
impossible to use it for sched_clock() for a while. Fix this
and also enable it for the Nomadik.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/Kconfig     | 1 +
 drivers/clocksource/nomadik-mtu.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 954f0e3..8c1ccd4 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -5,6 +5,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_NOMADIK_MTU
+	select CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 071f6ea..e405531 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -67,7 +67,7 @@ static u32 clk_prescale;
 static u32 nmdk_cycle;		/* write-once */
 static struct delay_timer mtu_delay_timer;
 
-#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
+#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -233,7 +233,7 @@ void __init nmdk_timer_init(void __iomem *base, int irq)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
 
-#ifdef CONFIG_NOMADIK_MTU_SCHED_CLOCK
+#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	setup_sched_clock(nomadik_read_sched_clock, 32, rate);
 #endif
 
-- 
1.8.1.4
