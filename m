From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Apr 2012 23:38:35 +0800
Subject: [PATCH 07/17] ARM: kirkwood: use machine specific hook for late init
In-Reply-To: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335454725-13089-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-kirkwood/board-dt.c              |    1 +
 arch/arm/mach-kirkwood/common.c                |    6 +++++-
 arch/arm/mach-kirkwood/common.h                |    1 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    1 +
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    1 +
 arch/arm/mach-kirkwood/dockstar-setup.c        |    1 +
 arch/arm/mach-kirkwood/guruplug-setup.c        |    1 +
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    3 +++
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    2 ++
 arch/arm/mach-kirkwood/openrd-setup.c          |    3 +++
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    1 +
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    1 +
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    2 ++
 arch/arm/mach-kirkwood/t5325-setup.c           |    1 +
 arch/arm/mach-kirkwood/ts219-setup.c           |    1 +
 arch/arm/mach-kirkwood/ts41x-setup.c           |    1 +
 17 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1c672d9..aaa495c 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -70,6 +70,7 @@ DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
 	.init_machine	= kirkwood_dt_init,
+	.init_late	= kirkwood_init_late,
 	.restart	= kirkwood_restart,
 	.dt_compat	= kirkwood_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index a02cae8..af88ffe 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -530,7 +530,6 @@ static int __init kirkwood_clock_gate(void)
 
 	return 0;
 }
-late_initcall(kirkwood_clock_gate);
 
 void kirkwood_restart(char mode, const char *cmd)
 {
@@ -547,3 +546,8 @@ void kirkwood_restart(char mode, const char *cmd)
 	while (1)
 		;
 }
+
+void __init kirkwood_init_late(void)
+{
+	kirkwood_clock_gate();
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index fa8e768..6d8829e 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -50,6 +50,7 @@ void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
 void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev_ready)(struct mtd_info *));
 void kirkwood_audio_init(void);
 void kirkwood_restart(char, const char *);
+void kirkwood_init_late(void);
 
 /* board init functions for boards not fully converted to fdt */
 #ifdef CONFIG_MACH_DREAMPLUG_DT
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index 6e1bac9..94ddb45 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -226,6 +226,7 @@ MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index d933593..1edc314 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -102,6 +102,7 @@ MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index 61d9a55..3ffd50f 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -107,6 +107,7 @@ MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index bdaed38..b5c0cc2 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -126,6 +126,7 @@ MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 85f6169..25943da 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -168,6 +168,7 @@ MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index e6bba01..06ed9b0 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -263,6 +263,7 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -275,6 +276,7 @@ MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -287,6 +289,7 @@ MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 31ae8de..ec0a1ebd 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -404,6 +404,7 @@ MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -416,6 +417,7 @@ MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 7e99c3f..8d58f32 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -225,6 +225,7 @@ MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -238,6 +239,7 @@ MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -251,6 +253,7 @@ MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index fd2c9c8..c9cc221 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -84,6 +84,7 @@ MACHINE_START(RD88F6192_NAS, "Marvell RD-88F6192-NAS Development Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index ef92207..0863bb0 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -120,6 +120,7 @@ MACHINE_START(RD88F6281, "Marvell RD-88F6281 Reference Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 4ea70e5f..51ba9be 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -143,6 +143,7 @@ MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
@@ -155,6 +156,7 @@ MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index f9d2a11..498f83e 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -212,6 +212,7 @@ MACHINE_START(T5325, "HP t5325 Thin Client")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 73e2b6c..8b217ce 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -137,6 +137,7 @@ MACHINE_START(TS219, "QNAP TS-119/TS-219")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index 5bbca26..cb77ab9 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -181,6 +181,7 @@ MACHINE_START(TS41X, "QNAP TS-41x")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
+	.init_late	= kirkwood_init_late,
 	.timer		= &kirkwood_timer,
 	.restart	= kirkwood_restart,
 MACHINE_END
-- 
1.7.5.4
