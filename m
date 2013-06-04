From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  4 Jun 2013 16:03:17 +0200
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

This commit fixes the regression on Armada 370 (the kernal hang during
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
[gregory.clement at free-electrons.com:make this errata depend on Armada 370]
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig      | 13 +++++++++++++
 arch/arm/mm/proc-v7.S |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..95cbe9d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1087,6 +1087,19 @@ if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
 
+config PJ4B_ERRATA_4742
+	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
+	depends on CPU_PJ4B && MACH_ARMADA_370
+	help
+	  When coming out of either a Wait for Interrupt (WFI) or a Wait for
+	  Event (WFE) IDLE states, a specific timing sensitivity exists between
+	  the retiring WFI/WFE instructions and the newly issued subsequent
+	  instructions.  This sensitivity can result in a CPU hang scenario.
+	  Workaround:
+	  The software must insert either a Data Synchronization Barrier (DSB)
+	  or Data Memory Barrier (DMB) command immediately after the WFI/WFE
+	  instruction
+
 config ARM_ERRATA_326103
 	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
 	depends on CPU_V6
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c73a73..784bef1 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -71,6 +71,9 @@ ENDPROC(cpu_v7_reset)
 ENTRY(cpu_v7_do_idle)
 	dsb					@ WFI may enter a low-power mode
 	wfi
+#ifdef CONFIG_PJ4B_ERRATA_4742
+	dsb					@barrier
+#endif
 	mov	pc, lr
 ENDPROC(cpu_v7_do_idle)
 
-- 
1.8.1.2
