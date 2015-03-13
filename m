From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 13:07:26 +0100
Subject: [PATCH v2 2/8] ARM: move HYP text to end of .text section
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426248452-4773-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HYP text is essentially a separate binary from the kernel proper,
so it can be moved away from the rest of the kernel. This helps prevent
link failures due to branch relocations exceeding their range.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 8 ++++++--
 arch/arm/kvm/init.S           | 5 +----
 arch/arm/kvm/interrupts.S     | 4 +---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73e8076..e3b9403bd2d6 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -22,11 +22,14 @@
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
+	VMLINUX_SYMBOL(__idmap_text_end) = .;
+
+#define HYP_TEXT							\
 	. = ALIGN(32);							\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;			\
+	*(.hyp.text)
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -118,6 +121,7 @@ SECTIONS
 		. = ALIGN(4);
 		*(.got)			/* Global offset table		*/
 			ARM_CPU_KEEP(PROC_INFO)
+			HYP_TEXT
 	}
 
 #ifdef CONFIG_DEBUG_RODATA
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 3988e72d16ff..7a377d36de5d 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -51,8 +51,7 @@
  *   Switches to the runtime PGD, set stack and vectors.
  */
 
-	.text
-	.pushsection    .hyp.idmap.text,"ax"
+	.section    ".hyp.idmap.text", #alloc
 	.align 5
 __kvm_hyp_init:
 	.globl __kvm_hyp_init
@@ -155,5 +154,3 @@ target:	@ We're now in the trampoline code, switch page tables
 
 	.globl __kvm_hyp_init_end
 __kvm_hyp_init_end:
-
-	.popsection
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 79caf79b304a..db22e9bedfcd 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -27,7 +27,7 @@
 #include <asm/vfpmacros.h>
 #include "interrupts_head.S"
 
-	.text
+	.section	".hyp.text", #alloc
 
 __kvm_hyp_code_start:
 	.globl __kvm_hyp_code_start
@@ -316,8 +316,6 @@ THUMB(	orr	r2, r2, #PSR_T_BIT	)
 	eret
 .endm
 
-	.text
-
 	.align 5
 __kvm_hyp_vector:
 	.globl __kvm_hyp_vector
-- 
1.8.3.2
