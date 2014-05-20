From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:35:03 +0200
Subject: [PATCH RFCv2 3/5] ARM: allow CONFIG_SMP_ON_UP on non-SMP
 configurations
In-Reply-To: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400600105-3013-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently CONFIG_SMP_ON_UP is used when CONFIG_SMP is enabled to allow
a SMP kernel to boot on UP platforms that do not support certain
aspects of SMP platforms.

However, some of the SMP characteristics are needed on platforms that
have SMP capabilities but are single core, and use their SMP
capabilities to provide hardware I/O coherency. This is for example
the case on Marvell Armada platforms.

Instead of special casing these platforms to enable the SMP and TLB
broadcast bit and use shareable pages, this patch proposes to simply
allow CONFIG_SMP_ON_UP to be enabled even on non-SMP
configurations. When CONFIG_SMP_ON_UP is enabled in a !CONFIG_SMP
configuration, it will check that the processor is SMP capable, and if
yes use all the SMP characteristics (SMP and TLB broadcast bit,
shareable pages, etc.). It will not support multiprocessing of course,
but it will have sufficient capabilities to allow hardware I/O
coherency to work.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Of course, the name of CONFIG_SMP_ON_UP is maybe no longer
appropriate. Suggestions are welcome to change this: this patch is
really the minimal set of changes to get things to work.

We could also decide to completely get rid of CONFIG_SMP_ON_UP and
make it always on. Suggestions welcome.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/Kconfig                 | 2 +-
 arch/arm/include/asm/assembler.h | 2 +-
 arch/arm/include/asm/smp_plat.h  | 8 ++++----
 arch/arm/mm/proc-v7.S            | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb..d3da54b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1501,7 +1501,7 @@ config SMP
 
 config SMP_ON_UP
 	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
-	depends on SMP && !XIP_KERNEL && MMU
+	depends on !XIP_KERNEL && MMU
 	default y
 	help
 	  SMP kernels contain instructions which fail on non-SMP processors.
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b974184..6e9fb68 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -223,7 +223,7 @@
 	.long	9999b,9001f;			\
 	.popsection
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_SMP_ON_UP)
 #define ALT_SMP(instr...)					\
 9998:	instr
 /*
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index a252c0b..496a71d 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -15,13 +15,13 @@
  */
 static inline bool is_smp(void)
 {
-#ifndef CONFIG_SMP
-	return false;
-#elif defined(CONFIG_SMP_ON_UP)
+#if defined(CONFIG_SMP_ON_UP)
 	extern unsigned int smp_on_up;
 	return !!smp_on_up;
-#else
+#elif defined(CONFIG_SMP)
 	return true;
+#else
+	return false;
 #endif
 }
 
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 195731d..c7777a5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -196,7 +196,7 @@ __v7_ca12mp_setup:
 __v7_ca15mp_setup:
 	mov	r10, #0
 1:
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_SMP_ON_UP)
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
 	ALT_UP(mov	r0, #(1 << 6))		@ fake it for UP
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
@@ -248,7 +248,7 @@ __v7_pj4b_setup:
 
 	/* Auxiliary Functional Modes Control Register 0 */
 	mrc	p15, 1,	r0, c15, c2, 0
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_SMP_ON_UP)
 	orr	r0, r0, #PJ4B_SMP_CFB
 #endif
 	orr	r0, r0, #PJ4B_L1_PAR_CHK
-- 
1.9.3
