From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:20:21 +0100
Subject: [PATCH 10/12] clocksource: samsung-time: Move IRQ mask/ack handling
 to the driver
In-Reply-To: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360502423-2246-11-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the clocksource driver is the only user of PWM timer interrupts,
there is no need to create an IRQ chip for handling them.

This patch the way of PWM timer interrupt handling to use real VIC/GIC
interrupt signals and handle PWM mask/ack register internally in
samsung-time driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/include/mach/irqs.h   |  3 +--
 arch/arm/mach-exynos/mach-universal_c210.c |  5 +++--
 arch/arm/mach-s3c24xx/common.c             |  1 +
 arch/arm/mach-s3c64xx/common.c             |  8 +++-----
 arch/arm/mach-s3c64xx/include/mach/irqs.h  |  8 --------
 arch/arm/mach-s5p64x0/common.c             |  5 +++--
 arch/arm/mach-s5p64x0/include/mach/irqs.h  |  2 --
 arch/arm/mach-s5pc100/common.c             |  5 +++--
 arch/arm/mach-s5pc100/include/mach/irqs.h  |  2 --
 arch/arm/mach-s5pv210/common.c             |  5 +++--
 arch/arm/mach-s5pv210/include/mach/irqs.h  |  2 --
 arch/arm/plat-samsung/include/plat/irqs.h  |  9 ---------
 arch/arm/plat-samsung/s5p-irq.c            |  2 --
 drivers/clocksource/samsung-time.c         | 10 ++++++++++
 include/linux/samsung-time.h               |  1 +
 15 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 6794292..98c97be 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -470,10 +470,9 @@
 #define S5P_EINT_BASE2			(S5P_EINT_BASE1 + 16)
 #define S5P_GPIOINT_BASE		(S5P_EINT_BASE1 + 32)
 #define IRQ_GPIO_END			(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
-#define IRQ_TIMER_BASE			(IRQ_GPIO_END + 64)
 
 /* Set the default NR_IRQS */
 
-#define NR_IRQS				(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
+#define NR_IRQS				(IRQ_GPIO_END + 64)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 0573db7..1f4af85 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1093,12 +1093,13 @@ static struct platform_device *universal_devices[] __initdata = {
 static const struct samsung_timer_variant universal_timer_variant = {
 	.reg_base = EXYNOS4_PA_TIMER,
 	.irqs = {
-		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
-		IRQ_TIMER3, IRQ_TIMER4
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC
 	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
+	.has_tint_cstat = true,
 };
 
 static void __init universal_map_io(void)
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 3344c33..c79307a 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -228,6 +228,7 @@ static const struct samsung_timer_variant s3c24xx_timer_variant = {
 	.bits = 16,
 	.prescale = 25,
 	.divisor = 50,
+	.has_tint_cstat = false,
 };
 
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 345d08a..4e1775f 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -152,12 +152,13 @@ static struct device s3c64xx_dev = {
 static const struct samsung_timer_variant s3c64xx_timer_variant = {
 	.reg_base = S3C_PA_TIMER,
 	.irqs = {
-		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
-		IRQ_TIMER3, IRQ_TIMER4
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC
 	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
+	.has_tint_cstat = true,
 };
 
 /* read cpu identification code */
@@ -202,9 +203,6 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	/* initialise the pair of VICs */
 	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
 	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
-
-	/* add the timer sub-irqs */
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
 }
 
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index 96d60e0..67bbd1d 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -107,14 +107,6 @@
 #define IRQ_TC			IRQ_PENDN
 #define IRQ_ADC			S3C64XX_IRQ_VIC1(31)
 
-#define S3C64XX_TIMER_IRQ(x)	S3C_IRQ(64 + (x))
-
-#define IRQ_TIMER0		S3C64XX_TIMER_IRQ(0)
-#define IRQ_TIMER1		S3C64XX_TIMER_IRQ(1)
-#define IRQ_TIMER2		S3C64XX_TIMER_IRQ(2)
-#define IRQ_TIMER3		S3C64XX_TIMER_IRQ(3)
-#define IRQ_TIMER4		S3C64XX_TIMER_IRQ(4)
-
 /* compatibility for device defines */
 
 #define IRQ_IIC1		IRQ_S3C6410_IIC1
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 911122e..982e2d6 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -160,12 +160,13 @@ static void s5p64x0_idle(void)
 static const struct samsung_timer_variant s5p64x0_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
 	.irqs = {
-		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
-		IRQ_TIMER3, IRQ_TIMER4
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC
 	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
+	.has_tint_cstat = true,
 };
 
 /*
diff --git a/arch/arm/mach-s5p64x0/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
index 5b845e8..53982db 100644
--- a/arch/arm/mach-s5p64x0/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -141,8 +141,6 @@
 
 #define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##_BASE + (x))
 
-#define IRQ_TIMER_BASE		(11)
-
 /* Set the default NR_IRQS */
 
 #define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index f45b1988..6b5364c 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -135,12 +135,13 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 static const struct samsung_timer_variant s5pc100_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
 	.irqs = {
-		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
-		IRQ_TIMER3, IRQ_TIMER4
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC
 	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
+	.has_tint_cstat = true,
 };
 
 /*
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 2870f12..d2eb475 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -97,8 +97,6 @@
 #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
 #define IRQ_VIC_END		S5P_IRQ_VIC2(31)
 
-#define IRQ_TIMER_BASE		(11)
-
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index a3ad2cf..8104bc7 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -152,12 +152,13 @@ void s5pv210_restart(char mode, const char *cmd)
 static const struct samsung_timer_variant s5pv210_timer_variant = {
 	.reg_base = S5P_PA_TIMER,
 	.irqs = {
-		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2,
-		IRQ_TIMER3, IRQ_TIMER4
+		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
+		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC
 	},
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
+	.has_tint_cstat = true,
 };
 
 /*
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index e777e01..5e0de3a 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -118,8 +118,6 @@
 #define IRQ_MDNIE3		S5P_IRQ_VIC3(8)
 #define IRQ_VIC_END		S5P_IRQ_VIC3(31)
 
-#define IRQ_TIMER_BASE		(11)
-
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
diff --git a/arch/arm/plat-samsung/include/plat/irqs.h b/arch/arm/plat-samsung/include/plat/irqs.h
index df46b77..039001c 100644
--- a/arch/arm/plat-samsung/include/plat/irqs.h
+++ b/arch/arm/plat-samsung/include/plat/irqs.h
@@ -44,15 +44,6 @@
 #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
 #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
 
-#define S5P_TIMER_IRQ(x)	(IRQ_TIMER_BASE + (x))
-
-#define IRQ_TIMER0		S5P_TIMER_IRQ(0)
-#define IRQ_TIMER1		S5P_TIMER_IRQ(1)
-#define IRQ_TIMER2		S5P_TIMER_IRQ(2)
-#define IRQ_TIMER3		S5P_TIMER_IRQ(3)
-#define IRQ_TIMER4		S5P_TIMER_IRQ(4)
-#define IRQ_TIMER_COUNT		(5)
-
 #define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_EINT_BASE1) \
 					: ((x) - 16 + S5P_EINT_BASE2))
 
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index dfb47d6..a14d8e9 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -30,6 +30,4 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 	for (irq = 0; irq < num_vic; irq++)
 		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
 #endif
-
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
 }
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 3af3054..19a1c8a 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -355,6 +355,11 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
+	if (timer_variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+	}
+
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -390,6 +395,11 @@ static void __init samsung_clockevent_init(void)
 
 	irq_number = timer_variant.irqs[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
+
+	if (timer_variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+	}
 }
 
 static void __iomem *samsung_timer_reg(void)
diff --git a/include/linux/samsung-time.h b/include/linux/samsung-time.h
index 8d8ffe8..45cf87b 100644
--- a/include/linux/samsung-time.h
+++ b/include/linux/samsung-time.h
@@ -33,6 +33,7 @@ struct samsung_timer_variant {
 	int bits;
 	u16 prescale;
 	u16 divisor;
+	bool has_tint_cstat;
 };
 
 extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-- 
1.8.1.2
