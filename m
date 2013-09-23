From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 23 Sep 2013 09:22:10 +0100
Subject: [PATCH] ARM: STi: Add cpu hotplug support
Message-ID: <1379924530-26319-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds cpu hotplug support to STi series SoCs. This code is
cloned from arch/arm/mach-realview/hotplug.c.

STiH415 and STiH416 SOCs do not have power control lines wired up to
each core, so all we can do is to put the core into WFI for hotplug
support.

Tested on B2000 and B2020 boards with STiH415 and STiH416.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-sti/platsmp.c |  100 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index dce50d9..cdf9e2c 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include <asm/cp15.h>
 
 #include "smp.h"
 
@@ -110,8 +111,107 @@ void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_louis();
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	dsb\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0), "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		dsb();
+		wfi();
+
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void __ref sti_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 struct smp_operations __initdata sti_smp_ops = {
 	.smp_prepare_cpus	= sti_smp_prepare_cpus,
 	.smp_secondary_init	= sti_secondary_init,
 	.smp_boot_secondary	= sti_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= sti_cpu_die,
+#endif
 };
-- 
1.7.6.5
