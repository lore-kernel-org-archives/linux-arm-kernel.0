From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:21 +0100
Subject: [PATCH 02/11] KVM: ARM/arm64: fix broken __percpu annotation
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Running sparse results in a bunch of noisy address space mismatches
thanks to the broken __percpu annotation on kvm_get_running_vcpus.

This function returns a pcpu pointer to a pointer, not a pointer to a
pcpu pointer. This patch fixes the annotation, which kills the warnings
from sparse.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kvm/arm.c                | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a99e0cdf8ba2..00a5982ca5bc 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -82,7 +82,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
 /**
  * kvm_arm_get_running_vcpus - get the per-CPU array of currently running vcpus.
  */
-struct kvm_vcpu __percpu **kvm_get_running_vcpus(void)
+struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
 {
 	return &kvm_arm_running_vcpu;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 44094e559848..50431d36732b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -193,7 +193,7 @@ static inline int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 }
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
-struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
+struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
 
-- 
2.1.0.rc1
