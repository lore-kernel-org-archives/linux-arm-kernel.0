From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:32 +0800
Subject: [PATCH 07/15] ARM: omap1: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c |    8 +++++++-
 arch/arm/mach-omap1/board-fsample.c   |    1 +
 arch/arm/mach-omap1/board-generic.c   |    1 +
 arch/arm/mach-omap1/board-h2.c        |    1 +
 arch/arm/mach-omap1/board-h3.c        |    1 +
 arch/arm/mach-omap1/board-htcherald.c |    1 +
 arch/arm/mach-omap1/board-innovator.c |    1 +
 arch/arm/mach-omap1/board-nokia770.c  |    1 +
 arch/arm/mach-omap1/board-osk.c       |    1 +
 arch/arm/mach-omap1/board-palmte.c    |    1 +
 arch/arm/mach-omap1/board-palmtt.c    |    1 +
 arch/arm/mach-omap1/board-palmz71.c   |    1 +
 arch/arm/mach-omap1/board-perseus2.c  |    1 +
 arch/arm/mach-omap1/board-sx1.c       |    1 +
 arch/arm/mach-omap1/board-voiceblue.c |    1 +
 arch/arm/mach-omap1/common.h          |   10 ++++++++++
 arch/arm/mach-omap1/io.c              |    5 +++++
 arch/arm/mach-omap1/serial.c          |    3 +--
 18 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c1b681e..f2f8a58 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -595,7 +595,12 @@ gpio_free:
 	gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 	return err;
 }
-late_initcall(late_init);
+
+static void __init ams_delta_init_late(void)
+{
+	omap1_init_late();
+	late_init();
+}
 
 static void __init ams_delta_map_io(void)
 {
@@ -611,6 +616,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
+	.init_late	= ams_delta_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 80bd43c..a77ee57 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -383,6 +383,7 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_fsample_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 9a5fe58..e75e2d5 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -88,6 +88,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 553a2e5..04cf994 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -446,6 +446,7 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h2_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4c19f4c..a11ef0a 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -439,6 +439,7 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= h3_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 60c06ee..118a9d4 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -605,6 +605,7 @@ MACHINE_START(HERALD, "HTC Herald")
 	.reserve	= omap_reserve,
 	.init_irq       = omap1_init_irq,
 	.init_machine   = htcherald_init,
+	.init_late	= omap1_init_late,
 	.timer          = &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 67d7fd5..7970223 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -457,6 +457,7 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= innovator_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d21dcc2..7212ae9 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -255,6 +255,7 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_nokia770_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a5f85dd..da8d872 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -574,6 +574,7 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= osk_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index a60e6c2..949b62a 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -267,6 +267,7 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmte_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 8d85487..7f1e1cf 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -313,6 +313,7 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmtt_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index a2c5abc..0711685 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -330,6 +330,7 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmz71_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 76d4ee0..512989b 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -345,6 +345,7 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_perseus2_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index f34cb74..3b7b82b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -407,6 +407,7 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_sx1_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= omap1_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 37232d0..afd67f0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -294,6 +294,7 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.reserve	= omap_reserve,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= voiceblue_init,
+	.init_late	= omap1_init_late,
 	.timer		= &omap1_timer,
 	.restart	= voiceblue_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index af658ad..0b77e6d 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -52,8 +52,18 @@ static inline void omap16xx_map_io(void)
 }
 #endif
 
+#ifdef CONFIG_OMAP_SERIAL_WAKE
+int omap_serial_wakeup_init(void);
+#else
+static inline int omap_serial_wakeup_init(void)
+{
+	return 0;
+}
+#endif
+
 void omap1_init_early(void);
 void omap1_init_irq(void);
+void omap1_init_late(void);
 void omap1_restart(char, const char *);
 
 extern struct sys_timer omap1_timer;
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index d969a72..cf811f2 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -138,6 +138,11 @@ void __init omap1_init_early(void)
 	omap_init_consistent_dma_size();
 }
 
+void __init omap1_init_late(void)
+{
+	omap_serial_wakeup_init();
+}
+
 /*
  * NOTE: Please use ioremap + __raw_read/write where possible instead of these
  */
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 93ae8f2..6809c9e 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -237,7 +237,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 	enable_irq_wake(gpio_to_irq(gpio_nr));
 }
 
-static int __init omap_serial_wakeup_init(void)
+int __init omap_serial_wakeup_init(void)
 {
 	if (!cpu_is_omap16xx())
 		return 0;
@@ -251,7 +251,6 @@ static int __init omap_serial_wakeup_init(void)
 
 	return 0;
 }
-late_initcall(omap_serial_wakeup_init);
 
 #endif	/* CONFIG_OMAP_SERIAL_WAKE */
 
-- 
1.7.5.4
