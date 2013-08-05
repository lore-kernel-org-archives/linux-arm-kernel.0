From: olof@lixom.net (Olof Johansson)
Date: Sun,  4 Aug 2013 21:09:51 -0700
Subject: [PATCH 1/3] ARM: vexpress: move spc driver back under mach-vexpress
In-Reply-To: <1375675793-16492-1-git-send-email-olof@lixom.net>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
Message-ID: <1375675793-16492-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we have tc2_pm platform code calling into exported driver functions,
which doesn't make sense at this level.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-vexpress/Makefile                         |  2 +-
 .../platform/vexpress => arch/arm/mach-vexpress}/spc.c  |  1 -
 arch/arm/mach-vexpress/tc2_pm.c                         |  3 ++-
 drivers/platform/Kconfig                                |  3 ---
 drivers/platform/Makefile                               |  1 -
 drivers/platform/vexpress/Kconfig                       |  9 ---------
 drivers/platform/vexpress/Makefile                      |  1 -
 include/linux/vexpress.h                                | 17 -----------------
 8 files changed, 3 insertions(+), 34 deletions(-)
 rename {drivers/platform/vexpress => arch/arm/mach-vexpress}/spc.c (99%)
 delete mode 100644 drivers/platform/vexpress/Kconfig
 delete mode 100644 drivers/platform/vexpress/Makefile

diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 0853da6..36ea824 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -7,6 +7,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
-obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
+obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/drivers/platform/vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
similarity index 99%
rename from drivers/platform/vexpress/spc.c
rename to arch/arm/mach-vexpress/spc.c
index aa8c2a4..34e4bf4 100644
--- a/drivers/platform/vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -250,4 +250,3 @@ int __init ve_spc_init(void)
 
 	return ve_spc_init_status;
 }
-early_initcall(ve_spc_init);
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index dfb55d4..79cf4bc 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -23,9 +23,10 @@
 #include <asm/cputype.h>
 #include <asm/cp15.h>
 
-#include <linux/vexpress.h>
 #include <linux/arm-cci.h>
 
+#include "spc.h"
+
 /*
  * We can't use regular spinlocks. In the switcher case, it is possible
  * for an outbound CPU to call power_down() after its inbound counterpart
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 449010e..57811ea 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -4,6 +4,3 @@ endif
 if GOLDFISH
 source "drivers/platform/goldfish/Kconfig"
 endif
-if ARCH_VEXPRESS
-source "drivers/platform/vexpress/Kconfig"
-endif
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index c1173d6..8a44a4c 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -5,4 +5,3 @@
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_OLPC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
-obj-$(CONFIG_ARCH_VEXPRESS)	+= vexpress/
diff --git a/drivers/platform/vexpress/Kconfig b/drivers/platform/vexpress/Kconfig
deleted file mode 100644
index d09a7c4..0000000
--- a/drivers/platform/vexpress/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-config VEXPRESS_SPC
-	bool "Versatile Express SPC driver support"
-	help
-	  The Serial Power Controller (SPC) for ARM Ltd. test chips, is
-	  an IP that provides a memory mapped interface to power controller
-	  HW. The driver provides an API abstraction meant to be used by
-	  subsystem drivers allowing to program registers controlling
-	  low-level power management features like power down flags,
-	  global and per-cpu wake-up IRQs.
diff --git a/drivers/platform/vexpress/Makefile b/drivers/platform/vexpress/Makefile
deleted file mode 100644
index d31eca2..0000000
--- a/drivers/platform/vexpress/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_VEXPRESS_SPC)	+= spc.o
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 3e35556..617c01b 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -124,21 +124,4 @@ void vexpress_osc_of_setup(struct device_node *node);
 void vexpress_clk_init(void __iomem *sp810_base);
 void vexpress_clk_of_init(void);
 
-/* SPC */
-
-#ifdef CONFIG_VEXPRESS_SPC
-int __init ve_spc_init(void);
-void ve_spc_global_wakeup_irq(bool set);
-void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
-void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
-u32 ve_spc_get_nr_cpus(u32 cluster);
-void ve_spc_powerdown(u32 cluster, bool enable);
-#else
-static inline int ve_spc_init(void) { return -ENODEV; }
-static inline void ve_spc_global_wakeup_irq(bool set) { }
-static inline void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set) { }
-static inline void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr) { }
-static inline u32 ve_spc_get_nr_cpus(u32 cluster) { return 0; }
-static inline void ve_spc_powerdown(u32 cluster, bool enable) { }
-#endif
 #endif
-- 
1.8.1.192.gc4361b8
