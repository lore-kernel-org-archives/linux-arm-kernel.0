From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue,  7 Dec 2010 20:28:20 -0800
Subject: [PATCH v2 5/6] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1291782501-3909-6-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Makefile  |    2 +
 arch/arm/mach-msm/hotplug.c |  103 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/hotplug.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 34cd0a8..7a11b4a 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
 
+obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
+
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o devices-msm7x00.o
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
new file mode 100644
index 0000000..59c1dfa
--- /dev/null
+++ b/arch/arm/mach-msm/hotplug.c
@@ -0,0 +1,103 @@
+/*
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+#include <linux/irq.h>
+
+#include <asm/cacheflush.h>
+
+#include <mach/smp.h>
+
+static DECLARE_COMPLETION(cpu_killed);
+
+static inline void cpu_enter_lowpower(void)
+{
+	flush_cache_all();
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	pen_release = -1;
+	smp_wmb();
+}
+
+static inline void platform_do_lowpower(unsigned int cpu)
+{
+	/* Just enter wfe for now. */
+	for (;;) {
+		asm("wfe");
+		if (pen_release == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+		smp_rmb();
+
+		/*
+		 * getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * The trouble is, letting people know about this is not really
+		 * possible, since we are currently running incoherently, and
+		 * therefore cannot safely call printk() or anything else
+		*/
+		pr_debug("CPU%u: spurious wakeup call\n", cpu);
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return wait_for_completion_timeout(&cpu_killed, 50000);
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+#ifdef DEBUG
+	unsigned int this_cpu = hard_smp_processor_id();
+
+	if (cpu != this_cpu) {
+		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
+			   this_cpu, cpu);
+		BUG();
+	}
+#endif
+
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
