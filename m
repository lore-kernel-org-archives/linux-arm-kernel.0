From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 17:44:01 +0100
Subject: [PATCH v2 09/12] clocksource: samsung-time: Do not use static IRQ
 definition
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361033044-27629-10-git-send-email-tomasz.figa@gmail.com>
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
 include/clocksource/samsung-time.h         | 4 ++++
 8 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 74f6e7f..2efd543f 100644
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
index 44ba280..b152c59 100644
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
index 9883a91..5245d8a 100644
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
index d715b19..583ff13 100644
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
index d93e26e..8c79d48 100644
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
index 29317ee..34fc77e 100644
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
index 5ecc864..7103ea1 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -389,7 +389,7 @@ static void __init samsung_clockevent_init(void)
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
 
-	irq_number = timer_source.event_id + IRQ_TIMER0;
+	irq_number = timer_variant.irqs[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
 }
 
diff --git a/include/clocksource/samsung-time.h b/include/clocksource/samsung-time.h
index 6d25b0b..48be3a4 100644
--- a/include/clocksource/samsung-time.h
+++ b/include/clocksource/samsung-time.h
@@ -20,6 +20,8 @@ enum samsung_timer_mode {
 	SAMSUNG_PWM2,
 	SAMSUNG_PWM3,
 	SAMSUNG_PWM4,
+
+	SAMSUNG_PWM_NUM
 };
 
 struct samsung_timer_source {
@@ -30,12 +32,14 @@ struct samsung_timer_source {
 /**
  * struct samsung_timer_variant - SoC-specific parameters of Samsung PWM timers
  * @reg_base:	physical base address of timer registers
+ * @irqs:	interrupt numbers of all timers
  * @bits:	bit width of time counters
  * @prescale:	prescaler divisor
  * @divisor:	resulting divisor after prescaler and main divisor
  */
 struct samsung_timer_variant {
 	unsigned long reg_base;
+	unsigned int irqs[SAMSUNG_PWM_NUM];
 	int bits;
 	u16 prescale;
 	u16 divisor;
-- 
1.8.1.2
