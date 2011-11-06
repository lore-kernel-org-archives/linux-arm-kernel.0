From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:46:24 +0000
Subject: [PATCH 19/41] ARM: restart: kirkwood: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6nY-0001Xp-PG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather than
using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-kirkwood/common.c                |   16 ++++++++++++++++
 arch/arm/mach-kirkwood/common.h                |    1 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    1 +
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    1 +
 arch/arm/mach-kirkwood/dockstar-setup.c        |    1 +
 arch/arm/mach-kirkwood/guruplug-setup.c        |    1 +
 arch/arm/mach-kirkwood/include/mach/system.h   |   15 ---------------
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
 17 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f3248cf..0bff4a9 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -534,3 +534,19 @@ static int __init kirkwood_clock_gate(void)
 	return 0;
 }
 late_initcall(kirkwood_clock_gate);
+
+void kirkwood_restart(char mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index b9b0f09..1529280 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -50,6 +50,7 @@ void kirkwood_uart1_init(void);
 void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
 void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev_ready)(struct mtd_info *));
 void kirkwood_audio_init(void);
+void kirkwood_restart(char, const char *);
 
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index f457e07..6e1bac9 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -227,4 +227,5 @@ MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index ff4c21c..d933593 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -103,4 +103,5 @@ MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index e4d199b..61d9a55 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -108,4 +108,5 @@ MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
index 6c40f78..bdaed38 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-kirkwood/guruplug-setup.c
@@ -127,4 +127,5 @@ MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
index 7568e95..8a94d97 100644
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ b/arch/arm/mach-kirkwood/include/mach/system.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <mach/bridge-regs.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -18,19 +16,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
 }
 
-
 #endif
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
index 9a1e917..85f6169 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
@@ -169,4 +169,5 @@ MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index 8849bcc..e6bba01 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -264,6 +264,7 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -275,6 +276,7 @@ MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -286,5 +288,6 @@ MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 1ba12c4..31ae8de 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -405,6 +405,7 @@ MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -416,5 +417,6 @@ MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 5660ca6..01f8c89 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -220,6 +220,7 @@ MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -232,6 +233,7 @@ MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -244,5 +246,6 @@ MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
index 6663869..fd2c9c8 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
@@ -85,4 +85,5 @@ MACHINE_START(RD88F6192_NAS, "Marvell RD-88F6192-NAS Development Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
index 66b3c05..ef92207 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
@@ -121,4 +121,5 @@ MACHINE_START(RD88F6281, "Marvell RD-88F6281 Reference Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 8b102d6..85bff6b 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -144,6 +144,7 @@ MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
 
@@ -155,5 +156,6 @@ MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
index ea104fb..966b2b3 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-kirkwood/t5325-setup.c
@@ -207,4 +207,5 @@ MACHINE_START(T5325, "HP t5325 Thin Client")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 262c034..73e2b6c 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -138,4 +138,5 @@ MACHINE_START(TS219, "QNAP TS-119/TS-219")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index b68f5b4..5bbca26 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -182,4 +182,5 @@ MACHINE_START(TS41X, "QNAP TS-41x")
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
 MACHINE_END
-- 
1.7.4.4
