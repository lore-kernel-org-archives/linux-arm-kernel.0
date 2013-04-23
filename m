From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:24 +0200
Subject: [PATCH v3 03/13] clocksource: samsung_pwm_timer: Make PWM spinlock
 global
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366731994-7478-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the PWM spinlock global and exports it to allow using
it in Samsung PWM driver (will be reworked to use proper synchronization
in further patches).

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 24 +++++++++++++-----------
 include/clocksource/samsung_pwm.h       |  2 ++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 1752457..d9048b8 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -49,6 +49,9 @@
 #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
 #define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
 
+DEFINE_SPINLOCK(samsung_pwm_lock);
+EXPORT_SYMBOL(samsung_pwm_lock);
+
 struct samsung_timer_source {
 	unsigned int event_id;
 	unsigned int source_id;
@@ -72,14 +75,14 @@ static void samsung_timer_set_prescale(struct samsung_pwm *pwm,
 	if (channel >= 2)
 		shift = TCFG0_PRESCALER1_SHIFT;
 
-	spin_lock_irqsave(&pwm->slock, flags);
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	reg = readl(pwm->base + REG_TCFG0);
 	reg &= ~(TCFG0_PRESCALER_MASK << shift);
 	reg |= (prescale - 1) << shift;
 	writel(reg, pwm->base + REG_TCFG0);
 
-	spin_unlock_irqrestore(&pwm->slock, flags);
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
@@ -92,14 +95,14 @@ static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
 
 	bits = (fls(divisor) - 1) - pwm->variant.div_base;
 
-	spin_lock_irqsave(&pwm->slock, flags);
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	reg = readl(pwm->base + REG_TCFG1);
 	reg &= ~(TCFG1_MUX_MASK << shift);
 	reg |= bits << shift;
 	writel(reg, pwm->base + REG_TCFG1);
 
-	spin_unlock_irqrestore(&pwm->slock, flags);
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_stop(unsigned int channel)
@@ -110,13 +113,13 @@ static void samsung_time_stop(unsigned int channel)
 	if (channel > 0)
 		++channel;
 
-	spin_lock_irqsave(&pwm->slock, flags);
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = __raw_readl(pwm->base + REG_TCON);
 	tcon &= ~TCON_START(channel);
 	__raw_writel(tcon, pwm->base + REG_TCON);
 
-	spin_unlock_irqrestore(&pwm->slock, flags);
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
@@ -128,7 +131,7 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 	if (tcon_chan > 0)
 		++tcon_chan;
 
-	spin_lock_irqsave(&pwm->slock, flags);
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = __raw_readl(pwm->base + REG_TCON);
 
@@ -141,7 +144,7 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 	__raw_writel(tcnt, pwm->base + REG_TCMPB(channel));
 	__raw_writel(tcon, pwm->base + REG_TCON);
 
-	spin_unlock_irqrestore(&pwm->slock, flags);
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_start(unsigned int channel, bool periodic)
@@ -152,7 +155,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 	if (channel > 0)
 		++channel;
 
-	spin_lock_irqsave(&pwm->slock, flags);
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = __raw_readl(pwm->base + REG_TCON);
 
@@ -166,7 +169,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 
 	__raw_writel(tcon, pwm->base + REG_TCON);
 
-	spin_unlock_irqrestore(&pwm->slock, flags);
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static int samsung_set_next_event(unsigned long cycles,
@@ -394,7 +397,6 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 		return;
 	}
 	memcpy(&pwm->variant, variant, sizeof(pwm->variant));
-	spin_lock_init(&pwm->slock);
 	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
 		pwm->irq[i] = irq_of_parse_and_map(np, i);
 
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index eff8668..399d241 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -23,6 +23,8 @@
 struct platform_device;
 struct device_node;
 
+extern spinlock_t samsung_pwm_lock;
+
 struct samsung_pwm_variant {
 	u8 bits;
 	u8 div_base;
-- 
1.8.2.1
