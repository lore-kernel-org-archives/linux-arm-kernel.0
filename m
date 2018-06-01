From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:15 +0100
Subject: [PATCH 01/33] arm64: KVM: Use lm_alias() for kvm_ksym_ref()
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

For historical reasons, we open-code lm_alias() in kvm_ksym_ref().

Let's use lm_alias() to avoid duplication and make things clearer.

As we have to pull this from <linux/mm.h> (which is not safe for
inclusion in assembly), we may as well move the kvm_ksym_ref()
definition into the existing !__ASSEMBLY__ block.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f6648a3e4152..a9ceeec5a76f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -33,16 +33,19 @@
 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
 
+#ifndef __ASSEMBLY__
+
+#include <linux/mm.h>
+
 /* Translate a kernel address of @sym into its equivalent linear mapping */
 #define kvm_ksym_ref(sym)						\
 	({								\
 		void *val = &sym;					\
 		if (!is_kernel_in_hyp_mode())				\
-			val = phys_to_virt((u64)&sym - kimage_voffset);	\
+			val = lm_alias(&sym);				\
 		val;							\
 	 })
 
-#ifndef __ASSEMBLY__
 struct kvm;
 struct kvm_vcpu;
 
-- 
2.17.1
