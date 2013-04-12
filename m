From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:25 +0200
Subject: [PATCH v5 09/14] clocksource: samsung-pwm: Move IRQ mask/ack handling
 to the driver
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the clocksource driver is the only user of PWM timer interrupts,
there is no need to create an IRQ chip for handling them.

This patch changes the way of PWM timer interrupt handling to use
real VIC/GIC interrupt requests and handle PWM mask/ack register
internally in samsung-pwm clocksource driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/irqs.h  |  3 +--
 arch/arm/mach-s3c24xx/include/mach/irqs.h |  6 ++++++
 arch/arm/mach-s3c64xx/common.c            |  3 ---
 arch/arm/mach-s3c64xx/include/mach/irqs.h |  8 --------
 arch/arm/mach-s5p64x0/include/mach/irqs.h |  2 --
 arch/arm/mach-s5pc100/include/mach/irqs.h |  2 --
 arch/arm/mach-s5pv210/include/mach/irqs.h |  2 --
 arch/arm/plat-samsung/devs.c              | 20 ++++++++++----------
 arch/arm/plat-samsung/include/plat/irqs.h |  9 ---------
 arch/arm/plat-samsung/s5p-irq.c           |  2 --
 drivers/clocksource/samsung_pwm.c         | 10 ++++++++++
 11 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 35fe6d5..6fbe229 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -464,10 +464,9 @@
 #define S5P_EINT_BASE2			(S5P_EINT_BASE1 + 16)
 #define S5P_GPIOINT_BASE		(S5P_EINT_BASE1 + 32)
 #define IRQ_GPIO_END			(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
-#define IRQ_TIMER_BASE			(IRQ_GPIO_END + 64)
 
 /* Set the default NR_IRQS */
 
-#define NR_IRQS				(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
+#define NR_IRQS				(IRQ_GPIO_END + 64)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
index b6dd4cb..287545f 100644
--- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
@@ -205,6 +205,12 @@
 #define IRQ_LCD_VSYNC		IRQ_S3C2443_LCD3
 #define IRQ_LCD_SYSTEM		IRQ_S3C2443_LCD2
 
+#define IRQ_TIMER0_VIC		IRQ_TIMER0
+#define IRQ_TIMER1_VIC		IRQ_TIMER1
+#define IRQ_TIMER2_VIC		IRQ_TIMER2
+#define IRQ_TIMER3_VIC		IRQ_TIMER3
+#define IRQ_TIMER4_VIC		IRQ_TIMER4
+
 #ifdef CONFIG_CPU_S3C2440
 #define IRQ_S3C244X_AC97 IRQ_S3C2440_AC97
 #else
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 89d2823..4cb9afe6 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -198,9 +198,6 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
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
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index fbfabd2..68b163a 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1162,20 +1162,20 @@ arch_initcall(s5p_pmu_init);
  */
 
 struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
-	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
-	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
-	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
-	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
+	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0_VIC) },
+	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1_VIC) },
+	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2_VIC) },
+	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3_VIC) },
+	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4_VIC) },
 };
 #endif /* CONFIG_SAMSUNG_DEV_PWM */
 
 static struct resource samsung_pwm_resource[] = {
-	DEFINE_RES_IRQ(IRQ_TIMER0),
-	DEFINE_RES_IRQ(IRQ_TIMER1),
-	DEFINE_RES_IRQ(IRQ_TIMER2),
-	DEFINE_RES_IRQ(IRQ_TIMER3),
-	DEFINE_RES_IRQ(IRQ_TIMER4),
+	DEFINE_RES_IRQ(IRQ_TIMER0_VIC),
+	DEFINE_RES_IRQ(IRQ_TIMER1_VIC),
+	DEFINE_RES_IRQ(IRQ_TIMER2_VIC),
+	DEFINE_RES_IRQ(IRQ_TIMER3_VIC),
+	DEFINE_RES_IRQ(IRQ_TIMER4_VIC),
 	DEFINE_RES_MEM(SAMSUNG_PA_TIMER, SZ_4K),
 };
 
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
index 103e371..ce8564d 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -29,6 +29,4 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 	for (irq = 0; irq < num_vic; irq++)
 		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
 #endif
-
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
 }
diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index bddf9aa..3219ecc 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -509,6 +509,11 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
+	if (pwm->variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+	}
+
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -545,6 +550,11 @@ static void __init samsung_clockevent_init(void)
 
 	irq_number = pwm->irq[timer_source.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
+
+	if (pwm->variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), S3C64XX_TINT_CSTAT);
+	}
 }
 
 static void __iomem *samsung_timer_reg(void)
-- 
1.8.1.5
