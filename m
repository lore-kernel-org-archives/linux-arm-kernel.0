From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  9 Mar 2016 10:44:16 -0800
Subject: [PATCH v2 3/3] ARM: errata: Workaround errata A12 825619 / A17 852421
In-Reply-To: <1457549056-22359-1-git-send-email-dianders@chromium.org>
References: <1457549056-22359-1-git-send-email-dianders@chromium.org>
Message-ID: <1457549056-22359-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for both errata is to set bit 24 in the diagnostic
register.  There are no known end-user bugs solved by fixing this
errata, but the fix is trivial and it seems sane to apply it.

The arguments for why this needs to be in the kernel are similar to the
arugments made in the patch "Workaround errata A12 818325/852422 A17
852423".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
-  A12 825619 / A17 852421 new for v2.

 arch/arm/Kconfig      | 18 ++++++++++++++++++
 arch/arm/mm/proc-v7.S | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c3e46c9aacf5..cd3b3fda0e16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1181,6 +1181,24 @@ config ARM_ERRATA_821420
 	  one is in the shadow of a branch or abort, can lead to a
 	  deadlock when the VMOV instructions are issued out-of-order.
 
+config ARM_ERRATA_825619
+	bool "ARM errata: A12: DMB NSHST/ISHST mixed ... might cause deadlock"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 825619 Cortex-A12
+	  (all revs) erratum. Within rare timing constraints, executing a
+	  DMB NSHST or DMB ISHST instruction followed by a mix of Cacheable
+	  and Device/Strongly-Ordered loads and stores might cause deadlock
+
+config ARM_ERRATA_852421
+	bool "ARM errata: A17: DMB ST might fail to create order between stores"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 852421 Cortex-A17
+	  (r1p0, r1p1, r1p2) erratum. Under very rare timing conditions,
+	  execution of a DMB ST instruction might fail to properly order
+	  stores from GroupA and stores from GroupB.
+
 config ARM_ERRATA_852423
 	bool "ARM errata: A17: some seqs of opposed cond code instrs => deadlock or corruption"
 	depends on CPU_V7
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a7f9e7567878..0e20537a7d14 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -373,9 +373,20 @@ __ca12_errata:
 	orr	r10, r10, #1 << 1		@ set bit #1
 	mcr	p15, 0, r10, c15, c0, 2		@ write internal feature reg
 #endif
+#ifdef CONFIG_ARM_ERRATA_825619
+	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orr	r10, r10, #1 << 24		@ set bit #24
+	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
 	b	__errata_finish
 
 __ca17_errata:
+#ifdef CONFIG_ARM_ERRATA_852421
+	cmp	r6, #0x12			@ only present up to r1p2
+	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orrle	r10, r10, #1 << 24		@ set bit #24
+	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
 #ifdef CONFIG_ARM_ERRATA_852423
 	cmp	r6, #0x12			@ only present up to r1p2
 	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-- 
2.7.0.rc3.207.g0ac5344
