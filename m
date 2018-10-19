From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:41 +0100
Subject: [PATCH 06/26] kvm: arm/arm64: Allow arch specific configurations for
 VM
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Allow the arch backends to perform VM specific initialisation.
This will be later used to handle IPA size configuration and per-VM
VTCR configuration on arm64.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 7 +++++++
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/reset.c            | 7 +++++++
 virt/kvm/arm/arm.c                | 5 +++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3ad482d2f1eb..72d46418e1ef 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
+static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+{
+	if (type)
+		return -EINVAL;
+	return 0;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d7336f871..b04280ae1be0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -513,4 +513,6 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
+int kvm_arm_config_vm(struct kvm *kvm, unsigned long type);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e37c78bbe1ca..b0c07dab5cb3 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -133,3 +133,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset timer */
 	return kvm_timer_vcpu_reset(vcpu);
 }
+
+int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+{
+	if (type)
+		return -EINVAL;
+	return 0;
+}
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index c92053bc3f96..327d0fd28380 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -120,8 +120,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret, cpu;
 
-	if (type)
-		return -EINVAL;
+	ret = kvm_arm_config_vm(kvm, type);
+	if (ret)
+		return ret;
 
 	kvm->arch.last_vcpu_ran = alloc_percpu(typeof(*kvm->arch.last_vcpu_ran));
 	if (!kvm->arch.last_vcpu_ran)
-- 
2.19.1
