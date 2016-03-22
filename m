From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 22 Mar 2016 09:19:35 +0100
Subject: [PULL 2/3] arm64: KVM: Turn kvm_ksym_ref into a NOP on VHE
In-Reply-To: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
References: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1458634776-18388-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When running with VHE, there is no need to translate kernel pointers
to the EL2 memory space, since we're already there (and we have a much
saner memory map to start with).

Unfortunately, kvm_ksym_ref is getting in the way, and the first
call into the "hypervisor" section is going to end up in fireworks,
since we're now branching into nowhereland. Meh.

A potential solution is to test if VHE is engaged or not, and only
perform the translation in the negative case. With this in place,
VHE is able to run again.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 226f49d..eb7490d 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -26,7 +26,13 @@
 #define KVM_ARM64_DEBUG_DIRTY_SHIFT	0
 #define KVM_ARM64_DEBUG_DIRTY		(1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
 
-#define kvm_ksym_ref(sym)		phys_to_virt((u64)&sym - kimage_voffset)
+#define kvm_ksym_ref(sym)						\
+	({								\
+		void *val = &sym;					\
+		if (!is_kernel_in_hyp_mode())				\
+			val = phys_to_virt((u64)&sym - kimage_voffset);	\
+		val;							\
+	 })
 
 #ifndef __ASSEMBLY__
 struct kvm;
-- 
2.1.2.330.g565301e.dirty
