From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  9 Mar 2016 10:44:15 -0800
Subject: [PATCH v2 2/3] ARM: errata: Workaround erratum A12 821420
In-Reply-To: <1457549056-22359-1-git-send-email-dianders@chromium.org>
References: <1457549056-22359-1-git-send-email-dianders@chromium.org>
Message-ID: <1457549056-22359-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This erratum has a very simple workaround (set a bit in a register), so
let's apply it.  Apparently the workaround's downside is a very slight
power impact.

Note that applying this errata fixes deadlocks that are easy to
reproduce with real world applications.

The arguments for why this needs to be in the kernel are similar to the
arugments made in the patch "Workaround errata A12 818325/852422 A17
852423".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- A12 821420 new for v2.

 arch/arm/Kconfig      | 10 ++++++++++
 arch/arm/mm/proc-v7.S |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a5e16e4e796b..c3e46c9aacf5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1171,6 +1171,16 @@ config ARM_ERRATA_818325_852422
 	  Feature Register. This bit disables an optimisation applied to a
 	  sequence of 2 instructions that use opposing condition codes.
 
+config ARM_ERRATA_821420
+	bool "ARM errata: A12: sequence of VMOV to core registers might lead to a dead lock"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 821420 Cortex-A12
+	  (all revs) erratum. In very rare timing conditions, a sequence
+	  of VMOV to Core registers instructions, for which the second
+	  one is in the shadow of a branch or abort, can lead to a
+	  deadlock when the VMOV instructions are issued out-of-order.
+
 config ARM_ERRATA_852423
 	bool "ARM errata: A17: some seqs of opposed cond code instrs => deadlock or corruption"
 	depends on CPU_V7
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6cea0435f3f2..a7f9e7567878 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -368,6 +368,11 @@ __ca12_errata:
 	orr	r10, r10, #1 << 12		@ set bit #12
 	mcr	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
+#ifdef CONFIG_ARM_ERRATA_821420
+	mrc	p15, 0, r10, c15, c0, 2		@ read internal feature reg
+	orr	r10, r10, #1 << 1		@ set bit #1
+	mcr	p15, 0, r10, c15, c0, 2		@ write internal feature reg
+#endif
 	b	__errata_finish
 
 __ca17_errata:
-- 
2.7.0.rc3.207.g0ac5344
