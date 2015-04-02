From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  2 Apr 2015 14:40:14 +0900
Subject: [v3 3/5] arm64: kvm: add cpu reset hook for cpu hotplug
In-Reply-To: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427953216-11737-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch doesn't enable cpu hotplug under kvm, but is a prerequiste
when the feature is implemented.
Once kvm_arch_hardware_enable/disable() is properly implemented,
arm64-specific cpu notifier hook, hyp_init_cpu_notify(), will be
able to be removed and replaced by generic kvm_cpu_hotplug().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   |    1 -
 arch/arm/kvm/arm.c                |    9 +++++++++
 arch/arm64/include/asm/kvm_host.h |    1 -
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 41008cd..ca97764 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -237,7 +237,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f64713e..4892974 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -922,6 +922,10 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		kvm_cpu_reset(NULL);
+		break;
 	}
 
 	return NOTIFY_OK;
@@ -1165,6 +1169,11 @@ out_err:
 	return err;
 }
 
+void kvm_arch_hardware_disable(void)
+{
+	kvm_cpu_reset(NULL);
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6a8da9c..831e6a4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -262,7 +262,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 	}
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
-- 
1.7.9.5
