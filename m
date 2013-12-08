From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  8 Dec 2013 10:53:29 +0400
Subject: [PATCH RFC] ARM: Provide default restart handler
Message-ID: <1386485609-4174-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides default restart handler if it is not explicitly specified.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/kernel/setup.c                 | 7 +++++++
 arch/arm/mach-clps711x/board-autcpu12.c | 1 -
 arch/arm/mach-clps711x/board-cdb89712.c | 1 -
 arch/arm/mach-clps711x/board-clep7312.c | 1 -
 arch/arm/mach-clps711x/board-edb7211.c  | 1 -
 arch/arm/mach-clps711x/board-p720t.c    | 1 -
 arch/arm/mach-clps711x/common.c         | 5 -----
 arch/arm/mach-clps711x/common.h         | 3 ---
 arch/arm/mach-mmp/brownstone.c          | 1 -
 arch/arm/mach-mmp/common.c              | 5 -----
 arch/arm/mach-mmp/common.h              | 1 -
 arch/arm/mach-mmp/flint.c               | 1 -
 arch/arm/mach-mmp/jasper.c              | 1 -
 arch/arm/mach-mmp/tavorevb.c            | 1 -
 arch/arm/mach-mmp/ttc_dkb.c             | 1 -
 15 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6a1b8a8..c74f98f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -862,6 +862,11 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+static void default_arm_restart(enum reboot_mode mode, const char *cmd)
+{
+	soft_restart(0);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
@@ -900,6 +905,8 @@ void __init setup_arch(char **cmdline_p)
 
 	if (mdesc->restart)
 		arm_pm_restart = mdesc->restart;
+	else
+		arm_pm_restart = default_arm_restart;
 
 	unflatten_device_tree();
 
diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f8d71a8..cf2f1d9 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -273,6 +273,5 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	.init_machine	= autcpu12_init,
 	.init_late	= autcpu12_init_late,
 	.handle_irq	= clps711x_handle_irq,
-	.restart	= clps711x_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index a9e38c6..491bc37 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -146,5 +146,4 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
 	.handle_irq	= clps711x_handle_irq,
-	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index b476424..5295b49 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -43,5 +43,4 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.handle_irq	= clps711x_handle_irq,
-	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index fe6184e..89a0d72 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -187,5 +187,4 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.init_machine	= edb7211_init,
 	.init_late	= edb7211_init_late,
 	.handle_irq	= clps711x_handle_irq,
-	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index dd81b06..be5b2e9 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -372,5 +372,4 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.init_machine	= p720t_init,
 	.init_late	= p720t_init_late,
 	.handle_irq	= clps711x_handle_irq,
-	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 134641d..416d150 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -384,11 +384,6 @@ void __init clps711x_timer_init(void)
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 }
 
-void clps711x_restart(enum reboot_mode mode, const char *cmd)
-{
-	soft_restart(0);
-}
-
 static void clps711x_idle(void)
 {
 	clps_writel(1, HALT);
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 9a6767b..1763585 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -4,8 +4,6 @@
  * Common bits.
  */
 
-#include <linux/reboot.h>
-
 #define CLPS711X_NR_IRQS	(33)
 #define CLPS711X_NR_GPIO	(4 * 8 + 3)
 #define CLPS711X_GPIO(prt, bit)	((prt) * 8 + (bit))
@@ -14,5 +12,4 @@ extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
 extern void clps711x_handle_irq(struct pt_regs *regs);
-extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
 extern void clps711x_init_early(void);
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index ac25544..4b3d668 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -227,5 +227,4 @@ MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
 	.init_irq	= mmp2_init_irq,
 	.init_time	= mmp2_timer_init,
 	.init_machine	= brownstone_init,
-	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index c03b4ab..b1f004a 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -46,8 +46,3 @@ void __init mmp_map_io(void)
 	/* this is early, initialize mmp_chip_id here */
 	mmp_chip_id = __raw_readl(MMP_CHIPID);
 }
-
-void mmp_restart(enum reboot_mode mode, const char *cmd)
-{
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index cf445ba..6dd1fcc 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -4,7 +4,6 @@
 extern void timer_init(int irq);
 
 extern void __init mmp_map_io(void);
-extern void mmp_restart(enum reboot_mode, const char *);
 extern void __init pxa168_clk_init(void);
 extern void __init pxa910_clk_init(void);
 extern void __init mmp2_clk_init(void);
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 6291c33..02cd8e7 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -130,5 +130,4 @@ MACHINE_START(FLINT, "Flint Development Platform")
 	.init_irq       = mmp2_init_irq,
 	.init_time	= mmp2_timer_init,
 	.init_machine   = flint_init,
-	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 0e9e5c0..feb9553 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -184,5 +184,4 @@ MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
 	.init_irq       = mmp2_init_irq,
 	.init_time	= mmp2_timer_init,
 	.init_machine   = jasper_init,
-	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index cdfc9bf..9fbfe12 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -112,5 +112,4 @@ MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
 	.init_irq       = pxa910_init_irq,
 	.init_time	= pxa910_timer_init,
 	.init_machine   = tavorevb_init,
-	.restart	= mmp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index cfadd97..44a6e74 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -311,5 +311,4 @@ MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.init_irq       = pxa910_init_irq,
 	.init_time	= pxa910_timer_init,
 	.init_machine   = ttc_dkb_init,
-	.restart	= mmp_restart,
 MACHINE_END
-- 
1.8.3.2
