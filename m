From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Jul 2015 17:19:09 +0100
Subject: [PATCH 06/13] arm64: KVM: VHE: Patch out kern_hyp_va
In-Reply-To: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436372356-30410-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kern_hyp_va macro is pretty meaninless with VHE, as there is
only one mapping - the kernel one.

In order to keep the code readable and efficient, use runtime
patching to replace the 'and' instruction used to compute the VA
with a 'nop'.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b525cd2..285642e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -55,6 +55,8 @@
 
 #ifdef __ASSEMBLY__
 
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm_arm.h>
 
 .macro setup_vtcr tmp1, tmp2
@@ -69,12 +71,18 @@
 	msr	vtcr_el2, \tmp1
 	isb
 .endm
+
+/* Stupid macro to deal with multiple level of macro expansion */
+.macro __vhe_nop inst val
+	alternative_insn "\inst\val", "nop", ARM64_HAS_VIRT_HOST_EXTN
+.endm
+
 /*
  * Convert a kernel VA into a HYP VA.
  * reg: VA to be converted.
  */
 .macro kern_hyp_va	reg
-	and	\reg, \reg, #HYP_PAGE_OFFSET_MASK
+	__vhe_nop "and \reg, \reg, #", __stringify(HYP_PAGE_OFFSET_MASK)
 .endm
 
 #else
-- 
2.1.4
