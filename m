From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 06 Mar 2014 12:28:24 +0900
Subject: [PATCH 01/02] ARM: shmobile: Add shared shmobile_init_delay()
In-Reply-To: <20140306032814.10814.2949.sendpatchset@w520>
References: <20140306032814.10814.2949.sendpatchset@w520>
Message-ID: <20140306032824.10814.21953.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce shmobile_init_delay() that gets CPU specific
parameters from DT and sets up the early delay from
there. This allows us to both remove frequency information
from the C code and consolidate existing code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/timer.c               |   28 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2014-03-06 12:06:03.000000000 +0900
@@ -4,6 +4,7 @@
 extern void shmobile_earlytimer_init(void);
 extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 			 unsigned int mult, unsigned int div);
+extern void shmobile_init_delay(void);
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_boot_vector(void);
--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2014-03-06 12:06:03.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/delay.h>
+#include <linux/of_address.h>
 
 void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 				 unsigned int mult, unsigned int div)
@@ -39,6 +40,33 @@ void __init shmobile_setup_delay(unsigne
 		preset_lpj = max_cpu_core_mhz * value;
 }
 
+void __init shmobile_init_delay(void)
+{
+	struct device_node *np, *parent;
+	u32 max_freq, freq;
+
+	max_freq = 0;
+
+	parent = of_find_node_by_path("/cpus");
+	if (parent) {
+		for_each_child_of_node(parent, np) {
+			if (!of_property_read_u32(np, "clock-frequency", &freq))
+				max_freq = max(max_freq, freq);
+		}
+		of_node_put(parent);
+	}
+
+	if (max_freq) {
+		if (of_find_compatible_node(NULL, NULL, "arm,cortex-a8"))
+			shmobile_setup_delay(max_freq, 1, 3);
+		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
+			shmobile_setup_delay(max_freq, 1, 3);
+		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a15"))
+			if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
+				shmobile_setup_delay(max_freq, 2, 4);
+	}
+}
+
 static void __init shmobile_late_time_init(void)
 {
 	/*
