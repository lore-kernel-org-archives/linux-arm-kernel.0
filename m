From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:17:58 +0100
Subject: [PATCH v2 07/10] ARM: S3C24XX: use samsung_sync_wakemask in s3c2412 pm
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091817.58408.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally the s3c2412 used a overidden irq chip to set the rtc wakeup flag.
But with using the samsung_sync_wakemask function the same can be achieved
without introducing soc specific irq functions.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig       |    1 +
 arch/arm/mach-s3c24xx/irq-s3c2412.c |   23 -----------------------
 arch/arm/mach-s3c24xx/pm-s3c2412.c  |    8 ++++++++
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 876393e..0dca380 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -406,6 +406,7 @@ config S3C2412_DMA
 config S3C2412_PM
 	bool
 	select S3C2412_PM_SLEEP
+	select SAMSUNG_WAKEMASK
 	help
 	  Internal config node to apply S3C2412 power management
 
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2412.c b/arch/arm/mach-s3c24xx/irq-s3c2412.c
index 67d7631..e6fd954 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2412.c
@@ -155,22 +155,6 @@ static struct irq_chip s3c2412_irq_cfsdi = {
 	.irq_unmask	= s3c2412_irq_cfsdi_unmask,
 };
 
-static int s3c2412_irq_rtc_wake(struct irq_data *data, unsigned int state)
-{
-	unsigned long pwrcfg;
-
-	pwrcfg = __raw_readl(S3C2412_PWRCFG);
-	if (state)
-		pwrcfg &= ~S3C2412_PWRCFG_RTC_MASKIRQ;
-	else
-		pwrcfg |= S3C2412_PWRCFG_RTC_MASKIRQ;
-	__raw_writel(pwrcfg, S3C2412_PWRCFG);
-
-	return s3c_irq_chip.irq_set_wake(data, state);
-}
-
-static struct irq_chip s3c2412_irq_rtc_chip;
-
 static int s3c2412_irq_add(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int irqno;
@@ -191,13 +175,6 @@ static int s3c2412_irq_add(struct device *dev, struct subsys_interface *sif)
 		set_irq_flags(irqno, IRQF_VALID);
 	}
 
-	/* change RTC IRQ's set wake method */
-
-	s3c2412_irq_rtc_chip = s3c_irq_chip;
-	s3c2412_irq_rtc_chip.irq_set_wake = s3c2412_irq_rtc_wake;
-
-	irq_set_chip(IRQ_RTC, &s3c2412_irq_rtc_chip);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index 4c4bc1c..d75f95e 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -29,6 +29,7 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
+#include <plat/wakeup-mask.h>
 
 #include "regs-dsc.h"
 #include "s3c2412-power.h"
@@ -51,8 +52,15 @@ static int s3c2412_cpu_suspend(unsigned long arg)
 	return 1; /* Aborting suspend */
 }
 
+/* mapping of interrupts to parts of the wakeup mask */
+static struct samsung_wakeup_mask wake_irqs[] = {
+	{ .irq = IRQ_RTC,	.bit = S3C2412_PWRCFG_RTC_MASKIRQ, },
+};
+
 static void s3c2412_pm_prepare(void)
 {
+	samsung_sync_wakemask(S3C2412_PWRCFG,
+			      wake_irqs, ARRAY_SIZE(wake_irqs));
 }
 
 static int s3c2412_pm_add(struct device *dev, struct subsys_interface *sif)
-- 
1.7.2.3
