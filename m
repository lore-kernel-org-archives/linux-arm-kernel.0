From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:30:57 +0100
Subject: [RFC PATCH 02/15] clocksource: samsung_pwm_timer: fix endian accessors
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-3-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the Samsung pwm timer access code to deal with kernels built for big
endian operation.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel at vger.kernel.org
---
 drivers/clocksource/samsung_pwm_timer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 9502bc4..47e0515 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -130,9 +130,9 @@ static void samsung_time_stop(unsigned int channel)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm.base + REG_TCON);
+	tcon = readl_relaxed(pwm.base + REG_TCON);
 	tcon &= ~TCON_START(channel);
-	__raw_writel(tcon, pwm.base + REG_TCON);
+	writel_relaxed(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -148,14 +148,14 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm.base + REG_TCON);
+	tcon = readl_relaxed(pwm.base + REG_TCON);
 
 	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
 	tcon |= TCON_MANUALUPDATE(tcon_chan);
 
-	__raw_writel(tcnt, pwm.base + REG_TCNTB(channel));
-	__raw_writel(tcnt, pwm.base + REG_TCMPB(channel));
-	__raw_writel(tcon, pwm.base + REG_TCON);
+	writel_relaxed(tcnt, pwm.base + REG_TCNTB(channel));
+	writel_relaxed(tcnt, pwm.base + REG_TCMPB(channel));
+	writel_relaxed(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -170,7 +170,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm.base + REG_TCON);
+	tcon = readl_relaxed(pwm.base + REG_TCON);
 
 	tcon &= ~TCON_MANUALUPDATE(channel);
 	tcon |= TCON_START(channel);
@@ -180,7 +180,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 	else
 		tcon &= ~TCON_AUTORELOAD(channel);
 
-	__raw_writel(tcon, pwm.base + REG_TCON);
+	writel_relaxed(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
-- 
2.8.3
