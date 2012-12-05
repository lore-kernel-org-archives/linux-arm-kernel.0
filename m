From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  5 Dec 2012 13:13:07 +0100
Subject: [PATCH 2/2] ARM: shmobile: r8a7740: Add CPU sleep suspend
In-Reply-To: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
References: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1354709587-25288-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep.
It is entered by a simple dsb and wfi instruction via cpu_do_idle(). As
just clocks are stopped there is no need to save or restore any state of
the system.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 arch/arm/mach-shmobile/include/mach/common.h   |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            |   20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3cc8b1c..48847f6 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1213,6 +1213,8 @@ static void __init eva_init(void)
 	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
+
+	r8a7740_pm_init();
 }
 
 static void __init eva_earlytimer_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 318551b3..ebcd28d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -66,6 +66,7 @@ extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
+extern void r8a7740_pm_init(void);
 
 extern void r8a7779_init_irq(void);
 extern void r8a7779_map_io(void);
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 21e5316d..8cfb5bc 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -58,3 +58,23 @@ void __init r8a7740_init_pm_domains(void)
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
1.7.9.5
