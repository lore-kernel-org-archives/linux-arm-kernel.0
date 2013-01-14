From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 14 Jan 2013 12:15:23 +0100
Subject: [PATCH v2] ARM: let CPUs not being able to run in ARM mode enter in
 THUMB mode
In-Reply-To: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1358162123-30113-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM cores are not capable to run in ARM mode (e.g. Cortex-M3). So
obviously these cannot enter the kernel in ARM mode. Make an exception
for them and let them enter in THUMB mode.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1,
id: 1357904397-8476-1-git-send-email-u.kleine-koenig at pengutronix.de:

 - drop modification to entry for MMU machines
 - don't select user-visible symbols
 - rename THUMBONLY_CPU to CPU_THUMBONLY
 - move CPU_THUMBONLY definition further down in arch/arm/mm/Kconfig

 arch/arm/Kconfig             |    3 ++-
 arch/arm/kernel/head-nommu.S |    8 +++++++-
 arch/arm/mm/Kconfig          |    9 ++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..e04c779 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1656,8 +1656,9 @@ config HZ
 	default 100
 
 config THUMB2_KERNEL
-	bool "Compile the kernel in Thumb-2 mode"
+	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on CPU_V7 && !CPU_V6 && !CPU_V6K
+	default y if CPU_THUMBONLY
 	select AEABI
 	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 3782320..e8ecae2 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,15 +32,21 @@
  * numbers for r1.
  *
  */
-	.arm
 
 	__HEAD
+
+#ifdef CONFIG_CPU_THUMBONLY
+	.thumb
+ENTRY(stext)
+#else
+	.arm
 ENTRY(stext)
 
  THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
  THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
  THUMB(	.thumb			)	@ switch to Thumb now.
  THUMB(1:			)
+#endif
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3fd629d..8defd63 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -397,6 +397,13 @@ config CPU_V7
 	select CPU_PABRT_V7
 	select CPU_TLB_V7 if MMU
 
+config CPU_THUMBONLY
+	bool
+	# There are no CPUs available with MMU that don't implement an ARM ISA:
+	depends on !MMU
+	help
+	  Select this if your CPU doesn't support the 32 bit ARM instructions.
+
 # Figure out what processor architecture version we should be using.
 # This defines the compiler instruction set which depends on the machine type.
 config CPU_32v3
@@ -608,7 +615,7 @@ config ARCH_DMA_ADDR_T_64BIT
 	bool
 
 config ARM_THUMB
-	bool "Support Thumb user binaries"
+	bool "Support Thumb user binaries" if !CPU_THUMBONLY
 	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
 	default y
 	help
-- 
1.7.10.4
