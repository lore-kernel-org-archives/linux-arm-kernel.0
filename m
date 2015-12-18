From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:05 +0100
Subject: [PATCH 52/69] clocksource/drivers/h8300_timer16: Remove pointless lock
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-52-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lock in the timer16_clocksource_read is not needed, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index 129dca0..f396605 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -30,7 +30,6 @@ struct timer16_priv {
 	unsigned char imfa;
 	unsigned char imiea;
 	unsigned char ovf;
-	raw_spinlock_t lock;
 	struct clk *clk;
 };
 
@@ -75,13 +74,10 @@ static inline struct timer16_priv *cs_to_priv(struct clocksource *cs)
 static cycle_t timer16_clocksource_read(struct clocksource *cs)
 {
 	struct timer16_priv *p = cs_to_priv(cs);
-	unsigned long flags, raw;
-	unsigned long value;
+	unsigned long raw, value;
 
-	raw_spin_lock_irqsave(&p->lock, flags);
 	value = p->total_cycles;
 	raw = timer16_get_counter(p);
-	raw_spin_unlock_irqrestore(&p->lock, flags);
 
 	return value + raw;
 }
-- 
1.9.1
