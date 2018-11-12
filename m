From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:56:59 +0000
Subject: [PATCH v6 08/24] arm64: Unmask PMR before going idle
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-9-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU does not received signals for interrupts with a priority masked by
ICC_PMR_EL1. This means the CPU might not come back from a WFI
instruction.

Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/proc.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b..3c7064c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -53,10 +54,27 @@
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If the CPU supports priority masking we must do additional work to
+ *	ensure that interrupts are not masked at the PMR (because the core will
+ *	not wake up if we block the wake up signal in the interrupt controller).
  */
 ENTRY(cpu_do_idle)
+alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
+alternative_endif
+	mov	x2, #GIC_PRIO_IRQON
+	msr_s	SYS_ICC_PMR_EL1, x2		// unmask PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
 ENDPROC(cpu_do_idle)
 
-- 
1.9.1
