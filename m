From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:52:11 +0900
Subject: [PATCH 02/05] ARM: shmobile: r8a73a4 CPU Hotplug prototype v1 (CA15 x
 4)
In-Reply-To: <20130530085152.24374.64208.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
Message-ID: <20130530085211.24374.15664.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CPU Hotplug prototype support for 4 x Cortex-A15
included in r8a73a4.

Needs a rewrite to support more generic handling of
CPU core power domains. Not ready for merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Developed and tested on top of v3.10-rc2, depends on
 "[PATCH] ARM: shmobile: r8a73a4 SMP prototype v1 (CA15 x 4)"

 arch/arm/mach-shmobile/smp-r8a73a4.c |   88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

--- 0005/arch/arm/mach-shmobile/smp-r8a73a4.c
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-05-22 13:34:18.000000000 +0900
@@ -36,6 +36,8 @@
 
 #define APMU	0xe6150000
 #define CA15WUPCR 0x2010
+#define CA15PSTR 0x2040
+#define CA15CPUNCR(n) (0x2100 + (0x10 * (n))) 
 
 #define MERAM	0xe8080000
 #define CCI_BASE	0xf0190000
@@ -83,7 +85,93 @@ static int __cpuinit r8a73a4_boot_second
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int r8a73a4_cpu_kill(unsigned int cpu)
+{
+	void __iomem *p;
+	int ret = 0;
+	int k;
+
+	/* this function is running on another CPU than the offline target,
+	 * here all we need to do is to wait for the SoC to enter sleep mode.
+	 */
+	p = ioremap_nocache(APMU, 0x3000);
+	for (k = 0; k < 1000; k++) {
+		if (((__raw_readl(p + CA15PSTR) >> (cpu * 4)) & 0x03) == 3) {
+			ret = 1;
+			break;
+		}
+
+		mdelay(1);
+	}
+	iounmap(p);
+
+	return ret;
+}
+
+/* nicked from arch/arm/mach-exynos/hotplug.c */
+static inline void cpu_enter_lowpower_a15(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+
+	flush_cache_louis();
+
+	asm volatile(
+	/*
+	* Turn off coherency
+	*/
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (0x40)
+	: "cc");
+
+	isb();
+	dsb();
+}
+
+static int r8a73a4_do_idle_core_standby(unsigned long unused)
+{
+	cpu_do_idle(); /* WFI triggers Core Standby */
+	return 0;
+}
+
+static void r8a73a4_cpu_die(unsigned int cpu)
+{
+	void __iomem *p;
+
+	/* hardware shutdown code running on the CPU that is being offlined */
+
+	/* select CPU shutdown mode */
+	p = ioremap_nocache(APMU, 0x3000);
+	__raw_writel(3, p + CA15CPUNCR(cpu)); /* CA15 Core Standby */
+	iounmap(p);
+
+	cpu_enter_lowpower_a15();
+	cpu_suspend(0, r8a73a4_do_idle_core_standby); /* really needed? */
+}
+
+static int r8a73a4_cpu_disable(unsigned int cpu)
+{
+	return 0; /* hotplug of any CPU is tested OK */
+}
+#endif
+
 struct smp_operations r8a73a4_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a73a4_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a73a4_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= r8a73a4_cpu_kill,
+	.cpu_die		= r8a73a4_cpu_die,
+	.cpu_disable		= r8a73a4_cpu_disable,
+#endif
 };
