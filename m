From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Jul 2015 17:19:13 +0100
Subject: [PATCH 10/13] arm64: Add support for running Linux in EL2 mode
In-Reply-To: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436372356-30410-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the ARMv8.1 VHE, the architecture is able to (almost) transparently
run the kernel at EL2, despite being written for EL1.

This patch takes care of the "almost" part, mostly preventing the kernel
from dropping from EL2 to EL1, and setting up the HYP configuration.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/head.S | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c0ff3ce..a179747 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -29,6 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/cputype.h>
+#include <asm/kvm_mmu.h>
 #include <asm/memory.h>
 #include <asm/thread_info.h>
 #include <asm/pgtable-hwdef.h>
@@ -481,8 +482,16 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	isb
 	ret
 
+	/* Check for VHE being present */
+2:	mrs	x2, id_aa64mmfr1_el1
+	ubfx	x2, x2, #8, #4
+
 	/* Hyp configuration. */
-2:	mov	x0, #(1 << 31)			// 64-bit EL1
+	mov	x0, #HCR_RW			// 64-bit EL1
+	cbz	x2, set_hcr
+	orr	x0, x0, #HCR_TGE		// Enable Host Extensions
+	orr	x0, x0, #HCR_E2H
+set_hcr:
 	msr	hcr_el2, x0
 
 	/* Generic timers. */
@@ -522,6 +531,9 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
 	/* Coprocessor traps. */
 	mov	x0, #0x33ff
+	cbz	x2, set_cptr
+	orr	x0, x0, #(3 << 20)		// Don't trap FP
+set_cptr:
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 
 #ifdef CONFIG_COMPAT
@@ -531,6 +543,15 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	/* Stage-2 translation */
 	msr	vttbr_el2, xzr
 
+	cbz	x2, install_el2_stub
+
+	setup_vtcr x4, x5
+
+	mov	w20, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
+	isb
+	ret
+
+install_el2_stub:
 	/* Hypervisor stub */
 	adrp	x0, __hyp_stub_vectors
 	add	x0, x0, #:lo12:__hyp_stub_vectors
-- 
2.1.4
