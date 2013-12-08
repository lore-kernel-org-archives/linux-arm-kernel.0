From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon,  9 Dec 2013 02:53:47 +0400
Subject: [PATCH 7/9] ARM: dts: pxa27x: skip static platform devices
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386543229-1542-8-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Static plaform devices are created from postcore_initcall(). The
status quo remains for non-device tree machines.

Device tree machine now have a chance to prevent spawning of static
devices by calling pxa27x_skip_init().

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/include/mach/pxa27x.h |  1 +
 arch/arm/mach-pxa/pxa27x.c              | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-pxa/include/mach/pxa27x.h b/arch/arm/mach-pxa/include/mach/pxa27x.h
index 7cff640..d62fc8f 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/pxa27x.h
@@ -23,6 +23,7 @@ extern void __init pxa27x_map_io(void);
 extern void __init pxa27x_init_irq(void);
 extern int __init pxa27x_set_pwrmode(unsigned int mode);
 extern void pxa27x_cpu_pm_enter(suspend_state_t state);
+extern void __init pxa27x_skip_init(void);
 
 #define pxa27x_handle_irq	ichp_handle_irq
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 301471a..98dea3a 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -452,6 +452,13 @@ static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_pwm1,
 };
 
+static unsigned int skip_init;
+
+void __init pxa27x_skip_init(void)
+{
+	skip_init = 1;
+}
+
 static int __init pxa27x_init(void)
 {
 	int ret = 0;
@@ -471,6 +478,9 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
+		if (skip_init)
+			return 0;
+
 		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
-- 
1.8.4.3
