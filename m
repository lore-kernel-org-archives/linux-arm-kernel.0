From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 May 2012 14:18:01 +0200
Subject: [PATCH 2/2] ARM: smp_twd: use the .update_freq() for periodic mode
Message-ID: <1336479481-9281-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

When the SMP TWD timer is in periodic mode, the frequency update
function will need to call into the driver to update the periodic
latch value.

Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fef42b2..7bb2e31 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -74,6 +74,23 @@ static int twd_set_next_event(unsigned long evt,
 	return 0;
 }
 
+static void twd_update_freq(enum clock_event_mode mode,
+			    struct clock_event_device *clk)
+{
+	/*
+	 * The only thing we need to handle here is for the periodic mode,
+	 * where the loaded value needs to be reprogrammed so the new
+	 * frequency is used for the next event.
+	 */
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		__raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
+		break;
+	default:
+		break;
+	}
+}
+
 /*
  * local_timer_ack: checks for a local timer interrupt.
  *
@@ -245,6 +262,7 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
+	clk->update_freq = twd_update_freq;
 	clk->irq = twd_ppi;
 
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
-- 
1.7.9.2
