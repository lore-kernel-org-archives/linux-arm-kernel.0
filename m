From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:36 +0200
Subject: [PATCH 01/39] ARM: u300: enable delaytimer on the U300
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The U300 can support timer-based delays, so implement this.
Skips past jiffy calibration.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/timer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index d9e7320..c3d3802 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -345,6 +346,12 @@ static u32 notrace u300_read_sched_clock(void)
 	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
 
+static unsigned long u300_read_current_timer(void)
+{
+	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
+}
+
+static struct delay_timer u300_delay_timer;
 
 /*
  * This sets up the system timers, clock source and clock event.
@@ -362,6 +369,10 @@ void __init u300_timer_init(void)
 
 	setup_sched_clock(u300_read_sched_clock, 32, rate);
 
+	u300_delay_timer.read_current_timer = &u300_read_current_timer;
+	u300_delay_timer.freq = rate;
+	register_current_timer_delay(&u300_delay_timer);
+
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
 	 * Example usage in cnh1601578 cpu subsystem pd_timer_app.c
-- 
1.7.11.3
