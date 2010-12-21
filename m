From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 21 Dec 2010 17:36:21 +0900
Subject: [RFC][PATCH] Samsung SoC: Hibernation Initial Support
In-Reply-To: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
References: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1292920581-12655-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hibernation (aka 'suspend to disk') support for Samsung SoCs.

This patch is based on the hibernation support for ARM (i.e.,
"ARM: Add initial hibernation support for Cortex A8 and A9").
This patch is tested with S5PC210.

This patch provides the followings in order to enable hibernation in
Samsung SoCs.

1. Support call-backs for machine-specific hibernation codes.
2. Save and restore common registers (GPIO, UART, and CORE).
3. Set default struct platofrm_hibernation_ops

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/plat-samsung/include/plat/pm.h |    5 ++
 arch/arm/plat-samsung/pm.c              |   67 +++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 245836d..4b78a83 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -40,6 +40,11 @@ extern unsigned long s3c_irqwake_eintallow;
 extern void (*pm_cpu_prep)(void);
 extern void (*pm_cpu_sleep)(void);
 
+#ifdef CONFIG_HIBERNATION
+extern void (*hb_cpu_begin)(void);
+extern void (*hb_cpu_end)(void);
+#endif
+
 /* Flags for PM Control */
 
 extern unsigned long s3c_pm_flags;
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 27cfca5..e7c0df5 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
+#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <mach/hardware.h>
@@ -232,6 +233,11 @@ static void s3c_pm_show_resume_irqs(int start, unsigned long which,
 void (*pm_cpu_prep)(void);
 void (*pm_cpu_sleep)(void);
 
+#ifdef CONFIG_HIBERNATION
+void (*hb_cpu_begin)(void);
+void (*hb_cpu_end)(void);
+#endif
+
 #define any_allowed(mask, allow) (((mask) & (allow)) != (allow))
 
 /* s3c_pm_enter
@@ -362,6 +368,64 @@ static struct platform_suspend_ops s3c_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+#ifdef CONFIG_HIBERNATION
+static int s3c_hb_begin(void)
+{
+	if (hb_cpu_begin)
+		hb_cpu_begin();
+
+	return 0;
+}
+
+static void s3c_hb_end(void)
+{
+	if (hb_cpu_end)
+		hb_cpu_end();
+}
+
+static int dummy_i(void)
+{
+	return 0;
+}
+
+static void dummy_v(void)
+{
+}
+
+static int s3c_hb_enter(void)
+{
+	kernel_power_off();
+	return 0;
+}
+
+static int s3c_hb_save_registers(void)
+{
+	s3c_pm_save_gpios();
+	s3c_pm_save_uarts();
+	s3c_pm_save_core();
+	return 0;
+}
+
+static void s3c_hb_restore_registers(void)
+{
+	s3c_pm_restore_core();
+	s3c_pm_restore_uarts();
+	s3c_pm_restore_gpios();
+}
+
+static const struct platform_hibernation_ops s3c_hibernation_ops = {
+	.begin		= s3c_hb_begin,
+	.end		= s3c_hb_end, /* TODO: seperate from PM */
+	.pre_snapshot	= s3c_hb_save_registers,
+	.prepare	= dummy_i,
+	.finish		= dummy_v,
+	.enter		= s3c_hb_enter,
+	.pre_restore	= dummy_i,
+	.restore_cleanup	= dummy_v,
+	.leave		= s3c_hb_restore_registers,
+};
+#endif
+
 /* s3c_pm_init
  *
  * Attach the power management functions. This should be called
@@ -374,5 +438,8 @@ int __init s3c_pm_init(void)
 	printk("S3C Power Management, Copyright 2004 Simtec Electronics\n");
 
 	suspend_set_ops(&s3c_pm_ops);
+#ifdef CONFIG_HIBERNATION
+	hibernation_set_ops(&s3c_hibernation_ops);
+#endif
 	return 0;
 }
-- 
1.7.1
