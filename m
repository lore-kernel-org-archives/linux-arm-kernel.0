From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 13 Jan 2013 02:10:55 +0100
Subject: [PATCH 3/6] ARM: s3c64xx: Add support for OF-based VIC initialization
In-Reply-To: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1358039458-31960-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies IRQ initialization code of S3C64xx to support
Device Tree-based initialization of VICs.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/common.c | 16 ++++++++++++++++
 arch/arm/mach-s3c64xx/common.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index aef303b..b9c5bec 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of_irq.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -181,6 +182,21 @@ core_initcall(s3c64xx_dev_init);
 			 1 << (IRQ_HSMMC1 - IRQ_VIC1_BASE) |	\
 			 1 << (IRQ_HSMMC2 - IRQ_VIC1_BASE))
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c64xx_dt_irq_match[] = {
+	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
+	{},
+};
+
+void __init s3c64xx_of_init_irq(void)
+{
+	of_irq_init(s3c64xx_dt_irq_match);
+
+	/* FIXME: add the timer sub-irqs */
+	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
+}
+#endif
+
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 6cfc99b..711f3e0 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -58,4 +58,8 @@ int __init s3c64xx_pm_late_initcall(void);
 static inline int s3c64xx_pm_late_initcall(void) { return 0; }
 #endif
 
+#ifdef CONFIG_OF
+extern void s3c64xx_of_init_irq(void);
+#endif
+
 #endif /* __ARCH_ARM_MACH_S3C64XX_COMMON_H */
-- 
1.8.1
