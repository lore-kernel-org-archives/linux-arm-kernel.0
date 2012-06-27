From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 27 Jun 2012 17:26:46 +0100
Subject: [PATCH 3/3] arm: mach-mvebu: system-controller only registers restart
 if device exists
In-Reply-To: <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1340814406-26010-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change to only registering the restart hook if the device exists
and can be enumerated in the device tree. Remove the header definiton
and the restart entry in the machine file.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/armada-370-xp.c     |    1 -
 arch/arm/mach-mvebu/common.h            |    2 --
 arch/arm/mach-mvebu/system-controller.c |   40 ++++++++++++++++---------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 4ef923b..a27639e 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -58,6 +58,5 @@ DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
 	.init_irq	= armada_370_xp_init_irq,
 	.handle_irq     = armada_370_xp_handle_irq,
 	.timer		= &armada_370_xp_timer,
-	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_board_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 1b1e679..5d57784 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -15,8 +15,6 @@
 #ifndef __ARCH_MVEBU_COMMON_H
 #define __ARCH_MVEBU_COMMON_H
 
-void mvebu_restart(char mode, const char *cmd);
-
 void armada_370_xp_init_irq(void);
 asmlinkage void  armada_370_xp_handle_irq(struct pt_regs *regs);
 
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 850f8d2..3405ecf 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -27,6 +27,8 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 
+#include <asm/system_misc.h>
+
 static void __iomem *system_controller_base;
 
 struct mvebu_system_controller {
@@ -63,26 +65,22 @@ static struct of_device_id of_system_controller_table[] = {
 	{ /* end of list */ },
 };
 
-void mvebu_restart(char mode, const char *cmd)
+static void mvebu_restart(char mode, const char *cmd)
 {
-	if (!system_controller_base) {
-		pr_warn("Cannot restart, system-controller not available\n");
-	} else {
-		/*
-		 * Enable soft reset to assert RSTOUTn.
-		 */
-		writel(mvebu_sc->rstoutn_mask_reset_out_en,
-			system_controller_base +
-			mvebu_sc->rstoutn_mask_offset);
-		/*
-		 * Assert soft reset.
-		 */
-		writel(mvebu_sc->system_soft_reset,
-			system_controller_base +
-			mvebu_sc->system_soft_reset_offset);
-	}
-	while (1)
-		;
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(mvebu_sc->rstoutn_mask_reset_out_en,
+	       system_controller_base +
+	       mvebu_sc->rstoutn_mask_offset);
+	/*
+	 * Assert soft reset.
+	 */
+	writel(mvebu_sc->system_soft_reset,
+	       system_controller_base +
+	       mvebu_sc->system_soft_reset_offset);
+
+	while (1) ;
 }
 
 static int __init mvebu_system_controller_init(void)
@@ -95,7 +93,11 @@ static int __init mvebu_system_controller_init(void)
 		    of_match_node(of_system_controller_table, np);
 		BUG_ON(!match);
 		system_controller_base = of_iomap(np, 0);
+		if (!WARN_ON(!system_controller_base))
+			return -EINVAL;
+
 		mvebu_sc = (struct mvebu_system_controller *)match->data;
+		arm_pm_restart = mvebu_restart;
 	}
 
 	return 0;
-- 
1.7.10
