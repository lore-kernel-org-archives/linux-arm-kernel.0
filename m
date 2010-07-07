From: eric.miao@canonical.com (Eric Miao)
Date: Wed, 7 Jul 2010 17:19:16 +0800
Subject: [PATCH RFC] Introduce one machine_desc instance and
	get_machine_desc()
Message-ID: <AANLkTinWPkI2zVCVw_yx87WVuAGZuWpBUuvGbxx_luIr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 5d5d90e5d41bb0842559dd2b00f00f2a0f532a3a
Author: Eric Miao <eric.miao@canonical.com>
Date:   Wed Jul 7 16:47:20 2010 +0800

    [ARM] Introduce one machine_desc instance and get_machine_desc()

    If some of the fields remains useful in 'struct machine_desc', it's
    normally a bit convenient to keep one instance there for reference.

    (along with more and more machine specific fields coming into this
    structure, e.g. pcibios_min_{io,mem})

    It also improves modularity a bit by not exporting variables like
    system_timer, init_arch_irq etc.

    However, the drawbacks are 1) a bit increased data and 2) increased
    risk of accessing those fields which are marked as __init.

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..e7454bb 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -57,4 +57,5 @@ static const struct machine_desc __mach_desc_##_type	\
 #define MACHINE_END				\
 };

+extern struct machine_desc *get_machine_desc(void);
 #endif
diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index 8920b2d..4a3118c 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -17,7 +17,6 @@ struct seq_file;
 /*
  * This is internal.  Do not use it.
  */
-extern void (*init_arch_irq)(void);
 extern void init_FIQ(void);
 extern int show_fiq_list(struct seq_file *, void *);

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 35d408f..883f6be 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -43,7 +43,6 @@ struct sys_timer {
 #endif
 };

-extern struct sys_timer *system_timer;
 extern void timer_tick(void);

 #endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3b3d2c8..a3a64e1 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>

 #include <asm/system.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>

@@ -47,7 +48,6 @@
 #define irq_finish(irq) do { } while (0)
 #endif

-void (*init_arch_irq)(void) __initdata = NULL;
 unsigned long irq_err_count;

 int show_interrupts(struct seq_file *p, void *v)
@@ -151,12 +151,14 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)

 void __init init_IRQ(void)
 {
+	struct machine_desc *mdesc = get_machine_desc();
 	int irq;

 	for (irq = 0; irq < NR_IRQS; irq++)
 		irq_desc[irq].status |= IRQ_NOREQUEST | IRQ_NOPROBE;

-	init_arch_irq();
+	if (mdesc->init_irq)
+		mdesc->init_irq();
 }

 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..cd6cfcb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -366,6 +366,13 @@ void cpu_init(void)
 	    : "r14");
 }

+static struct machine_desc m_desc;
+
+struct machine_desc *get_machine_desc(void)
+{
+	return &m_desc;
+}
+
 static struct machine_desc * __init setup_machine(unsigned int nr)
 {
 	struct machine_desc *list;
@@ -382,6 +389,7 @@ static struct machine_desc * __init
setup_machine(unsigned int nr)

 	printk("Machine: %s\n", list->name);

+	memcpy(&m_desc, list, sizeof(m_desc));
 	return list;
 }

@@ -652,13 +660,13 @@ static struct init_tags {
 	{ 0, ATAG_NONE }
 };

-static void (*init_machine)(void) __initdata;
-
 static int __init customize_machine(void)
 {
 	/* customizes platform devices, or adds new ones */
-	if (init_machine)
-		init_machine();
+	struct machine_desc *mdesc = get_machine_desc();
+
+	if (mdesc->init_machine)
+		mdesc->init_machine();
 	return 0;
 }
 arch_initcall(customize_machine);
@@ -726,13 +734,6 @@ void __init setup_arch(char **cmdline_p)
 	cpu_init();
 	tcm_init();

-	/*
-	 * Set up various architecture-specific pointers
-	 */
-	init_arch_irq = mdesc->init_irq;
-	system_timer = mdesc->timer;
-	init_machine = mdesc->init_machine;
-
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 38c261f..0ad86f2 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -30,12 +30,13 @@
 #include <asm/leds.h>
 #include <asm/thread_info.h>
 #include <asm/stacktrace.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/time.h>

 /*
  * Our system timer.
  */
-struct sys_timer *system_timer;
+static struct sys_timer *system_timer;

 #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
 /* this needs a better home */
@@ -160,6 +161,12 @@ device_initcall(timer_init_sysfs);

 void __init time_init(void)
 {
-	system_timer->init();
+	struct machine_desc *mdesc = get_machine_desc();
+
+	if (mdesc->timer) {
+		system_timer = mdesc->timer;
+		system_timer->init();
+	} else
+		panic("No system timer defined\n");
 }
