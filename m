From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:23:53 +0100
Subject: [PATCHv3 1/9] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
References: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1436181842-19402-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable sharing of the arm_pmu code with arm64, this patch factors it
out to drivers/perf/. A new drivers/perf directory is added for
performance monitor drivers to live under.

MAINTAINERS is updated accordingly. Files added previously without a
corresponsing MAINTAINERS update (perf_regs.c, perf_callchain.c, and
perf_event.h) are also added.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS                                                |  6 ++++--
 arch/arm/Kconfig                                           |  8 ++------
 arch/arm/kernel/Makefile                                   |  3 +--
 arch/arm/kernel/perf_event_v6.c                            |  2 +-
 arch/arm/kernel/perf_event_v7.c                            |  2 +-
 arch/arm/kernel/perf_event_xscale.c                        |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c                           |  2 +-
 drivers/Kconfig                                            |  2 ++
 drivers/Makefile                                           |  1 +
 drivers/perf/Kconfig                                       | 14 ++++++++++++++
 drivers/perf/Makefile                                      |  1 +
 arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c     |  2 +-
 arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h |  4 ++--
 13 files changed, 32 insertions(+), 17 deletions(-)
 create mode 100644 drivers/perf/Kconfig
 create mode 100644 drivers/perf/Makefile
 rename arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c (99%)
 rename arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..9a84408 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -799,11 +799,13 @@ F:	arch/arm/include/asm/floppy.h
 ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
 S:	Maintained
-F:	arch/arm/kernel/perf_event*
+F:	arch/arm/kernel/perf_*
 F:	arch/arm/oprofile/common.c
-F:	arch/arm/include/asm/pmu.h
 F:	arch/arm/kernel/hw_breakpoint.c
 F:	arch/arm/include/asm/hw_breakpoint.h
+F:	arch/arm/include/asm/perf_event.h
+F:	drivers/perf/arm_pmu.c
+F:	include/linux/perf/arm_pmu.h
 
 ARM PORT
 M:	Russell King <linux@arm.linux.org.uk>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..3ba066e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1695,12 +1695,8 @@ config HIGHPTE
 	depends on HIGHMEM
 
 config HW_PERF_EVENTS
-	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS
-	default y
-	help
-	  Enable hardware performance counter support for perf events. If
-	  disabled, perf events will use software events only.
+	def_bool y
+	depends on ARM_PMU
 
 config SYS_SUPPORTS_HUGETLBFS
        def_bool y
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index e69f7a1..fcb25c1 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -71,8 +71,7 @@ obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o \
-				   perf_event_xscale.o perf_event_v6.o \
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
 				   perf_event_v7.o
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 09f83e4..09413e7 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -34,9 +34,9 @@
 
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
-#include <asm/pmu.h>
 
 #include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 
 enum armv6_perf_types {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f9b37f8..126dc67 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -21,11 +21,11 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
-#include <asm/pmu.h>
 #include <asm/vfp.h>
 #include "../vfp/vfpinstr.h"
 
 #include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 304d056..aa0499e 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -16,9 +16,9 @@
 
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
-#include <asm/pmu.h>
 
 #include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 
 enum xscale_perf_types {
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 1691380..5578dc1 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -20,10 +20,10 @@
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/regulator/machine.h>
 #include <linux/random.h>
 
-#include <asm/pmu.h>
 #include <asm/mach/map.h>
 
 #include "setup.h"
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 6e973b8..3497485 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -176,6 +176,8 @@ source "drivers/powercap/Kconfig"
 
 source "drivers/mcb/Kconfig"
 
+source "drivers/perf/Kconfig"
+
 source "drivers/ras/Kconfig"
 
 source "drivers/thunderbolt/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index b64b49f..f245f22 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -161,6 +161,7 @@ obj-$(CONFIG_NTB)		+= ntb/
 obj-$(CONFIG_FMC)		+= fmc/
 obj-$(CONFIG_POWERCAP)		+= powercap/
 obj-$(CONFIG_MCB)		+= mcb/
+obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
new file mode 100644
index 0000000..f556b92ae
--- /dev/null
+++ b/drivers/perf/Kconfig
@@ -0,0 +1,14 @@
+#
+# Performance Monitor Drivers
+#
+
+menu "Performance monitor support"
+
+config ARM_PMU
+	depends on PERF_EVENTS && ARM
+	bool "ARM PMU framework"
+	default y
+	help
+	  Say y if you want to use performance monitors on ARM systems.
+
+endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
new file mode 100644
index 0000000..acd2397
--- /dev/null
+++ b/drivers/perf/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM_PMU) += arm_pmu.o
diff --git a/arch/arm/kernel/perf_event.c b/drivers/perf/arm_pmu.c
similarity index 99%
rename from arch/arm/kernel/perf_event.c
rename to drivers/perf/arm_pmu.c
index 357f57e..daf0a0d 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/drivers/perf/arm_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -24,7 +25,6 @@
 
 #include <asm/cputype.h>
 #include <asm/irq_regs.h>
-#include <asm/pmu.h>
 
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
diff --git a/arch/arm/include/asm/pmu.h b/include/linux/perf/arm_pmu.h
similarity index 98%
rename from arch/arm/include/asm/pmu.h
rename to include/linux/perf/arm_pmu.h
index 3fc87df..bfa673b 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -30,7 +30,7 @@ struct arm_pmu_platdata {
 				  irq_handler_t pmu_handler);
 };
 
-#ifdef CONFIG_HW_PERF_EVENTS
+#ifdef CONFIG_ARM_PMU
 
 /*
  * The ARMv7 CPU PMU supports up to 32 event counters.
@@ -149,6 +149,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
 
-#endif /* CONFIG_HW_PERF_EVENTS */
+#endif /* CONFIG_ARM_PMU */
 
 #endif /* __ARM_PMU_H__ */
-- 
1.9.1
