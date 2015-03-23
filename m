From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 23 Mar 2015 20:53:58 +0900
Subject: [RFC 3/4] arm64: kvm: add cpu reset hook for cpu hotplug
In-Reply-To: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427111639-4575-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch doesn't enable cpu hotplug under kvm, but is a prerequiste
when the feature is implemented.
Once kvm_arch_hardware_enable/disable() is properly implemented,
arm64-specific cpu notifier hook, hyp_init_cpu_notify(), will be
able to be removed and replaced by generic kvm_cpu_hotplug().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c                |    9 +++++++++
 arch/arm64/include/asm/kvm_host.h |    1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index b879cf6..08804d3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -925,6 +925,10 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 		break;
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		kvm_cpu_reset(NULL);
+		break;
 	}
 
 	return NOTIFY_OK;
@@ -1168,6 +1172,11 @@ out_err:
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
index 97f88fe..a97b2fe 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -261,7 +261,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
 	}
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
-- 
1.7.9.5
