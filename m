From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 27 Aug 2013 22:38:20 +0100
Subject: [PATCH 10/19] vexpress: add big endian support
In-Reply-To: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377639509-22778-11-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the versatile express systems to boot big-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-vexpress/Kconfig    |    1 +
 arch/arm/plat-versatile/headsmp.S |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index b8bbabe..d9dc5d2a 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,6 +1,7 @@
 config ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index 2677bc3..40f27e5 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -10,6 +10,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/assembler.h>
 
 /*
  * Realview/Versatile Express specific entry point for secondary CPUs.
@@ -17,6 +18,7 @@
  * until we're ready for them to initialise.
  */
 ENTRY(versatile_secondary_startup)
+ ARM_BE8(setend	be)
 	mrc	p15, 0, r0, c0, c0, 5
 	bic	r0, #0xff000000
 	adr	r4, 1f
-- 
1.7.10.4
