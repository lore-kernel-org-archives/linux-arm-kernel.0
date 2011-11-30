From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 11:12:04 +0000
Subject: [PATCH v2] ARM: errata: Remove SMP dependency for erratum 751472
Message-ID: <1322651524-24095-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Activation conditions for a workaround should not be encoded in the
workaround's direct dependencies if this makes otherwise reasonable
configuration choices impossible.

This patches uses the SMP/UP patching facilities instead to compile
out the workaround if the configuration means that it is definitely
not needed.

This means that configs for buggy silicon can simply select
ARM_ERRATA_751472, without preventing a UP kernel from being built
or duplicatiing knowledge about when to activate the workaround.
This seems the correct why to do things, because the erratum is a
property of the silicon, irrespective of what the kernel config
happens to be.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
Changes since v1:

v2: Fix incorrect use of ALT_SMP()/ALT_UP_B(): they must be used in
    the correct order, otherwise the fixup will reference the wrong
    ALT_SMP() block and get applied in the wrong place.

    Make the whole erratum workaround #ifdef CONFIG_SMP so that we
    don't leave some dead code and an unnecessary branch in the
    image when building a uniprocessor kernel.

 arch/arm/Kconfig      |    2 +-
 arch/arm/mm/proc-v7.S |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..e5bbb2f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1281,7 +1281,7 @@ config ARM_ERRATA_743622
 
 config ARM_ERRATA_751472
 	bool "ARM errata: Interrupted ICIALLUIS may prevent completion of broadcasted operation"
-	depends on CPU_V7 && SMP
+	depends on CPU_V7
 	help
 	  This option enables the workaround for the 751472 Cortex-A9 (prior
 	  to r3p0) erratum. An interrupted ICIALLUIS operation may prevent the
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c559ac..e70a737 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -363,11 +363,13 @@ __v7_setup:
 	orreq	r10, r10, #1 << 6		@ set bit #6
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
-#ifdef CONFIG_ARM_ERRATA_751472
-	cmp	r6, #0x30			@ present prior to r3p0
+#if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
+	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
+	ALT_UP_B(1f)
 	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
 	orrlt	r10, r10, #1 << 11		@ set bit #11
 	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+1:
 #endif
 
 3:	mov	r10, #0
-- 
1.7.4.1
