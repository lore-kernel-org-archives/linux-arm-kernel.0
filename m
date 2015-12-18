From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:45:08 +0100
Subject: [PATCH] ARM: s3c: simplify s3c_irqwake_{e,}intallow definition
Message-ID: <16503982.4JeEM7ZXq8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a long time, gcc has warned about odd configurations on s3c64xx:

In file included from arch/arm/plat-samsung/pm.c:34:0:
arch/arm/mach-s3c64xx/include/mach/pm-core.h:61:0: warning: "s3c_irqwake_eintallow" redefined
 #define s3c_irqwake_eintallow ((1 << 28) - 1)
In file included from arch/arm/plat-samsung/pm.c:33:0:
arch/arm/plat-samsung/include/plat/pm.h:49:0: note: this is the location of the previous definition
 #define s3c_irqwake_eintallow 0

The definitions of s3c_irqwake_intallow and s3c_irqwake_eintallow are a bit consistent
between the various platforms. Things have become easier now that it's only s3c24xx
and s3c64xx that use them at all, so I've tried to rearrange the definitions to
make it more obvious what is going on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This fixes a very old and harmless warning, please apply to a cleanup branch
if you agree.

diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index 69459dbbdcad..712333fec589 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -85,3 +85,17 @@ static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 
 static inline void s3c_pm_restored_gpios(void) { }
 static inline void samsung_pm_saved_gpios(void) { }
+
+/* state for IRQs over sleep */
+
+/* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
+ *
+ * set bit to 1 in allow bitfield to enable the wakeup settings on it
+*/
+#ifdef CONFIG_PM_SLEEP
+#define s3c_irqwake_intallow	(1L << 30 | 0xfL)
+#define s3c_irqwake_eintallow	(0x0000fff0L)
+#else
+#define s3c_irqwake_eintallow 0
+#define s3c_irqwake_intallow  0
+#endif
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index b91341ef2b2e..417b7a20c2d1 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -25,19 +25,10 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
+#include <mach/pm-core.h>
 
 #include <asm/irq.h>
 
-/* state for IRQs over sleep */
-
-/* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
- *
- * set bit to 1 in allow bitfield to enable the wakeup settings on it
-*/
-
-unsigned long s3c_irqwake_intallow	= 1L << 30 | 0xfL;
-unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
-
 int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
 	unsigned long irqbit = 1 << data->hwirq;
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index 549dadd5f487..4a285e97afff 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -59,9 +59,13 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
 
 /* make these defines, we currently do not have any need to change
  * the IRQ wake controls depending on the CPU we are running on */
-
+#ifdef CONFIG_PM_SLEEP
 #define s3c_irqwake_eintallow	((1 << 28) - 1)
 #define s3c_irqwake_intallow	(~0)
+#else
+#define s3c_irqwake_eintallow 0
+#define s3c_irqwake_intallow  0
+#endif
 
 static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 					   struct pm_uart_save *save)
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 7f415ce74591..9dd562ab0841 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -41,14 +41,6 @@ static inline int s3c64xx_pm_init(void)
 extern unsigned long s3c_irqwake_intmask;
 extern unsigned long s3c_irqwake_eintmask;
 
-/* IRQ masks for IRQs allowed to go to sleep (see irq.c) */
-extern unsigned long s3c_irqwake_intallow;
-#ifdef CONFIG_PM_SLEEP
-extern unsigned long s3c_irqwake_eintallow;
-#else
-#define s3c_irqwake_eintallow 0
-#endif
-
 /* per-cpu sleep functions */
 
 extern void (*pm_cpu_prep)(void);
