From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 17 Dec 2013 23:37:35 +0400
Subject: [PATCH v3 05/21] ARM: dts: pxa27x: irq init using device tree
In-Reply-To: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Message-ID: <1387309071-22382-6-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v2..v3
   * no changes

   v1..v2
   * use of_have_populated_dt() instead of a static variable
   * drop #ifdef in header file
   * number changed from 8 to 5 (dropped patches)

 arch/arm/mach-pxa/include/mach/pxa27x.h |  1 +
 arch/arm/mach-pxa/pxa27x.c              | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-pxa/include/mach/pxa27x.h b/arch/arm/mach-pxa/include/mach/pxa27x.h
index 7cff640..34a4d6f 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/pxa27x.h
@@ -23,6 +23,7 @@ extern void __init pxa27x_map_io(void);
 extern void __init pxa27x_init_irq(void);
 extern int __init pxa27x_set_pwrmode(unsigned int mode);
 extern void pxa27x_cpu_pm_enter(suspend_state_t state);
+extern void __init pxa27x_dt_init_irq(void);
 
 #define pxa27x_handle_irq	ichp_handle_irq
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 301471a..c6b54f8 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -398,6 +398,13 @@ void __init pxa27x_init_irq(void)
 	pxa_init_irq(34, pxa27x_set_wake);
 }
 
+#ifdef CONFIG_OF
+void __init pxa27x_dt_init_irq(void)
+{
+	pxa_dt_irq_init(pxa27x_set_wake);
+}
+#endif  /* CONFIG_OF */
+
 static struct map_desc pxa27x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
@@ -471,6 +478,9 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
+		if (of_have_populated_dt())
+			return 0;
+
 		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
-- 
1.8.4.2
