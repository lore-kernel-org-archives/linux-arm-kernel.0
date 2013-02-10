From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:20:20 +0100
Subject: [PATCH 09/12] clocksource: samsung-time: Do not use static IRQ
 definition
In-Reply-To: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360502423-2246-10-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As another step towards multiplatform support, this patch modifies the
samsung-time clocksource driver and its users to pass timer IRQ numbers
through the samsung_timer_variant structure.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c | 4 ++++
 arch/arm/mach-s3c24xx/common.c             | 3 +++
 arch/arm/mach-s3c64xx/common.c             | 4 ++++
 arch/arm/mach-s5p64x0/common.c             | 4 ++++
 arch/arm/mach-s5pc100/common.c             | 4 ++++
 arch/arm/mach-s5pv210/common.c             | 4 ++++
 drivers/clocksource/samsung-time.c         | 2 +-
 include/linux/samsung-time.h               | 1 +
 8 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 50fe390..0573db7 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1092,6 +1092,10 @@ static struct platform_device *universal_devices[] __initdata = {
 
 static const struct samsung_timer_variant universal_timer_variant = {
 	.reg_base = EXYNOS4_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
+		IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 9a0584e..3344c33 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -222,6 +222,9 @@ static void s3c24xx_default_idle(void)
 
 static const struct samsung_timer_variant s3c24xx_timer_variant = {
 	.reg_base = S3C24XX_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2, IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 16,
 	.prescale = 25,
 	.divisor = 50,
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index eb36740e..345d08a 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -151,6 +151,10 @@ static struct device s3c64xx_dev = {
 
 static const struct samsung_timer_variant s3c64xx_timer_variant = {
 	.reg_base = S3C_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
+		IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 0158c22..911122e 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -159,6 +159,10 @@ static void s5p64x0_idle(void)
 
 static const struct samsung_timer_variant s5p64x0_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
+		IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index 5ca2f53..f45b1988 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -134,6 +134,10 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 
 static const struct samsung_timer_variant s5pc100_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
+		IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index c80aa9c..a3ad2cf 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -151,6 +151,10 @@ void s5pv210_restart(char mode, const char *cmd)
 
 static const struct samsung_timer_variant s5pv210_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
+	.irqs = {
+		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
+		IRQ_TIMER3, IRQ_TIMER4
+	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 29fc63f..3af3054 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -388,7 +388,7 @@ static void __init samsung_clockevent_init(void)
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
 
-	irq_number = timer_source.event_id + IRQ_TIMER0;
+	irq_number = timer_variant.irqs[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
 }
 
diff --git a/include/linux/samsung-time.h b/include/linux/samsung-time.h
index 526ff99..8d8ffe8 100644
--- a/include/linux/samsung-time.h
+++ b/include/linux/samsung-time.h
@@ -29,6 +29,7 @@ struct samsung_timer_source {
 
 struct samsung_timer_variant {
 	unsigned long reg_base;
+	unsigned int irqs[5];
 	int bits;
 	u16 prescale;
 	u16 divisor;
-- 
1.8.1.2
