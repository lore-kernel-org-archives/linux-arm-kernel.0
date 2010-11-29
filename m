From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 29 Nov 2010 10:54:35 +0100
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu hotplug
In-Reply-To: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
Message-ID: <AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extracts the common code of the cpu hotplug feature across
arm platforms. The goal is to only keep the specific stuff of the
platform in the sub-architecture. I have created a hotplug.c file in
the ?arm/common directory after studying the cpu hotplug code of
omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
platform dependent functions:
?-platform_enter_lowpower which prepares the platform for low power.
?-platform_do_lowpower on which the cpu will loop until it becomes
really plugged (spurious wake up). This function must returned the cpu
Id in order to leave the unplug state.
?-platform_leave_lowpower which restore the platform context.

?An ux500 patch is available which uses the common/hotplug.c code.
This patch is quite short because the idle / power down functions are
not yet upstreamed


Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
?arch/arm/common/Kconfig ? ? ? ?| ? ?4 ++
?arch/arm/common/Makefile ? ? ? | ? ?1 +
?arch/arm/common/hotplug.c ? ? ?| ? 85 ++++++++++++++++++++++++++++++++++++++++
?arch/arm/include/asm/hotplug.h | ? ?8 ++++
?4 files changed, 98 insertions(+), 0 deletions(-)
?create mode 100644 arch/arm/common/hotplug.c
?create mode 100644 arch/arm/include/asm/hotplug.h

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..b1c5f6b 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -41,3 +41,7 @@ config SHARP_SCOOP
?config COMMON_CLKDEV
? ? ? ?bool
? ? ? ?select HAVE_CLK
+
+config USE_COMMON_ARM_HOTPLUG
+ ? ? ? bool
+ ? ? ? depends on HOTPLUG_CPU
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e6e8664..d8a66d7 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000) ? ?+= uengine.o
?obj-$(CONFIG_ARCH_IXP23XX) ? ? += uengine.o
?obj-$(CONFIG_PCI_HOST_ITE8152) ?+= it8152.o
?obj-$(CONFIG_COMMON_CLKDEV) ? ?+= clkdev.o
+obj-$(CONFIG_USE_COMMON_ARM_HOTPLUG) ? ? ? ? ? += hotplug.o
diff --git a/arch/arm/common/hotplug.c b/arch/arm/common/hotplug.c
new file mode 100644
index 0000000..05f39f9
--- /dev/null
+++ b/arch/arm/common/hotplug.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ * ? ? Based on ARM realview platform
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: Vincent Guittot <vincent.guittot@stericsson.com>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <asm/cacheflush.h>
+#include <asm/hotplug.h>
+
+static DECLARE_COMPLETION(cpu_killed);
+
+int platform_cpu_kill(unsigned int cpu)
+{
+ ? ? ? int err;
+ ? ? ? err = wait_for_completion_timeout(&cpu_killed, 5000);
+#ifdef DEBUG
+ ? ? ? printk(KERN_INFO "platform_cpu_kill %d err %d\n", cpu, err);
+#endif
+ ? ? ? return err;
+}
+
+/*
+ * architecture-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+ ? ? ? unsigned long spurious = 0;
+#ifdef DEBUG
+ ? ? ? unsigned int this_cpu = hard_smp_processor_id();
+
+ ? ? ? if (cpu != this_cpu) {
+ ? ? ? ? ? ? ? printk(KERN_CRIT "Eek! platform_cpu_die running on %u,
should be %u\n",
+ ? ? ? ? ? ? ? ? ? ? ? ? ?this_cpu, cpu);
+ ? ? ? ? ? ? ? BUG();
+ ? ? ? }
+
+ ? ? ? printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+#endif
+ ? ? ? complete(&cpu_killed);
+
+ ? ? ? flush_cache_all();
+ ? ? ? wmb();
+
+ ? ? ? platform_enter_lowpower(cpu);
+
+ ? ? ? for (;;) {
+
+ ? ? ? ? ? ? ? if (platform_do_lowpower(cpu) == cpu) {
+ ? ? ? ? ? ? ? ? ? ? ? /*
+ ? ? ? ? ? ? ? ? ? ? ? ?* OK, proper wakeup, we're done
+ ? ? ? ? ? ? ? ? ? ? ? ?*/
+ ? ? ? ? ? ? ? ? ? ? ? break;
+ ? ? ? ? ? ? ? }
+ ? ? ? ? ? ? ? spurious++;
+ ? ? ? }
+
+ ? ? ? platform_leave_lowpower(cpu);
+
+#ifdef DEBUG
+ ? ? ? printk(KERN_NOTICE "CPU%u: wake up (%lu spurious wake up)\n",
+ ? ? ? ? ? ? ? ? ? ? ? cpu, spurious);
+#endif
+
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+ ? ? ? /*
+ ? ? ? ?* we don't allow CPU 0 to be shutdown (it is still too special
+ ? ? ? ?* e.g. clock tick interrupts)
+ ? ? ? ?*/
+ ? ? ? return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/include/asm/hotplug.h b/arch/arm/include/asm/hotplug.h
new file mode 100644
index 0000000..b38e737
--- /dev/null
+++ b/arch/arm/include/asm/hotplug.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_HOTPLUG_H
+#define __ASM_MACH_HOTPLUG_H
+
+extern void platform_enter_lowpower(unsigned int cpu);
+extern int platform_do_lowpower(unsigned int cpu);
+extern void platform_leave_lowpower(unsigned int cpu);
+
+#endif
--
1.7.0.4
