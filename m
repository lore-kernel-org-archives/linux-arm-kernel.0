From: sentient@digitalfantasy.co.nz (Sentient)
Date: Tue, 17 Jul 2012 16:36:16 +1200
Subject: [PATCH 1/1]: Convert arch-vt8500 to use .restart and remove
 arch_reset()
In-Reply-To: <000a01cd63d4$2875fc90$7961f5b0$@digitalfantasy.co.nz>
References: <000a01cd63d4$2875fc90$7961f5b0$@digitalfantasy.co.nz>
Message-ID: <001801cd63d5$b48ebe50$1dac3af0$@digitalfantasy.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From e565f6c4245247978b8635b8f65ec6c67de6dfcd Mon Sep 17 00:00:00 2001
From: Tony Prisk <linux@prisktech.co.nz>
Date: Tue, 17 Jul 2012 06:25:05 +1200
Subject: [PATCH] Convert arch-vt8500 to use .restart and remove arch_reset()
Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

---
 arch/arm/mach-vt8500/Makefile               |    2 +-
 arch/arm/mach-vt8500/bv07.c                 |    3 +
 arch/arm/mach-vt8500/include/mach/restart.h |   17 ++++++++
 arch/arm/mach-vt8500/include/mach/system.h  |   13 ------
 arch/arm/mach-vt8500/restart.c              |   60
+++++++++++++++++++++++++++
 arch/arm/mach-vt8500/wm8505_7in.c           |    4 +-
 6 files changed, 84 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-vt8500/include/mach/restart.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/system.h
 create mode 100644 arch/arm/mach-vt8500/restart.c

diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 81aedb7..54e6997 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -1,4 +1,4 @@
-obj-y += devices.o gpio.o irq.o timer.o
+obj-y += devices.o gpio.o irq.o timer.o restart.o
 
 obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o
 obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
diff --git a/arch/arm/mach-vt8500/bv07.c b/arch/arm/mach-vt8500/bv07.c
index a464c75..f9fbeb2 100644
--- a/arch/arm/mach-vt8500/bv07.c
+++ b/arch/arm/mach-vt8500/bv07.c
@@ -23,6 +23,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <mach/restart.h>
 
 #include "devices.h"
 
@@ -62,6 +63,7 @@ void __init bv07_init(void)
 	else
 		printk(KERN_ERR "PMC Hibernation register could not be
remapped, not enabling power off!\n");
 
+	wmt_setup_restart();
 	vt8500_set_resources();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	vt8500_gpio_init();
@@ -69,6 +71,7 @@ void __init bv07_init(void)
 
 MACHINE_START(BV07, "Benign BV07 Mini Netbook")
 	.atag_offset	= 0x100,
+	.restart	= wmt_restart,
 	.reserve	= vt8500_reserve_mem,
 	.map_io		= vt8500_map_io,
 	.init_irq	= vt8500_init_irq,
diff --git a/arch/arm/mach-vt8500/include/mach/restart.h
b/arch/arm/mach-vt8500/include/mach/restart.h
new file mode 100644
index 0000000..89f9b78
--- /dev/null
+++ b/arch/arm/mach-vt8500/include/mach/restart.h
@@ -0,0 +1,17 @@
+/* linux/arch/arm/mach-vt8500/restart.h
+ *
+ * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+void wmt_setup_restart(void);
+void wmt_restart(char mode, const char *cmd);
diff --git a/arch/arm/mach-vt8500/include/mach/system.h
b/arch/arm/mach-vt8500/include/mach/system.h
deleted file mode 100644
index 58fa801..0000000
--- a/arch/arm/mach-vt8500/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-vt8500/include/mach/system.h
- *
- */
-#include <asm/io.h>
-
-/* PM Software Reset request register */
-#define VT8500_PMSR_VIRT	0xf8130060
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	writel(1, VT8500_PMSR_VIRT);
-}
diff --git a/arch/arm/mach-vt8500/restart.c b/arch/arm/mach-vt8500/restart.c
new file mode 100644
index 0000000..78b4ab0
--- /dev/null
+++ b/arch/arm/mach-vt8500/restart.c
@@ -0,0 +1,60 @@
+/* linux/arch/arm/mach-vt8500/restart.c
+ *
+ * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <asm/io.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+/* PM Software Reset request register */
+#define VT8500_PMSR_REG		0xD8130060
+
+static void __iomem *wmt_restart_reg;
+
+void wmt_setup_restart(void)
+{
+	struct device_node *np;
+
+	/*
+	 * Check if rstc (Restart Controller) node is present in device
+	 * tree. Device tree support is still WIP. If no device tree
+	 * node, use the default PMSR value (valid for all current SoCs).
+	 */
+	np = of_find_compatible_node(NULL, NULL, "wmt,rstc");
+	if (np) {
+		wmt_restart_reg = of_iomap(np, 0);
+
+		if (!wmt_restart_reg)
+			pr_err("%s:of_iomap(rstc) failed\n", __func__);
+
+		of_node_put(np);
+	} else {
+		if (!request_mem_region(VT8500_PMSR_REG, 4, NULL)) {
+			pr_err("%s:req_mem_region(rstc) failed\n",
__func__);
+			return;
+		}
+
+		wmt_restart_reg = ioremap(VT8500_PMSR_REG, 4);
+		if (!wmt_restart_reg) {
+			pr_err("%s:ioremap(rstc) failed\n", __func__);
+			return;
+		}
+	}
+}
+
+void wmt_restart(char mode, const char *cmd)
+{
+	if (wmt_restart_reg)
+		writel(1, wmt_restart_reg);
+}
diff --git a/arch/arm/mach-vt8500/wm8505_7in.c
b/arch/arm/mach-vt8500/wm8505_7in.c
index cf910a9..db19886 100644
--- a/arch/arm/mach-vt8500/wm8505_7in.c
+++ b/arch/arm/mach-vt8500/wm8505_7in.c
@@ -23,6 +23,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <mach/restart.h>
 
 #include "devices.h"
 
@@ -61,7 +62,7 @@ void __init wm8505_7in_init(void)
 		pm_power_off = &vt8500_power_off;
 	else
 		printk(KERN_ERR "PMC Hibernation register could not be
remapped, not enabling power off!\n");
-
+	wmt_setup_restart();
 	wm8505_set_resources();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	vt8500_gpio_init();
@@ -69,6 +70,7 @@ void __init wm8505_7in_init(void)
 
 MACHINE_START(WM8505_7IN_NETBOOK, "WM8505 7-inch generic netbook")
 	.atag_offset	= 0x100,
+	.restart	= wmt_restart,
 	.reserve	= wm8505_reserve_mem,
 	.map_io		= wm8505_map_io,
 	.init_irq	= wm8505_init_irq,
-- 
1.7.2.5
