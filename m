From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 17:43:54 +0100
Subject: [PATCH v2 02/12] clocksource: samsung-time: Set platform-specific
 parameters at runtime
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361033044-27629-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes static platform-specific defines from samsung-time
implementation and introduces an interface to configure
platform-specific timer parameters from platform code.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c        |  7 ++++
 arch/arm/mach-s3c24xx/common.c                    |  9 +++++
 arch/arm/mach-s3c64xx/common.c                    |  9 +++++
 arch/arm/mach-s5p64x0/common.c                    |  9 +++++
 arch/arm/mach-s5pc100/common.c                    |  9 +++++
 arch/arm/mach-s5pv210/common.c                    |  9 +++++
 arch/arm/plat-samsung/include/plat/samsung-time.h | 26 ++++++++-------
 drivers/clocksource/samsung-time.c                | 40 ++++++++++++++++++-----
 8 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 36e8d4c..5a8c0e1 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1090,11 +1090,18 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_fimc_md,
 };
 
+static const struct samsung_timer_variant universal_timer_variant = {
+	.bits = 32,
+	.prescale = 2,
+	.divisor = 2,
+};
+
 static void __init universal_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
+	samsung_timer_set_variant(&universal_timer_variant);
 	samsung_set_timer_source(SAMSUNG_PWM2, SAMSUNG_PWM4);
 }
 
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 6bcf87f..f720053 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -54,6 +54,7 @@
 #include <plat/s3c2443.h>
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
+#include <plat/samsung-time.h>
 
 /* table of supported CPUs */
 
@@ -219,6 +220,12 @@ static void s3c24xx_default_idle(void)
 		     S3C2410_CLKCON);
 }
 
+static const struct samsung_timer_variant s3c24xx_timer_variant = {
+	.bits = 16,
+	.prescale = 25,
+	.divisor = 50,
+};
+
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
 	arm_pm_idle = s3c24xx_default_idle;
@@ -235,6 +242,8 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	s3c24xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_timer_set_variant(&s3c24xx_timer_variant);
 }
 
 /* Serial port registrations */
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index aef303b..5e5fbe5 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -44,6 +44,7 @@
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
+#include <plat/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
@@ -148,6 +149,12 @@ static struct device s3c64xx_dev = {
 	.bus	= &s3c64xx_subsys,
 };
 
+static const struct samsung_timer_variant s3c64xx_timer_variant = {
+	.bits = 32,
+	.prescale = 2,
+	.divisor = 2,
+};
+
 /* read cpu identification code */
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
@@ -160,6 +167,8 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	s3c64xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_timer_set_variant(&s3c64xx_timer_variant);
 }
 
 static __init int s3c64xx_dev_init(void)
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 8ae5800..dd93674 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -48,6 +48,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
+#include <plat/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
@@ -156,6 +157,12 @@ static void s5p64x0_idle(void)
 	cpu_do_idle();
 }
 
+static const struct samsung_timer_variant s5p64x0_timer_variant = {
+	.bits = 32,
+	.prescale = 2,
+	.divisor = 2,
+};
+
 /*
  * s5p64x0_map_io
  *
@@ -173,6 +180,8 @@ void __init s5p64x0_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P64X0_SYS_ID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_timer_set_variant(&s5p64x0_timer_variant);
 }
 
 void __init s5p6440_map_io(void)
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index cc6e561..f3f3a75 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -47,6 +47,7 @@
 #include <plat/onenand-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
+#include <plat/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
@@ -131,6 +132,12 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 	}
 };
 
+static const struct samsung_timer_variant s5pc100_timer_variant = {
+	.bits = 32,
+	.prescale = 2,
+	.divisor = 2,
+};
+
 /*
  * s5pc100_map_io
  *
@@ -148,6 +155,8 @@ void __init s5pc100_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_timer_set_variant(&s5pc100_timer_variant);
 }
 
 void __init s5pc100_map_io(void)
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 9dfe93e..45acaf3 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -42,6 +42,7 @@
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
+#include <plat/samsung-time.h>
 #include <plat/tv-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
@@ -148,6 +149,12 @@ void s5pv210_restart(char mode, const char *cmd)
 	__raw_writel(0x1, S5P_SWRESET);
 }
 
+static const struct samsung_timer_variant s5pv210_timer_variant = {
+	.bits = 32,
+	.prescale = 2,
+	.divisor = 2,
+};
+
 /*
  * s5pv210_map_io
  *
@@ -165,6 +172,8 @@ void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_timer_set_variant(&s5pv210_timer_variant);
 }
 
 void __init s5pv210_map_io(void)
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
index 6f83a9d..45f0036 100644
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ b/arch/arm/plat-samsung/include/plat/samsung-time.h
@@ -27,25 +27,27 @@ struct samsung_timer_source {
 	unsigned int source_id;
 };
 
+/**
+ * struct samsung_timer_variant - SoC-specific parameters of Samsung PWM timers
+ * @bits:	bit width of time counters
+ * @prescale:	prescaler divisor
+ * @divisor:	resulting divisor after prescaler and main divisor
+ */
+struct samsung_timer_variant {
+	int bits;
+	u16 prescale;
+	u16 divisor;
+};
+
 /* Be able to sleep for atleast 4 seconds (usually more) */
 #define SAMSUNG_TIMER_MIN_RANGE	4
 
-#if defined(CONFIG_ARCH_S3C24XX) || defined(CONFIG_ARCH_S5PC100)
-#define TCNT_MAX		0xffff
-#define TSCALER_DIV		25
-#define TDIV			50
-#define TSIZE			16
-#else
-#define TCNT_MAX		0xffffffff
-#define TSCALER_DIV		2
-#define TDIV			2
-#define TSIZE			32
-#endif
-
 #define NON_PERIODIC		0
 #define PERIODIC		1
 
 extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
 					enum samsung_timer_mode source);
+extern void __init samsung_timer_set_variant(
+				const struct samsung_timer_variant *variant);
 extern	void samsung_timer_init(void);
 #endif /* __ASM_PLAT_SAMSUNG_TIME_H */
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index f899cbc..3017203 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -33,6 +33,7 @@ static struct clk *tdiv_event;
 static struct clk *tdiv_source;
 static struct clk *timerclk;
 static struct samsung_timer_source timer_source;
+static struct samsung_timer_variant timer_variant;
 static unsigned long clock_count_per_tick;
 static void samsung_timer_resume(void);
 
@@ -213,12 +214,16 @@ static void samsung_set_mode(enum clock_event_mode mode,
 
 static void samsung_timer_resume(void)
 {
+	u32 tcnt_max;
+
+	tcnt_max = (1UL << timer_variant.bits) - 1;
+
 	/* event timer restart */
 	samsung_time_setup(timer_source.event_id, clock_count_per_tick);
 	samsung_time_start(timer_source.event_id, PERIODIC);
 
 	/* source timer restart */
-	samsung_time_setup(timer_source.source_id, TCNT_MAX);
+	samsung_time_setup(timer_source.source_id, tcnt_max);
 	samsung_time_start(timer_source.source_id, PERIODIC);
 }
 
@@ -232,6 +237,12 @@ void __init samsung_set_timer_source(enum samsung_timer_mode event,
 	timer_source.source_id = source;
 }
 
+void __init samsung_timer_set_variant(
+				const struct samsung_timer_variant *variant)
+{
+	timer_variant = *variant;
+}
+
 static struct clock_event_device time_event_device = {
 	.name		= "samsung_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -267,8 +278,8 @@ static void __init samsung_clockevent_init(void)
 
 	tscaler = clk_get_parent(tdiv_event);
 
-	clk_set_rate(tscaler, pclk / TSCALER_DIV);
-	clk_set_rate(tdiv_event, pclk / TDIV);
+	clk_set_rate(tscaler, pclk / timer_variant.prescale);
+	clk_set_rate(tdiv_event, pclk / timer_variant.divisor);
 	clk_set_parent(tin_event, tdiv_event);
 
 	clock_rate = clk_get_rate(tin_event);
@@ -326,21 +337,28 @@ static void __init samsung_clocksource_init(void)
 {
 	unsigned long pclk;
 	unsigned long clock_rate;
+	u32 tcnt_max;
+	int ret;
+
+	tcnt_max = (1UL << timer_variant.bits) - 1;
 
 	pclk = clk_get_rate(timerclk);
 
-	clk_set_rate(tdiv_source, pclk / TDIV);
+	clk_set_rate(tdiv_source, pclk / timer_variant.divisor);
 	clk_set_parent(tin_source, tdiv_source);
 
 	clock_rate = clk_get_rate(tin_source);
 
-	samsung_time_setup(timer_source.source_id, TCNT_MAX);
+	samsung_time_setup(timer_source.source_id, tcnt_max);
 	samsung_time_start(timer_source.source_id, PERIODIC);
 
-	setup_sched_clock(samsung_read_sched_clock, TSIZE, clock_rate);
+	setup_sched_clock(samsung_read_sched_clock,
+						timer_variant.bits, clock_rate);
 
-	if (clocksource_mmio_init(samsung_timer_reg(), "samsung_clocksource_timer",
-			clock_rate, 250, TSIZE, clocksource_mmio_readl_down))
+	ret = clocksource_mmio_init(samsung_timer_reg(),
+			"samsung_clocksource_timer", clock_rate, 250,
+			timer_variant.bits, clocksource_mmio_readl_down);
+	if (ret)
 		panic("samsung_clocksource_timer: can't register clocksource\n");
 }
 
@@ -388,6 +406,12 @@ static void __init samsung_timer_resources(void)
 
 void __init samsung_timer_init(void)
 {
+	if (!timer_source.source_id && !timer_source.event_id)
+		panic("timer sources not set (see samsung_set_timer_source)!\n");
+
+	if (!timer_variant.bits)
+		panic("timer variant not set (see samsung_timer_set_variant)!\n");
+
 	samsung_timer_resources();
 	samsung_clockevent_init();
 	samsung_clocksource_init();
-- 
1.8.1.2
