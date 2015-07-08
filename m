From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  7 Jul 2015 18:17:01 -0700
Subject: [PATCH] ARM: BCM63xx: Remove custom secondary_startup function
In-Reply-To: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
Message-ID: <1436318221-30225-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 02b4e2756e01c623cc4dbceae4b07be75252db5b ("ARM: v7 setup
function should invalidate L1 cache"), the default secondary_startup
function for ARMv7 CPUs does invalidate the L1 cache, which was the sole
reason why BCM63xx had to have its own secondary_startup implementation.

Now that the secondary_startup takes care of this, we can completely
remove that code.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Russell,

Will queue this up for 4.3, BCM63138 SMP support happened at the same
time as your changes to cache-v7.S.

Thanks

 arch/arm/mach-bcm/Makefile          |  4 +---
 arch/arm/mach-bcm/bcm63xx_headsmp.S | 23 -----------------------
 arch/arm/mach-bcm/bcm63xx_smp.c     |  2 +-
 arch/arm/mach-bcm/bcm63xx_smp.h     |  1 -
 4 files changed, 2 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4fb0da458e91..1780a3ff42f9 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -39,10 +39,8 @@ obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
 
 # BCM63XXx
 ifeq ($(CONFIG_ARCH_BCM_63XX),y)
-CFLAGS_bcm63xx_headsmp.o	+= -march=armv7-a
 obj-y				+= bcm63xx.o
-obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_headsmp.o \
-				   bcm63xx_pmb.o
+obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_pmb.o
 endif
 
 ifeq ($(CONFIG_ARCH_BRCMSTB),y)
diff --git a/arch/arm/mach-bcm/bcm63xx_headsmp.S b/arch/arm/mach-bcm/bcm63xx_headsmp.S
deleted file mode 100644
index c7af397c7f14..000000000000
--- a/arch/arm/mach-bcm/bcm63xx_headsmp.S
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  Copyright (C) 2015, Broadcom Corporation
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/assembler.h>
-
-ENTRY(bcm63138_secondary_startup)
- ARM_BE8(setend	be)
-	/*
-	 * L1 cache does have unpredictable contents at power-up clean its
-	 * contents without flushing
-	 */
-	bl      v7_invalidate_l1
-	nop
-
-	b	secondary_startup
-ENDPROC(bcm63138_secondary_startup)
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index 3f014f18cea5..5520dab3dac1 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -135,7 +135,7 @@ static int bcm63138_smp_boot_secondary(unsigned int cpu,
 	}
 
 	/* Write the secondary init routine to the BootLUT reset vector */
-	val = virt_to_phys(bcm63138_secondary_startup);
+	val = virt_to_phys(secondary_startup);
 	writel_relaxed(val, bootlut_base + BOOTLUT_RESET_VECT);
 
 	/* Power up the core, will jump straight to its reset vector when we
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.h b/arch/arm/mach-bcm/bcm63xx_smp.h
index 50b76044536e..9c6d50e2b111 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.h
+++ b/arch/arm/mach-bcm/bcm63xx_smp.h
@@ -3,7 +3,6 @@
 
 struct device_node;
 
-extern void bcm63138_secondary_startup(void);
 extern int bcm63xx_pmb_power_on_cpu(struct device_node *dn);
 
 #endif /* __BCM63XX_SMP_H */
-- 
2.1.0
