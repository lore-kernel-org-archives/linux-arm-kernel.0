From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:52:20 +0900
Subject: [PATCH 03/05] ARM: shmobile: r8a73a4 CA15 setup WFE as NOP
In-Reply-To: <20130530085152.24374.64208.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
Message-ID: <20130530085220.24374.94574.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Configure CA15 included in r8a73a4 to treat WFE as NOP.

This works around hardware issue found in APE6, needed
for CA7 cluster to work together with CA15 cluster.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a73a4.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- 0006/arch/arm/mach-shmobile/smp-r8a73a4.c
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-05-22 14:16:59.000000000 +0900
@@ -45,6 +45,20 @@
 #define CCI_SNOOP	0x0000
 #define CCI_STATUS	0x000c
 
+static inline void r8a73a4_execute_wfe_as_nop(void)
+{
+	unsigned int v;
+
+	/* set bit 7 in ACTLR */
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  :
+	  : "cc");
+}
+
 static void __init r8a73a4_smp_prepare_cpus(unsigned int max_cpus)
 {
 	u32 bar;
@@ -71,6 +85,8 @@ static void __init r8a73a4_smp_prepare_c
 	while (__raw_readl(p + CCI_STATUS))
 		/* wait for pending bit low */;
 	iounmap(p);
+
+	r8a73a4_execute_wfe_as_nop();
 }
 
 static int __cpuinit r8a73a4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -85,6 +101,13 @@ static int __cpuinit r8a73a4_boot_second
 	return 0;
 }
 
+static void __cpuinit r8a73a4_secondary_init(unsigned int cpu)
+{
+	/* CA15 need SW workaround */
+	if (cpu_logical_map(cpu) < 4)
+		r8a73a4_execute_wfe_as_nop();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int r8a73a4_cpu_kill(unsigned int cpu)
 {
@@ -169,6 +192,7 @@ static int r8a73a4_cpu_disable(unsigned
 struct smp_operations r8a73a4_smp_ops __initdata = {
 	.smp_prepare_cpus	= r8a73a4_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a73a4_boot_secondary,
+	.smp_secondary_init	= r8a73a4_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= r8a73a4_cpu_kill,
 	.cpu_die		= r8a73a4_cpu_die,
