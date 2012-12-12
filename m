From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Dec 2012 16:25:50 -0600
Subject: [PATCH 2/2] ARM: disable errata work-arounds which access secure
 registers
Message-ID: <1355351150-15942-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In order to support secure and non-secure platforms in multi-platform
kernels, errata work-arounds that access secure only registers need to
be disabled. Make all the errata options that fit in this category
depend on !CONFIG_ARCH_MULTIPLATFORM.

This will effectively remove the errata options as platforms are
converted over to multi-platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig               |    6 ++++++
 arch/arm/mach-vexpress/Kconfig |    1 -
 arch/arm/mm/proc-v7.S          |    3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9759fec..5f14e29 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1225,6 +1225,7 @@ config ARM_ERRATA_430973
 config ARM_ERRATA_458693
 	bool "ARM errata: Processor deadlock when a false hazard is created"
 	depends on CPU_V7
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
 	  erratum. For very specific sequences of memory operations, it is
@@ -1238,6 +1239,7 @@ config ARM_ERRATA_458693
 config ARM_ERRATA_460075
 	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
 	depends on CPU_V7
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
 	  erratum. Any asynchronous access to the L2 cache may encounter a
@@ -1250,6 +1252,7 @@ config ARM_ERRATA_460075
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
 	depends on CPU_V7 && SMP
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742230 Cortex-A9
 	  (r1p0..r2p2) erratum. Under rare circumstances, a DMB instruction
@@ -1262,6 +1265,7 @@ config ARM_ERRATA_742230
 config ARM_ERRATA_742231
 	bool "ARM errata: Incorrect hazard handling in the SCU may lead to data corruption"
 	depends on CPU_V7 && SMP
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 742231 Cortex-A9
 	  (r2p0..r2p2) erratum. Under certain conditions, specific to the
@@ -1312,6 +1316,7 @@ config PL310_ERRATA_727915
 config ARM_ERRATA_743622
 	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
 	depends on CPU_V7
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 743622 Cortex-A9
 	  (r2p*) erratum. Under very rare conditions, a faulty
@@ -1325,6 +1330,7 @@ config ARM_ERRATA_743622
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
 	depends on CPU_V7
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 751472 Cortex-A9 (prior
 	  to r3p0) erratum. An interrupted ICIALLUIS operation may prevent the
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index c952960..a5ecf89 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -40,7 +40,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	bool "Enable A5 and A9 only errata work-arounds"
 	default y
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_751472
 	select PL310_ERRATA_753970 if CACHE_PL310
 	help
 	  Provides common dependencies for Versatile Express platforms
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 846d279..d269b42 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -188,7 +188,8 @@ __v7_setup:
 	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
 	teq	r0, r10
 	bne	2f
-#ifdef CONFIG_ARM_ERRATA_430973
+#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+
 	teq	r5, #0x00100000			@ only present in r1p*
 	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
 	orreq	r10, r10, #(1 << 6)		@ set IBE to 1
-- 
1.7.10.4
