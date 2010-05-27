From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:13 +0200
Subject: [PATCH v2 1/8] i.MX27: add suspend to RAM support
Message-ID: <1274942000-3580-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/Makefile   |    2 +-
 arch/arm/mach-mx2/pm-imx27.c |   46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx2/pm-imx27.c

diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index e3254fa..27d496c 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -8,7 +8,7 @@ obj-y	:=  devices.o serial.o
 
 obj-$(CONFIG_MACH_MX21) += clock_imx21.o mm-imx21.o
 
-obj-$(CONFIG_MACH_MX27) += cpu_imx27.o
+obj-$(CONFIG_MACH_MX27) += cpu_imx27.o pm-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock_imx27.o mm-imx27.o
 
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
diff --git a/arch/arm/mach-mx2/pm-imx27.c b/arch/arm/mach-mx2/pm-imx27.c
new file mode 100644
index 0000000..a82fb6d
--- /dev/null
+++ b/arch/arm/mach-mx2/pm-imx27.c
@@ -0,0 +1,46 @@
+/*
+ * i.MX27 Power Management Routines
+ *
+ * Based on Freescale's BSP
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <asm/io.h>
+#include <mach/system.h>
+#include <mach/mx27.h>
+
+static int mx27_suspend_enter(suspend_state_t state)
+{
+	u32 cscr;
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		/* Clear MPEN and SPEN to disable MPLL/SPLL */
+		cscr = __raw_readl(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
+		cscr &= 0xFFFFFFFC;
+		__raw_writel(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
+		/* Executes WFI */
+		arch_idle();
+		break;
+
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+static struct platform_suspend_ops mx27_suspend_ops = {
+	.enter = mx27_suspend_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+static int __init mx27_pm_init(void)
+{
+	suspend_set_ops(&mx27_suspend_ops);
+	return 0;
+}
+
+device_initcall(mx27_pm_init);
-- 
1.6.3.3
