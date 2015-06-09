From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  9 Jun 2015 14:33:42 +0100
Subject: [PATCH v2 1/3] ARM: STi: Add code to release secondary cores from
 holding pen.
In-Reply-To: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433856824-30689-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most upstream devs boot STi platform via JTAG which abuses the
boot process by setting the PC of secondary cores directly. As
a consquence, booting STi platforms via u-boot results in only
the primary core being brought up as the code to manage the
holding pen is not upstream.

This patch adds the necessary code to bring the secondary cores
out of the holding pen. It uses the cpu-release-addr DT property
to get the address of the holding pen from the bootloader.

With this patch booting upstream kernels via u-boot works
correctly:

[    0.045456] CPU: Testing write buffer coherency: ok
[    0.045597] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.045734] Setting up static identity map for 0x40209000 - 0x40209098
[    0.065047] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.065081] Brought up 2 CPUs
[    0.065089] SMP: Total of 2 processors activated (5983.43 BogoMIPS).
[    0.065092] CPU: All CPU(s) started in SVC mode.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/mach-sti/headsmp.S |  1 +
 arch/arm/mach-sti/platsmp.c | 55 ++++++++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-sti/smp.h     |  2 ++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
index 4c09bae..e0ad4517 100644
--- a/arch/arm/mach-sti/headsmp.S
+++ b/arch/arm/mach-sti/headsmp.S
@@ -37,6 +37,7 @@ pen:	ldr	r7, [r6]
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
+ENDPROC(sti_secondary_startup)
 
 1:	.long	.
 	.long	pen_release
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index d4b624f..86bb48d8 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -99,14 +100,62 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
-	void __iomem *scu_base = NULL;
-	struct device_node *np = of_find_compatible_node(
-					NULL, NULL, "arm,cortex-a9-scu");
+	struct device_node *np;
+	void __iomem *scu_base;
+	u32 __iomem *cpu_strt_ptr;
+	u32 release_phys;
+	int cpu;
+	unsigned long entry_pa = virt_to_phys(sti_secondary_startup);
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+
 	if (np) {
 		scu_base = of_iomap(np, 0);
 		scu_enable(scu_base);
 		of_node_put(np);
 	}
+
+	if (max_cpus <= 1)
+		return;
+
+	for_each_possible_cpu(cpu) {
+
+		np = of_get_cpu_node(cpu, NULL);
+
+		if (!np)
+			continue;
+
+		if (of_property_read_u32(np, "cpu-release-addr",
+						&release_phys)) {
+			pr_err("CPU %d: missing or invalid cpu-release-addr "
+				"property\n", cpu);
+			continue;
+		}
+
+		/*
+		 * holding pen is usually configured in SBC DMEM but can also be
+		 * in RAM.
+		 */
+
+		if (!memblock_is_memory(release_phys))
+			cpu_strt_ptr =
+				ioremap(release_phys, sizeof(release_phys));
+		else
+			cpu_strt_ptr =
+				(u32 __iomem *)phys_to_virt(release_phys);
+
+		__raw_writel(entry_pa, cpu_strt_ptr);
+
+		/*
+		 * wmb so that data is actually written
+		 * before cache flush is done
+		 */
+		smp_wmb();
+		sync_cache_w(cpu_strt_ptr);
+
+		if (!memblock_is_memory(release_phys))
+			iounmap(cpu_strt_ptr);
+	}
 }
 
 struct smp_operations __initdata sti_smp_ops = {
diff --git a/arch/arm/mach-sti/smp.h b/arch/arm/mach-sti/smp.h
index 1871b72..ae22707 100644
--- a/arch/arm/mach-sti/smp.h
+++ b/arch/arm/mach-sti/smp.h
@@ -14,4 +14,6 @@
 
 extern struct smp_operations	sti_smp_ops;
 
+void sti_secondary_startup(void);
+
 #endif
-- 
1.9.1
