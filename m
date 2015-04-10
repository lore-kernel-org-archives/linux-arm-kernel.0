From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:17:11 +0200
Subject: [PATCH] cpufreq: fix qoriq uniprocessor build
Message-ID: <8186394.6fcP6P730e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qoriq-cpufreq driver contains a hack for powerpc to include
asm/smp.h on uniprocessor builds so it can get the hardware CPU
number. On ARM, it does not require this hack, but instead gets
a compile error:

In file included from drivers/cpufreq/qoriq-cpufreq.c:24:0:
arch/arm/include/asm/smp.h:18:3: error: #error "<asm/smp.h> included in non-SMP build"
arch/arm/include/asm/smp.h:21:0: warning: "raw_smp_processor_id" redefined

This adds an #ifdef to mirror the one in its get_cpu_physical_id()
function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2f249358eedaf ("cpufreq: qoriq: rename the driver")
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 9fd51c860308..88b21ae0d6b0 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -21,7 +21,9 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 
+#if !defined(CONFIG_ARM)
 #include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
+#endif
 
 /**
  * struct cpu_data
