From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 24 Oct 2010 10:12:40 +0200
Subject: [PATCH] ARM: orion5x/kirkwood/mv78xx0: fix MPP configuration corner
	cases
Message-ID: <1287907960-31563-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrong MPP configuration would cause <cpu>_mpp_conf loop	infinitely
because the mpp list iterator would not be incremented.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-kirkwood/mpp.c |    5 +++--
 arch/arm/mach-mv78xx0/mpp.c  |    5 +++--
 arch/arm/mach-orion5x/mpp.c  |    5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 065187d..273f561 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -67,13 +67,13 @@ void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 		if (num > MPP_MAX) {
 			printk(KERN_ERR "kirkwood_mpp_conf: invalid MPP "
 					"number (%u)\n", num);
-			continue;
+			goto next_pin;
 		}
 		if (!(*mpp_list & variant_mask)) {
 			printk(KERN_WARNING
 			       "kirkwood_mpp_conf: requested MPP%u config "
 			       "unavailable on this hardware\n", num);
-			continue;
+			goto next_pin;
 		}
 
 		shift = (num & 7) << 2;
@@ -89,6 +89,7 @@ void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 			gpio_mode = 0;
 		orion_gpio_set_valid(num, gpio_mode);
 
+next_pin:
 		mpp_list++;
 	}
 
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 354ac51..7c1fe2a 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -62,13 +62,13 @@ void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 		if (num > MPP_MAX) {
 			printk(KERN_ERR "mv78xx0_mpp_conf: invalid MPP "
 					"number (%u)\n", num);
-			continue;
+			goto next_pin;
 		}
 		if (!(*mpp_list & variant_mask)) {
 			printk(KERN_WARNING
 					"mv78xx0_mpp_conf: requested MPP%u config "
 					"unavailable on this hardware\n", num);
-			continue;
+			goto next_pin;
 		}
 
 		shift = (num & 7) << 2;
@@ -84,6 +84,7 @@ void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 			gpio_mode = 0;
 		orion_gpio_set_valid(num, gpio_mode);
 
+next_pin:
 		mpp_list++;
 	}
 
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index bc4c3b9..dc27d1a 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -141,7 +141,7 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 		else {
 			printk(KERN_ERR "orion5x_mpp_conf: invalid MPP "
 					"(%d)\n", mode->mpp);
-			continue;
+			goto next_pin;
 		}
 
 		num_type = determine_type_encoding(mode->mpp, mode->type);
@@ -149,7 +149,7 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 			printk(KERN_ERR "orion5x_mpp_conf: invalid MPP "
 					"combination (%d, %d)\n", mode->mpp,
 					mode->type);
-			continue;
+			goto next_pin;
 		}
 
 		shift = (mode->mpp & 7) << 2;
@@ -161,6 +161,7 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 
 		orion_gpio_set_valid(mode->mpp, !!(mode->type == MPP_GPIO));
 
+next_pin:
 		mode++;
 	}
 
-- 
1.7.3.1
