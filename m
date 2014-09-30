From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 13:38:20 +0200
Subject: [PATCH] ARM: KVM: fix vgic-disabled build
Message-ID: <3777204.xp7MBjnQbJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vgic code can be disabled in Kconfig and there are dummy implementations
of most of the provided API functions for the disabled case.

However, the newly introduced kvm_vgic_destroy/kvm_vgic_vcpu_destroy
functions are lacking those dummies, resulting in this build error:

arch/arm/kvm/arm.c: In function 'kvm_arch_destroy_vm':
arch/arm/kvm/arm.c:165:2: error: implicit declaration of function 'kvm_vgic_destroy' [-Werror=implicit-function-declaration]
  kvm_vgic_destroy(kvm);
  ^
arch/arm/kvm/arm.c: In function 'kvm_arch_vcpu_free':
arch/arm/kvm/arm.c:248:2: error: implicit declaration of function 'kvm_vgic_vcpu_destroy' [-Werror=implicit-function-declaration]
  kvm_vgic_vcpu_destroy(vcpu);
  ^

This adds two inline helpers to get it to build again in this configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c1bfb577add ("arm/arm64: KVM: vgic: switch to dynamic allocation")
---
found during randconfig testing on -next

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 2f2aac8448a4..ec559d3264cc 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -331,6 +331,14 @@ static inline int kvm_vgic_create(struct kvm *kvm)
 	return 0;
 }
 
+static inline void kvm_vgic_destroy(struct kvm *kvm)
+{
+}
+
+static inline void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+}
+
 static inline int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	return 0;
