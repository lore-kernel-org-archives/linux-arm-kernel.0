From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 10:49:43 +0200
Subject: [PATCH] clockevents: make register functions work on UP
Message-ID: <mailman.0.1306918392.5904.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On UP systems the clkevt->cpumask is not required, and so as to
avoid ifdef:ing it out of the struct on UP, we remove the mask
warning on UP and force the mask to CPU0 for consistency.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 kernel/time/clockevents.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index c027d4f..aa664f4 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -182,7 +182,11 @@ void clockevents_register_device(struct
clock_event_device *dev)
 	unsigned long flags;

 	BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
+#ifdef CONFIG_SMP
 	BUG_ON(!dev->cpumask);
+#else
+	dev->cpumask = cpumask_of(0);
+#endif

 	raw_spin_lock_irqsave(&clockevents_lock, flags);

-- 
1.7.3.2

Yours,
Linus Walleij
