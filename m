From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Jan 2013 12:39:57 +0100
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter in
 THUMB mode
Message-ID: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM cores are not capable to run in ARM mode (e.g. Cortex-M3). So
obviously these cannot enter the kernel in ARM mode. Make an exception
for them and let them enter in THUMB mode.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/head-nommu.S |    8 +++++++-
 arch/arm/kernel/head.S       |    8 +++++++-
 arch/arm/mm/Kconfig          |    6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 3782320..ae7ed46 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,15 +32,21 @@
  * numbers for r1.
  *
  */
-	.arm
 
 	__HEAD
+
+#ifdef CONFIG_THUMBONLY_CPU
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
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4eee351..0af2749 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -73,15 +73,21 @@
  * crap here - that's what the boot loader (or in extreme, well justified
  * circumstances, zImage) is for.
  */
-	.arm
 
 	__HEAD
+
+#ifdef CONFIG_THUMBONLY_CPU
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
 
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3fd629d..bc3150c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1,5 +1,11 @@
 comment "Processor Type"
 
+# Select this if your CPU doesn't support the 32 bit ARM instructions.
+config THUMBONLY_CPU
+	bool
+	select THUMB2_KERNEL
+	select ARM_THUMB
+
 # Select CPU types depending on the architecture selected.  This selects
 # which CPUs we support in the kernel image, and the compiler instruction
 # optimiser behaviour.
-- 
1.7.10.4
