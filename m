From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 12 Dec 2011 10:57:10 +0100
Subject: [PATCH 2/4] ARM: smp_twd: create a percpu reference to the clockevent
Message-ID: <1323683830-23867-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This break-out from Colin Cross' cpufreq-aware TWD patch will
create a local percpu reference to the clock event, so we can
reference the event when the frequency of the TWD clock input
changes at runtime.

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[Broke out of larger SMP TWD patch]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index f057561..20cce4e 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -17,6 +17,7 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/percpu.h>
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
@@ -26,6 +27,7 @@
 void __iomem *twd_base;
 
 static unsigned long twd_timer_rate;
+static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
 
 static struct clock_event_device __percpu **twd_evt;
 
@@ -177,6 +179,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
 	*this_cpu_clk = clk;
 
+	__get_cpu_var(twd_ce) = clk;
+
 	clockevents_config_and_register(clk, twd_timer_rate,
 					0xf, 0xffffffff);
 	enable_percpu_irq(clk->irq, 0);
-- 
1.7.3.2
