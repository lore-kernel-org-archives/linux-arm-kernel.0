From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  3 Nov 2010 17:22:00 +0200
Subject: [PATCH v2] ARM: orion5x/kirkwood/mv78xx0: fix MPP configuration
	corner cases
Message-ID: <1288797720-1491-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 changes:
* use for loop instead of gotos
---

Wrong MPP configuration would cause <cpu>_mpp_conf loop	infinitely
because the mpp list iterator would not be incremented.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-kirkwood/mpp.c |    4 +---
 arch/arm/mach-mv78xx0/mpp.c  |    4 +---
 arch/arm/mach-orion5x/mpp.c  |    4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 065187d..27901f7 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -59,7 +59,7 @@ void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 	}
 	printk("\n");
 
-	while (*mpp_list) {
+	for ( ; *mpp_list; mpp_list++) {
 		unsigned int num = MPP_NUM(*mpp_list);
 		unsigned int sel = MPP_SEL(*mpp_list);
 		int shift, gpio_mode;
@@ -88,8 +88,6 @@ void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 		if (sel != 0)
 			gpio_mode = 0;
 		orion_gpio_set_valid(num, gpio_mode);
-
-		mpp_list++;
 	}
 
 	printk(KERN_DEBUG "  final MPP regs:");
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 354ac51..84db2df 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -54,7 +54,7 @@ void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 	}
 	printk("\n");
 
-	while (*mpp_list) {
+	for ( ; *mpp_list; mpp_list++) {
 		unsigned int num = MPP_NUM(*mpp_list);
 		unsigned int sel = MPP_SEL(*mpp_list);
 		int shift, gpio_mode;
@@ -83,8 +83,6 @@ void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 		if (sel != 0)
 			gpio_mode = 0;
 		orion_gpio_set_valid(num, gpio_mode);
-
-		mpp_list++;
 	}
 
 	printk(KERN_DEBUG "  final MPP regs:");
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index bc4c3b9..db485d3 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -127,7 +127,7 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 	/* Initialize gpiolib. */
 	orion_gpio_init();
 
-	while (mode->mpp >= 0) {
+	for ( ; mode->mpp >= 0; mode++) {
 		u32 *reg;
 		int num_type;
 		int shift;
@@ -160,8 +160,6 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 			orion_gpio_set_unused(mode->mpp);
 
 		orion_gpio_set_valid(mode->mpp, !!(mode->type == MPP_GPIO));
-
-		mode++;
 	}
 
 	writel(mpp_0_7_ctrl, MPP_0_7_CTRL);
-- 
1.7.3.1
