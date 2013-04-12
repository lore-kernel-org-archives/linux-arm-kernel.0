From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:28 +0200
Subject: [PATCH v5 12/14] clocksource: samsung-pwm: Do not use static mapping
 of registers
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the samsung-pwm clocksource driver to use registers
through the dynamic mapping created by the master driver, instead of
static, hardcoded mapping.

By the way, register definitions and accesses are cleaned up.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm.c | 190 ++++++++++----------------------------
 1 file changed, 50 insertions(+), 140 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 29b480a..99c376d 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -27,12 +27,9 @@
 #include <asm/smp_twd.h>
 #include <asm/mach/time.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/sched_clock.h>
 
-#include <mach/map.h>
 #include <plat/devs.h>
-#include <plat/regs-timer.h>
 #include <plat/samsung-time.h>
 
 /*
@@ -279,6 +276,11 @@ EXPORT_SYMBOL(samsung_pwm_get);
 
 #define REG_TCFG0			0x00
 #define REG_TCFG1			0x04
+#define REG_TCON			0x08
+#define REG_TINT_CSTAT			0x44
+
+#define REG_TCNTB(chan)			(0x0c + 12 * (chan))
+#define REG_TCMPB(chan)			(0x10 + 12 * (chan))
 
 #define TCFG0_PRESCALER_MASK		0xff
 #define TCFG0_PRESCALER1_SHIFT		8
@@ -286,6 +288,11 @@ EXPORT_SYMBOL(samsung_pwm_get);
 #define TCFG1_SHIFT(x)	  		((x) * 4)
 #define TCFG1_MUX_MASK	  		0xf
 
+#define TCON_START(chan)		(1 << (4 * (chan) + 0))
+#define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
+#define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
+#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+
 struct samsung_timer_source {
 	unsigned int event_id;
 	unsigned int source_id;
@@ -340,159 +347,69 @@ static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
 	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
-static void samsung_time_stop(enum samsung_timer_mode mode)
+static void samsung_time_stop(unsigned int channel)
 {
 	unsigned long tcon;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pwm->slock, flags);
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon &= ~S3C2410_TCON_T0START;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon &= ~S3C2410_TCON_T1START;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon &= ~S3C2410_TCON_T2START;
-		break;
+	if (channel > 0)
+		++channel;
 
-	case SAMSUNG_PWM3:
-		tcon &= ~S3C2410_TCON_T3START;
-		break;
-
-	case SAMSUNG_PWM4:
-		tcon &= ~S3C2410_TCON_T4START;
-		break;
+	spin_lock_irqsave(&pwm->slock, flags);
 
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
+	tcon = __raw_readl(pwm->base + REG_TCON);
+	tcon &= ~TCON_START(channel);
+	__raw_writel(tcon, pwm->base + REG_TCON);
 
 	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
-static void samsung_time_setup(enum samsung_timer_mode mode, unsigned long tcnt)
+static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 {
 	unsigned long tcon;
 	unsigned long flags;
+	unsigned int tcon_chan = channel;
+
+	if (tcon_chan > 0)
+		++tcon_chan;
 
 	spin_lock_irqsave(&pwm->slock, flags);
 
-	tcon = __raw_readl(S3C2410_TCON);
+	tcon = __raw_readl(pwm->base + REG_TCON);
 
 	tcnt--;
 
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon &= ~(0x0f << 0);
-		tcon |= S3C2410_TCON_T0MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon &= ~(0x0f << 8);
-		tcon |= S3C2410_TCON_T1MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon &= ~(0x0f << 12);
-		tcon |= S3C2410_TCON_T2MANUALUPD;
-		break;
+	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
+	tcon |= TCON_MANUALUPDATE(tcon_chan);
 
-	case SAMSUNG_PWM3:
-		tcon &= ~(0x0f << 16);
-		tcon |= S3C2410_TCON_T3MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM4:
-		tcon &= ~(0x07 << 20);
-		tcon |= S3C2410_TCON_T4MANUALUPD;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-
-	__raw_writel(tcnt, S3C2410_TCNTB(mode));
-	__raw_writel(tcnt, S3C2410_TCMPB(mode));
-	__raw_writel(tcon, S3C2410_TCON);
+	__raw_writel(tcnt, pwm->base + REG_TCNTB(channel));
+	__raw_writel(tcnt, pwm->base + REG_TCMPB(channel));
+	__raw_writel(tcon, pwm->base + REG_TCON);
 
 	spin_unlock_irqrestore(&pwm->slock, flags);
 }
 
-static void samsung_time_start(enum samsung_timer_mode mode, bool periodic)
+static void samsung_time_start(unsigned int channel, bool periodic)
 {
 	unsigned long tcon;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pwm->slock, flags);
-
-	tcon  = __raw_readl(S3C2410_TCON);
-
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon |= S3C2410_TCON_T0START;
-		tcon &= ~S3C2410_TCON_T0MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T0RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T0RELOAD;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon |= S3C2410_TCON_T1START;
-		tcon &= ~S3C2410_TCON_T1MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T1RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T1RELOAD;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon |= S3C2410_TCON_T2START;
-		tcon &= ~S3C2410_TCON_T2MANUALUPD;
+	if (channel > 0)
+		++channel;
 
-		if (periodic)
-			tcon |= S3C2410_TCON_T2RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T2RELOAD;
-		break;
+	spin_lock_irqsave(&pwm->slock, flags);
 
-	case SAMSUNG_PWM3:
-		tcon |= S3C2410_TCON_T3START;
-		tcon &= ~S3C2410_TCON_T3MANUALUPD;
+	tcon = __raw_readl(pwm->base + REG_TCON);
 
-		if (periodic)
-			tcon |= S3C2410_TCON_T3RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T3RELOAD;
-		break;
+	tcon &= ~TCON_MANUALUPDATE(channel);
+	tcon |= TCON_START(channel);
 
-	case SAMSUNG_PWM4:
-		tcon |= S3C2410_TCON_T4START;
-		tcon &= ~S3C2410_TCON_T4MANUALUPD;
+	if (periodic)
+		tcon |= TCON_AUTORELOAD(channel);
+	else
+		tcon &= ~TCON_AUTORELOAD(channel);
 
-		if (periodic)
-			tcon |= S3C2410_TCON_T4RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T4RELOAD;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
+	__raw_writel(tcon, pwm->base + REG_TCON);
 
 	spin_unlock_irqrestore(&pwm->slock, flags);
 }
@@ -555,7 +472,7 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 
 	if (pwm->variant.has_tint_cstat) {
 		u32 mask = (1 << timer_source.event_id);
-		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
 	}
 
 	evt->event_handler(evt);
@@ -594,32 +511,25 @@ static void __init samsung_clockevent_init(void)
 
 	if (pwm->variant.has_tint_cstat) {
 		u32 mask = (1 << timer_source.event_id);
-		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
 	}
 }
 
 static void __iomem *samsung_timer_reg(void)
 {
-	unsigned long offset = 0;
-
 	switch (timer_source.source_id) {
-	case SAMSUNG_PWM0:
-	case SAMSUNG_PWM1:
-	case SAMSUNG_PWM2:
-	case SAMSUNG_PWM3:
-		offset = (timer_source.source_id * 0x0c) + 0x14;
-		break;
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		return pwm->base + timer_source.source_id * 0x0c + 0x14;
 
-	case SAMSUNG_PWM4:
-		offset = 0x40;
-		break;
+	case 4:
+		return pwm->base + 0x40;
 
 	default:
-		printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
-		return NULL;
+		BUG();
 	}
-
-	return S3C_TIMERREG(offset);
 }
 
 /*
-- 
1.8.1.5
