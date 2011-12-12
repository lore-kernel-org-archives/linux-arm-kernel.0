From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 12 Dec 2011 10:56:45 +0100
Subject: [PATCH 1/4] ARM: smp_twd: modernize clock event registration
Message-ID: <1323683805-23830-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This break-out from Colin Cross' cpufreq-aware TWD patch will
just modernize the clock event registration code to use
clockevents_config_and_register().

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[Broke out of larger SMP TWD patch]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a8a6682..f057561 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -173,15 +173,11 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
-	clk->shift = 20;
-	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
-	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
-	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
 	*this_cpu_clk = clk;
 
-	clockevents_register_device(clk);
-
+	clockevents_config_and_register(clk, twd_timer_rate,
+					0xf, 0xffffffff);
 	enable_percpu_irq(clk->irq, 0);
 }
-- 
1.7.3.2
