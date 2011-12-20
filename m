From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:32 +0900
Subject: [PATCH 08/12] ARM: restart: S5PV210: use new restart hook
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[kgene.kim at samsung.com: according to local header, updated]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/common.c              |    6 +-----
 arch/arm/mach-s5pv210/common.h              |    2 ++
 arch/arm/mach-s5pv210/include/mach/system.h |    2 --
 arch/arm/mach-s5pv210/mach-aquila.c         |    1 +
 arch/arm/mach-s5pv210/mach-goni.c           |    1 +
 arch/arm/mach-s5pv210/mach-smdkc110.c       |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c       |    1 +
 arch/arm/mach-s5pv210/mach-torbreck.c       |    1 +
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 2899ee8..a4921bc 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -35,7 +35,6 @@
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
-#include <plat/reset.h>
 #include <plat/sdhci.h>
 #include <plat/adc-core.h>
 #include <plat/ata-core.h>
@@ -151,7 +150,7 @@ static void s5pv210_idle(void)
 	local_irq_enable();
 }
 
-static void s5pv210_sw_reset(void)
+void s5pv210_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
 }
@@ -251,9 +250,6 @@ int __init s5pv210_init(void)
 	/* set idle function */
 	pm_idle = s5pv210_idle;
 
-	/* set sw_reset function */
-	s5p_reset_hook = s5pv210_sw_reset;
-
 	return sysdev_register(&s5pv210_sysdev);
 }
 
diff --git a/arch/arm/mach-s5pv210/common.h b/arch/arm/mach-s5pv210/common.h
index f74ef96..6ed2af5 100644
--- a/arch/arm/mach-s5pv210/common.h
+++ b/arch/arm/mach-s5pv210/common.h
@@ -18,6 +18,8 @@ void s5pv210_init_irq(void);
 void s5pv210_register_clocks(void);
 void s5pv210_setup_clocks(void);
 
+void s5pv210_restart(char mode, const char *cmd);
+
 #ifdef CONFIG_CPU_S5PV210
 
 extern  int s5pv210_init(void);
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
index af8a200..bf288ce 100644
--- a/arch/arm/mach-s5pv210/include/mach/system.h
+++ b/arch/arm/mach-s5pv210/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 167f03c..6f7dfe9 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -686,4 +686,5 @@ MACHINE_START(AQUILA, "Aquila")
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5pv210_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index ab39ded..12c6937 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -963,4 +963,5 @@ MACHINE_START(GONI, "GONI")
 	.init_machine	= goni_machine_init,
 	.timer		= &s5p_timer,
 	.reserve	= &goni_reserve,
+	.restart	= s5pv210_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index b8c2c07..9405da4 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -144,4 +144,5 @@ MACHINE_START(SMDKC110, "SMDKC110")
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5pv210_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 4bd8743..380dc21 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -321,4 +321,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5pv210_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index aece529..74e99bc 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -133,4 +133,5 @@ MACHINE_START(TORBRECK, "TORBRECK")
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5pv210_restart,
 MACHINE_END
-- 
1.7.4.4
