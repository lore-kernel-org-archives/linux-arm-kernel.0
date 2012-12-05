From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  5 Dec 2012 13:13:06 +0100
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: Add CPU sleep suspend
Message-ID: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep. It is
entered by a simple dsb and wfi instruction via cpu_do_idle(). As just
clocks are stopped there is no need to save or restore any state of the
system.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c         |    2 ++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/pm-sh73a0.c           |   32 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe2c97c..d0d06f2 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
+obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 0a43f31..dc8c0f8 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -760,6 +760,8 @@ static void __init kzm_init(void)
 
 	sh73a0_add_standard_devices();
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
+
+	sh73a0_pm_init();
 }
 
 static void kzm9g_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d47e215..318551b3 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -54,6 +54,7 @@ extern void sh73a0_add_early_devices(void);
 extern void sh73a0_add_standard_devices(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
+extern void sh73a0_pm_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
diff --git a/arch/arm/mach-shmobile/pm-sh73a0.c b/arch/arm/mach-shmobile/pm-sh73a0.c
new file mode 100644
index 0000000..9cf67bb
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-sh73a0.c
@@ -0,0 +1,32 @@
+/*
+ * sh73a0 Power management support
+ *
+ *  Copyright (C) 2012 Bastian Hecht <hechtb+renesas@gmail.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/suspend.h>
+#include <mach/common.h>
+
+#ifdef CONFIG_SUSPEND
+static int sh73a0_enter_suspend(suspend_state_t suspend_state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static void sh73a0_suspend_init(void)
+{
+	shmobile_suspend_ops.enter = sh73a0_enter_suspend;
+}
+#else
+static void sh73a0_suspend_init(void) {}
+#endif
+
+void __init sh73a0_pm_init(void)
+{
+	sh73a0_suspend_init();
+}
-- 
1.7.9.5
