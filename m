From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 10:34:55 +0100
Subject: [PATCH 4/4] ARM: S3C64XX: PM: Synchronise wakeup mask on suspend
In-Reply-To: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
References: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274348095-9390-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new wakeup mask synchronisation code to set the
relevant wakeup mask bits.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Kconfig |    1 +
 arch/arm/mach-s3c64xx/pm.c    |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 69e9fbf..d026bf4 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -7,6 +7,7 @@
 config PLAT_S3C64XX
 	bool
 	depends on ARCH_S3C64XX
+	select SAMSUNG_WAKEMASK
 	default y
 	help
 	  Base platform code for any Samsung S3C64XX device
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index b8ac459..79412f7 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -18,8 +18,11 @@
 #include <linux/io.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <plat/pm.h>
+#include <plat/wakeup-mask.h>
+
 #include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
@@ -153,8 +156,25 @@ static void s3c64xx_cpu_suspend(void)
 	panic("sleep resumed to originator?");
 }
 
+/* mapping of interrupts to parts of the wakeup mask */
+static struct samsung_wakeup_mask wake_irqs[] = {
+	{ .irq = IRQ_RTC_ALARM,	.bit = S3C64XX_PWRCFG_RTC_ALARM_DISABLE, },
+	{ .irq = IRQ_RTC_TIC,	.bit = S3C64XX_PWRCFG_RTC_TICK_DISABLE, },
+	{ .irq = IRQ_PENDN,	.bit = S3C64XX_PWRCFG_TS_DISABLE, },
+	{ .irq = IRQ_HSMMC0,	.bit = S3C64XX_PWRCFG_MMC0_DISABLE, },
+	{ .irq = IRQ_HSMMC1,	.bit = S3C64XX_PWRCFG_MMC1_DISABLE, },
+	{ .irq = IRQ_HSMMC2,	.bit = S3C64XX_PWRCFG_MMC2_DISABLE, },
+	{ .irq = NO_WAKEUP_IRQ,	.bit = S3C64XX_PWRCFG_BATF_DISABLE},
+	{ .irq = NO_WAKEUP_IRQ,	.bit = S3C64XX_PWRCFG_MSM_DISABLE },
+	{ .irq = NO_WAKEUP_IRQ,	.bit = S3C64XX_PWRCFG_HSI_DISABLE },
+	{ .irq = NO_WAKEUP_IRQ,	.bit = S3C64XX_PWRCFG_MSM_DISABLE },
+};
+
 static void s3c64xx_pm_prepare(void)
 {
+	samsung_sync_wakemask(S3C64XX_PWR_CFG,
+			      wake_irqs, ARRAY_SIZE(wake_irqs));
+
 	/* store address of resume. */
 	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C64XX_INFORM0);
 
-- 
1.6.3.3
