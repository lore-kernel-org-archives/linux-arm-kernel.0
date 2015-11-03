From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Nov 2015 22:28:35 +0800
Subject: [PATCH v2 1/3] ARM: delay: choose the highest rating delay timer
In-Reply-To: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
References: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
Message-ID: <1446560917-6318-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case there are several possible delay timers, we purely base the
selection on the frequency, which is suboptimal in some cases. Take
one Marvell Berlin platform for example: we have arch timer and dw-apb
timer. The arch timer freq is 25MHZ while the dw-apb timer freq is
100MHZ, current selection would choose the dw-apb timer. But the dw
apb timer is on the APB bus while arch timer sits in CPU, the cost
of accessing the apb timer is higher than the arch timer.

This patch introduces rating concept to the delay timer and use it
as a primary indication, we fall back to comparing the frequency if
the rating is not set or the same.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/include/asm/delay.h |  1 +
 arch/arm/lib/delay.c         | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index dff714d..cb445d7 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -18,6 +18,7 @@
 struct delay_timer {
 	unsigned long (*read_current_timer)(void);
 	unsigned long freq;
+	int rating;
 };
 
 extern struct arm_delay_ops {
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 8044591..91cee12 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -38,6 +38,7 @@ struct arm_delay_ops arm_delay_ops = {
 static const struct delay_timer *delay_timer;
 static bool delay_calibrated;
 static u64 delay_res;
+static int delay_rating;
 
 int read_current_timer(unsigned long *timer_val)
 {
@@ -78,6 +79,7 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 {
 	u32 new_mult, new_shift;
 	u64 res;
+	bool update_delay_ops = false;
 
 	clocks_calc_mult_shift(&new_mult, &new_shift, timer->freq,
 			       NSEC_PER_SEC, 3600);
@@ -89,11 +91,23 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 		return;
 	}
 
-	if (!delay_calibrated && (!delay_res || (res < delay_res))) {
+	if (!delay_calibrated) {
+		if (delay_rating && timer->rating &&
+				delay_rating != timer->rating) {
+			if (timer->rating > delay_rating)
+				update_delay_ops = true;
+		} else {
+			if (!delay_res || (res < delay_res))
+				update_delay_ops = true;
+		}
+	}
+
+	if (update_delay_ops) {
 		pr_info("Switching to timer-based delay loop, resolution %lluns\n", res);
 		delay_timer			= timer;
 		lpj_fine			= timer->freq / HZ;
 		delay_res			= res;
+		delay_rating			= timer->rating;
 
 		/* cpufreq may scale loops_per_jiffy, so keep a private copy */
 		arm_delay_ops.ticks_per_jiffy	= lpj_fine;
-- 
2.6.2
