From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 29 Jun 2016 15:58:19 +0200
Subject: [RFC PATCH v1] ARM: tango: add Suspend-to-RAM support
Message-ID: <5773D3FB.4030101@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ask firmware to put RAM in self-refresh mode and power system down.

    echo mem > /sys/power/state

See Documentation/power/states.txt

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
This is a RFC because I have a few doubts:
1) return value when tango_suspend() fails and unexpectedly returns (I used -EIO)
2) conditionally building pm.c (using CONFIG_SUSPEND? CONFIG_PM_SLEEP? other?)
3) .valid is required, right?
---
 arch/arm/mach-tango/Makefile |  1 +
 arch/arm/mach-tango/pm.c     | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tango/smc.h    |  1 +
 3 files changed, 39 insertions(+)
 create mode 100644 arch/arm/mach-tango/pm.c

diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
index 7ca753aa9fb6..822b7ca803c6 100644
--- a/arch/arm/mach-tango/Makefile
+++ b/arch/arm/mach-tango/Makefile
@@ -3,3 +3,4 @@ AFLAGS_smc.o := -Wa,-march=armv7-a$(plus_sec)
 
 obj-y += setup.o smc.o xenv.o
 obj-$(CONFIG_SMP) += platsmp.o
+obj-$(CONFIG_SUSPEND) += pm.o
diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
new file mode 100644
index 000000000000..08a39beaea09
--- /dev/null
+++ b/arch/arm/mach-tango/pm.c
@@ -0,0 +1,37 @@
+#include <linux/init.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include "smc.h"
+
+static int tango_pm_powerdown(unsigned long arg)
+{
+	tango_suspend(virt_to_phys(cpu_resume));
+
+	return -EIO; /* tango_suspend has failed */
+}
+
+static int tango_pm_enter(suspend_state_t state)
+{
+	if (state == PM_SUSPEND_MEM)
+		return cpu_suspend(0, tango_pm_powerdown);
+
+	return -EINVAL;
+}
+
+static int tango_pm_valid(suspend_state_t state)
+{
+	return state == PM_SUSPEND_MEM;
+}
+
+static const struct platform_suspend_ops tango_pm_ops = {
+	.enter = tango_pm_enter,
+	.valid = tango_pm_valid,
+};
+
+static int __init tango_pm_init(void)
+{
+	suspend_set_ops(&tango_pm_ops);
+	return 0;
+}
+
+late_initcall(tango_pm_init);
diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
index 3d31f984f44c..57919539da1b 100644
--- a/arch/arm/mach-tango/smc.h
+++ b/arch/arm/mach-tango/smc.h
@@ -3,5 +3,6 @@ extern int tango_smc(unsigned int val, unsigned int service);
 #define tango_set_l2_control(val)	tango_smc(val, 0x102)
 #define tango_start_aux_core(val)	tango_smc(val, 0x104)
 #define tango_set_aux_boot_addr(val)	tango_smc(val, 0x105)
+#define tango_suspend(val)		tango_smc(val, 0x120)
 #define tango_aux_core_die(val)		tango_smc(val, 0x121)
 #define tango_aux_core_kill(val)	tango_smc(val, 0x122)
-- 
2.9.0
