From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:24 +0200
Subject: [PATCH v5 08/14] clocksource: samsung-pwm: Synchronize register
 accesses
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the registers of PWM block are shared between two drivers, it is
required to synchronize accesses to them. This patch introduces
necessary synchronization using spin_{un,}lock_irq{save,restore} and
a shared spinlock.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 841d03c..bddf9aa 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -299,6 +299,9 @@ static void samsung_timer_resume(void);
 static void samsung_time_stop(enum samsung_timer_mode mode)
 {
 	unsigned long tcon;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pwm->slock, flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
 
@@ -328,11 +331,16 @@ static void samsung_time_stop(enum samsung_timer_mode mode)
 		break;
 	}
 	__raw_writel(tcon, S3C2410_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
 static void samsung_time_setup(enum samsung_timer_mode mode, unsigned long tcnt)
 {
 	unsigned long tcon;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pwm->slock, flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
 
@@ -372,11 +380,16 @@ static void samsung_time_setup(enum samsung_timer_mode mode, unsigned long tcnt)
 	__raw_writel(tcnt, S3C2410_TCNTB(mode));
 	__raw_writel(tcnt, S3C2410_TCMPB(mode));
 	__raw_writel(tcon, S3C2410_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
 static void samsung_time_start(enum samsung_timer_mode mode, bool periodic)
 {
 	unsigned long tcon;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pwm->slock, flags);
 
 	tcon  = __raw_readl(S3C2410_TCON);
 
@@ -436,6 +449,8 @@ static void samsung_time_start(enum samsung_timer_mode mode, bool periodic)
 		break;
 	}
 	__raw_writel(tcon, S3C2410_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
 static int samsung_set_next_event(unsigned long cycles,
-- 
1.8.1.5
