From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 13:36:46 +0100
Subject: [PATCH 10/10] vexpress: add big endian support
In-Reply-To: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1371645406-16873-11-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the versatile express systems to boot big-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-vexpress/Kconfig    |    1 +
 arch/arm/plat-versatile/headsmp.S |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 5907e10..fa69d4e 100644
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
index b178d44..4c5c8ca 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -10,6 +10,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/assembler.h>
 
 	__INIT
 
@@ -19,6 +20,7 @@
  * until we're ready for them to initialise.
  */
 ENTRY(versatile_secondary_startup)
+ ARM_BE8(setend	be)
 	mrc	p15, 0, r0, c0, c0, 5
 	bic	r0, #0xff000000
 	adr	r4, 1f
-- 
1.7.10.4
