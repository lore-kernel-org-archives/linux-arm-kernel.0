From: hs1218.kang@samsung.com (Huisung Kang)
Date: Fri, 10 Feb 2012 21:13:33 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Use spin_lock_irq{save/restore} instead of
 local_irq_{save/restore}
Message-ID: <016f01cce7ed$68871390$39953ab0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Using spin_lock_irq{save/restore} is more stable on smp environment.

Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-samsung/pwm.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index 3a604ca..7e24754 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -44,6 +44,7 @@ struct pwm_device {
 #define pwm_dbg(_pwm, msg...) dev_dbg(&(_pwm)->pdev->dev, msg)
 
 static struct clk *clk_scaler[2];
+static DEFINE_SPINLOCK(pwm_spin_lock);
 
 static inline int pwm_is_tdiv(struct pwm_device *pwm)
 {
@@ -108,7 +109,7 @@ int pwm_enable(struct pwm_device *pwm)
 	unsigned long flags;
 	unsigned long tcon;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&pwm_spin_lock, flags);
 
 	if (!pwm->running) {
 		clk_enable(pwm->clk);
@@ -121,7 +122,7 @@ int pwm_enable(struct pwm_device *pwm)
 		pwm->running = 1;
 	}
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&pwm_spin_lock, flags);
 
 	return 0;
 }
@@ -133,7 +134,7 @@ void pwm_disable(struct pwm_device *pwm)
 	unsigned long flags;
 	unsigned long tcon;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&pwm_spin_lock, flags);
 
 	if (pwm->running) {
 		tcon = __raw_readl(S3C2410_TCON);
@@ -145,7 +146,7 @@ void pwm_disable(struct pwm_device *pwm)
 		pwm->running = 0;
 	}
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&pwm_spin_lock, flags);
 }
 
 EXPORT_SYMBOL(pwm_disable);
@@ -240,7 +241,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 
 	/* Update the PWM register block. */
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&pwm_spin_lock, flags);
 
 	__raw_writel(tcmp, S3C2410_TCMPB(pwm->pwm_id));
 	__raw_writel(tcnt, S3C2410_TCNTB(pwm->pwm_id));
@@ -253,7 +254,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	tcon &= ~pwm_tcon_manulupdate(pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&pwm_spin_lock, flags);
 
 	clk_disable(pwm->clk);
 	clk_disable(pwm->clk_div);
@@ -318,13 +319,13 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 	clk_enable(pwm->clk);
 	clk_enable(pwm->clk_div);
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&pwm_spin_lock, flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
 	tcon |= pwm_tcon_invert(pwm);
 	__raw_writel(tcon, S3C2410_TCON);
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&pwm_spin_lock, flags);
 
 	clk_disable(pwm->clk);
 	clk_disable(pwm->clk_div);
-- 
1.7.1
