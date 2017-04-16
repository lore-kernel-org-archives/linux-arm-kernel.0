From: nisalmenuka23@gmail.com (Nisal Menuka)
Date: Sat, 15 Apr 2017 19:06:06 -0500
Subject: [PATCH] Remove ARM errata Workarounds 458693 and 460075
Message-ID: <1492301166-10292-1-git-send-email-nisalmenuka23@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ARM, these errata exist only in a version of Cortex-A8
(r2p0) which was never built. Therefore, I believe there are no platforms
where this workaround should be enabled.
link :http://infocenter.arm.com/help/index.jsp?topic=
/com.arm.doc.faqs/ka15634.html

Signed-off-by: Nisal Menuka <nisalmenuka23@gmail.com>
---
 arch/arm/Kconfig      | 27 ---------------------------
 arch/arm/mm/proc-v7.S | 14 --------------
 2 files changed, 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0d4e71b..d527963 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1005,33 +1005,6 @@ config ARM_ERRATA_430973
 	  Note that setting specific bits in the ACTLR register may not be
 	  available in non-secure mode.
 
-config ARM_ERRATA_458693
-	bool "ARM errata: Processor deadlock when a false hazard is created"
-	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
-	help
-	  This option enables the workaround for the 458693 Cortex-A8 (r2p0)
-	  erratum. For very specific sequences of memory operations, it is
-	  possible for a hazard condition intended for a cache line to instead
-	  be incorrectly associated with a different cache line. This false
-	  hazard might then cause a processor deadlock. The workaround enables
-	  the L1 caching of the NEON accesses and disables the PLD instruction
-	  in the ACTLR register. Note that setting specific bits in the ACTLR
-	  register may not be available in non-secure mode.
-
-config ARM_ERRATA_460075
-	bool "ARM errata: Data written to the L2 cache can be overwritten with stale data"
-	depends on CPU_V7
-	depends on !ARCH_MULTIPLATFORM
-	help
-	  This option enables the workaround for the 460075 Cortex-A8 (r2p0)
-	  erratum. Any asynchronous access to the L2 cache may encounter a
-	  situation in which recent store transactions to the L2 cache are lost
-	  and overwritten with stale memory contents from external memory. The
-	  workaround disables the write-allocate mode for the L2 cache via the
-	  ACTLR register. Note that setting specific bits in the ACTLR register
-	  may not be available in non-secure mode.
-
 config ARM_ERRATA_742230
 	bool "ARM errata: DMB operation may be faulty"
 	depends on CPU_V7 && SMP
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d00d52c..43a4a12 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -306,20 +306,6 @@ __ca8_errata:
 	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
 	mcreq	p15, 0, r0, c1, c0, 1		@ write aux control register
 #endif
-#ifdef CONFIG_ARM_ERRATA_458693
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
-	orreq	r0, r0, #(1 << 5)		@ set L1NEON to 1
-	orreq	r0, r0, #(1 << 9)		@ set PLDNOP to 1
-	mcreq	p15, 0, r0, c1, c0, 1		@ write aux control register
-#endif
-#ifdef CONFIG_ARM_ERRATA_460075
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 1, r0, c9, c0, 2		@ read L2 cache aux ctrl register
-	tsteq	r0, #1 << 22
-	orreq	r0, r0, #(1 << 22)		@ set the Write Allocate disable bit
-	mcreq	p15, 1, r0, c9, c0, 2		@ write the L2 cache aux ctrl register
-#endif
 	b	__errata_finish
 
 __ca9_errata:
-- 
2.7.4
