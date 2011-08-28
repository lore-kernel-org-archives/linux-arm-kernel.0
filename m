From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Aug 2011 02:49:58 +0200
Subject: [PATCH 5/5] ARM: s3c64xx: Add optional local sched_clock
 implementation.
Message-ID: <mailman.114.1314794177.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds local sched_clock implementation using the PWM timer used
for generic clock source and a Kconfig option to enable/disable it.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig |    8 ++++++++
 arch/arm/mach-s3c64xx/time.c  |   28 +++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 2db76fd..e11dd9b 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -33,6 +33,14 @@ config S3C64XX_GENERIC_CLOCKEVENTS
 	  on S3C6400/S3C6410 SoCs using PWM timers 3 and 4 instead
 	  of standard periodic tick using PWM timer 4.
 
+config S3C64XX_SCHED_CLOCK
+	bool "Use PWM clock source for scheduler clock"
+	depends on S3C64XX_GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
+	help
+	  This option enables local scheduler clock implementation
+	  using PWM clock source.
+
 config S3C64XX_ARCH_USES_GETTIMEOFFSET
 	def_bool y if !S3C64XX_GENERIC_CLOCKEVENTS
 	select ARCH_USES_GETTIMEOFFSET
diff --git a/arch/arm/mach-s3c64xx/time.c b/arch/arm/mach-s3c64xx/time.c
index 4fa57f0..4a78844 100644
--- a/arch/arm/mach-s3c64xx/time.c
+++ b/arch/arm/mach-s3c64xx/time.c
@@ -28,6 +28,7 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
+#include <asm/sched_clock.h>
 #include <mach/map.h>
 #include <plat/regs-timer.h>
 #include <asm/mach/time.h>
@@ -241,6 +242,29 @@ static void s3c64xx_clocksource_resume(struct clocksource *cs)
 	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
 }
 
+#ifdef CONFIG_S3C64XX_SCHED_CLOCK
+/*
+ * Override the global weak sched_clock symbol with this
+ * local implementation which uses the clocksource to get some
+ * better resolution when scheduling the kernel. We accept that
+ * this wraps around for now, since it is just a relative time
+ * stamp. (Inspired by U300 implementation.)
+ */
+static DEFINE_CLOCK_DATA(cd);
+
+unsigned long long notrace sched_clock(void)
+{
+	return cyc_to_sched_clock(&cd,
+			~__raw_readl(S3C2410_TCNTO(PWM_SOURCE)), TCNT_MAX);
+}
+
+static void notrace s3c64xx_update_sched_clock(void)
+{
+	update_sched_clock(&cd,
+			~__raw_readl(S3C2410_TCNTO(PWM_SOURCE)), (u32)~0);
+}
+#endif /* CONFIG_S3C64XX_SCHED_CLOCK */
+
 static struct clocksource pwm_clocksource = {
 	.name		= "s3c64xx_clksrc",
 	.rating		= 250,
@@ -258,7 +282,9 @@ static void __init s3c64xx_clocksource_init(void)
 
 	s3c64xx_pwm_init(PWM_SOURCE, TCNT_MAX);
 	s3c64xx_pwm_start(PWM_SOURCE, PERIODIC);
-
+#ifdef CONFIG_S3C64XX_SCHED_CLOCK
+	init_sched_clock(&cd, s3c64xx_update_sched_clock, 32, clock_rate);
+#endif /* CONFIG_S3C64XX_SCHED_CLOCK */
 	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
 		panic("%s: can't register clocksource\n", pwm_clocksource.name);
 }
-- 
1.7.6.1
