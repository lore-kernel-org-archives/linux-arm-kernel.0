From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 12:55:27 +0900
Subject: [PATCH 09/15] ARM: shmobile: r8a7740: Add CPU sleep suspend
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359086133-23357-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep.
It is entered by a simple dsb and wfi instruction via cpu_do_idle(). As
just clocks are stopped there is no need to save or restore any state of
the system.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
[ horms at verge.net.au: Added missing includes ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 arch/arm/mach-shmobile/include/mach/common.h   |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            |   22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e791244..6573137 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1181,6 +1181,8 @@ static void __init eva_init(void)
 	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
+
+	r8a7740_pm_init();
 }
 
 static void __init eva_earlytimer_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index f221c11..c0ab595 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,6 +52,7 @@ extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
+extern void r8a7740_pm_init(void);
 
 extern void r8a7779_init_irq(void);
 extern void r8a7779_map_io(void);
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 21e5316d..40b87aa 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -9,7 +9,9 @@
  * for more details.
  */
 #include <linux/console.h>
+#include <linux/suspend.h>
 #include <mach/pm-rmobile.h>
+#include <mach/common.h>
 
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
@@ -58,3 +60,23 @@ void __init r8a7740_init_pm_domains(void)
 }
 
 #endif /* CONFIG_PM */
+
+#ifdef CONFIG_SUSPEND
+static int r8a7740_enter_suspend(suspend_state_t suspend_state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static void r8a7740_suspend_init(void)
+{
+	shmobile_suspend_ops.enter = r8a7740_enter_suspend;
+}
+#else
+static void r8a7740_suspend_init(void) {}
+#endif
+
+void __init r8a7740_pm_init(void)
+{
+	r8a7740_suspend_init();
+}
-- 
1.7.10.4
