From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 14 Nov 2017 09:52:38 +0100
Subject: [PATCH v8 1/6] clocksource: timer_of: rename timer_of_exit to
 timer_of_cleanup
In-Reply-To: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1510649563-22975-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1510649563-22975-2-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change function name to something more explicit since it is only
used in init error cases.
Add __init annotation and description about the function usage.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/clocksource/timer-of.c | 9 ++++++++-
 drivers/clocksource/timer-of.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 7c64a5c1..a319904 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -177,7 +177,14 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 	return ret;
 }
 
-void timer_of_exit(struct timer_of *to)
+/**
+ * timer_of_cleanup - release timer_of ressources
+ * @to: timer_of structure
+ *
+ * Release the ressources that has been used in timer_of_init().
+ * This function should be called in init error cases
+ */
+void __init timer_of_cleanup(struct timer_of *to)
 {
 	if (to->flags & TIMER_OF_IRQ)
 		timer_irq_exit(&to->of_irq);
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index 44f57e0..f521477 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -67,6 +67,6 @@ static inline unsigned long timer_of_period(struct timer_of *to)
 extern int __init timer_of_init(struct device_node *np,
 				struct timer_of *to);
 
-extern void timer_of_exit(struct timer_of *to);
+extern void __init timer_of_cleanup(struct timer_of *to);
 
 #endif
-- 
2.7.4
