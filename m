From: aford173@gmail.com (Adam Ford)
Date: Sat,  9 Sep 2017 07:05:09 -0500
Subject: [PATCH] davinci: Add cpufreq support when booting with device tree
Message-ID: <1504958709-23357-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While cpufreq itself doesn't appear to directly support the
device tree, we can register it inside da850_init_machine
when we register other devices.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 5699ce3..57e2ade 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -14,6 +14,7 @@
 #include <linux/platform_data/ti-aemif.h>
 
 #include <asm/mach/arch.h>
+#include <asm/system_info.h>
 
 #include <mach/common.h>
 #include "cp_intc.h"
@@ -57,6 +58,28 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	{}
 };
 
+#ifdef CONFIG_CPU_FREQ
+static __init int da850_init_cpufreq(void)
+{
+	switch (system_rev & 0xF) {
+	case 3:
+		da850_max_speed = 456000;
+		break;
+	case 2:
+		da850_max_speed = 408000;
+		break;
+	case 1:
+		da850_max_speed = 372000;
+		break;
+	}
+
+	return da850_register_cpufreq("pll0_sysclk3");
+}
+#else
+static __init int da850_init_cpufreq(void) { return 0; }
+#endif
+
+
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
@@ -80,6 +103,10 @@ static void __init da850_init_machine(void)
 		pr_warn("%s: registering SATA REFCLK failed: %d",
 			__func__, ret);
 
+	ret = da850_init_cpufreq();
+	if (ret)
+		pr_warn("%s: cpufreq registration failed: %d\n", __func__, ret);
+
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 	davinci_pm_init();
 	pdata_quirks_init();
-- 
2.7.4
