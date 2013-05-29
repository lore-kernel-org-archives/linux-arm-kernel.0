From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 29 May 2013 12:16:56 +0200
Subject: [PATCH 1/3] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1369822618-26797-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

This commit fix the regression on Armada 370 (the kernal hang during
boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".

When coming out of either a Wait for Interrupt (WFI) or a Wait for
Event (WFE) IDLE states, a specific timing sensitivity exists between
the retiring WFI/WFE instructions and the newly issued subsequent
instructions. This sensitivity can result in a CPU hang scenario.  The
workaround is to insert either a Data Synchronization Barrier (DSB) or
Data Memory Barrier (DMB) command immediately after the WFI/WFE
instruction

[gregory.clement at free-electrons.com:add errata description in changelog]
[gregory.clement at free-electrons.com:make this errata depend on Aramda
370]
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig      | 12 ++++++++++++
 arch/arm/mm/proc-v7.S |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..745781f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1087,6 +1087,18 @@ if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
 
+config PJ4B_ERRATA_4742
+        bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
+        depends on CPU_PJ4B && MACH_ARMADA_370
+        help
+          When coming out of either a Wait for Interrupt (WFI) or a Wait for Event
+	  (WFE) IDLE states, a specific timing sensitivity exists between the retiring
+	  WFI/WFE instructions and the newly issued subsequent instructions.
+	  This sensitivity can result in a CPU hang scenario.
+          Workaround:
+	  The software must insert either a Data Synchronization Barrier (DSB)
+	  or Data Memory Barrier (DMB) command immediately after the WFI/WFE instruction
+
 config ARM_ERRATA_326103
 	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
 	depends on CPU_V6
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c73a73..f872432 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -71,6 +71,9 @@ ENDPROC(cpu_v7_reset)
 ENTRY(cpu_v7_do_idle)
 	dsb					@ WFI may enter a low-power mode
 	wfi
+#ifdef CONFIG_PJ4B_ERRATA_4742
+        mcr     p15, 0, r0, c7, c10, 4          @barrier
+#endif
 	mov	pc, lr
 ENDPROC(cpu_v7_do_idle)
 
-- 
1.8.1.2
