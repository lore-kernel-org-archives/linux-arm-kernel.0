From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:22 +0200
Subject: [PATCH v5 06/14] ARM: SAMSUNG: Set PWM platform data
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PWM platform data needed for legacy (non-DT) platforms
to handle SoC-specific bits of the PWM/timer block.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c  | 10 ++++++++++
 arch/arm/mach-s3c24xx/common.c | 10 ++++++++++
 arch/arm/mach-s3c64xx/common.c | 10 ++++++++++
 arch/arm/mach-s5p64x0/common.c | 10 ++++++++++
 arch/arm/mach-s5pc100/common.c | 10 ++++++++++
 arch/arm/mach-s5pv210/common.c | 10 ++++++++++
 6 files changed, 60 insertions(+)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index a8570bf..b65229d 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/of.h>
@@ -378,6 +379,13 @@ void __init exynos_init_io(struct map_desc *mach_desc, int size)
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
 
+static struct samsung_pwm_variant exynos4_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
 static void __init exynos4_map_io(void)
 {
 	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
@@ -419,6 +427,8 @@ static void __init exynos4_map_io(void)
 	s5p_hdmi_setname("exynos4-hdmi");
 
 	s3c64xx_spi_setname("exynos4210-spi");
+
+	samsung_device_pwm.dev.platform_data = &exynos4_pwm_variant;
 }
 
 static void __init exynos5_map_io(void)
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index d97533d..a01cccb 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -216,6 +217,13 @@ static void s3c24xx_default_idle(void)
 		     S3C2410_CLKCON);
 }
 
+static struct samsung_pwm_variant s3c24xx_pwm_variant = {
+	.bits		= 16,
+	.div_base	= 1,
+	.has_tint_cstat	= false,
+	.tclk_mask	= (1 << 4),
+};
+
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
 	arm_pm_idle = s3c24xx_default_idle;
@@ -232,6 +240,8 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	s3c24xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_device_pwm.dev.platform_data = &s3c24xx_pwm_variant;
 }
 
 /* Serial port registrations */
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 0b9c0ba..89d2823 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -26,6 +26,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
+#include <clocksource/samsung_pwm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -148,6 +149,13 @@ static struct device s3c64xx_dev = {
 	.bus	= &s3c64xx_subsys,
 };
 
+static struct samsung_pwm_variant s3c64xx_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
+};
+
 /* read cpu identification code */
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
@@ -160,6 +168,8 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	s3c64xx_init_cpu();
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_device_pwm.dev.platform_data = &s3c64xx_pwm_variant;
 }
 
 static __init int s3c64xx_dev_init(void)
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 8ae5800..cef1d3a 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
@@ -156,6 +157,13 @@ static void s5p64x0_idle(void)
 	cpu_do_idle();
 }
 
+static struct samsung_pwm_variant s5p64x0_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
 /*
  * s5p64x0_map_io
  *
@@ -173,6 +181,8 @@ void __init s5p64x0_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P64X0_SYS_ID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_device_pwm.dev.platform_data = &s5p64x0_pwm_variant;
 }
 
 void __init s5p6440_map_io(void)
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index cc6e561..3ccbd43 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/serial_core.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 
@@ -131,6 +132,13 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 	}
 };
 
+static struct samsung_pwm_variant s5pc100_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
 /*
  * s5pc100_map_io
  *
@@ -148,6 +156,8 @@ void __init s5pc100_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_device_pwm.dev.platform_data = &s5pc100_pwm_variant;
 }
 
 void __init s5pc100_map_io(void)
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 9dfe93e..bfd918f 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/device.h>
+#include <clocksource/samsung_pwm.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
@@ -148,6 +149,13 @@ void s5pv210_restart(char mode, const char *cmd)
 	__raw_writel(0x1, S5P_SWRESET);
 }
 
+static struct samsung_pwm_variant s5pv210_pwm_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
 /*
  * s5pv210_map_io
  *
@@ -165,6 +173,8 @@ void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P_VA_CHIPID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	samsung_device_pwm.dev.platform_data = &s5pv210_pwm_variant;
 }
 
 void __init s5pv210_map_io(void)
-- 
1.8.1.5
