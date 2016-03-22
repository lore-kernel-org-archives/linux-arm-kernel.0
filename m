From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 22 Mar 2016 09:19:36 +0100
Subject: [PULL 3/3] kvm: arm64: Disable compiler instrumentation for
 hypervisor code
In-Reply-To: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
References: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1458634776-18388-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

With the recent rewrite of the arm64 KVM hypervisor code in C, enabling
certain options like KASAN would allow the compiler to generate memory
accesses or function calls to addresses not mapped at EL2. This patch
disables the compiler instrumentation on the arm64 hypervisor code for
gcov-based profiling (GCOV_KERNEL), undefined behaviour sanity checker
(UBSAN) and kernel address sanitizer (KASAN).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: <stable@vger.kernel.org> # 4.5+
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index b6a8fc5..778d0ef 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -16,3 +16,7 @@ obj-$(CONFIG_KVM_ARM_HOST) += fpsimd.o
 obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
-- 
2.1.2.330.g565301e.dirty
