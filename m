From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 24 Jun 2015 20:30:28 -0700
Subject: [PATCH 3/3] arm: KVM: Add VFP lazy switch hooks in Host KVM
In-Reply-To: <1435203028-23142-1-git-send-email-m.smarduch@samsung.com>
References: <1435203028-23142-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1435203028-23142-4-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements host KVM interface to Hyp mode VFP function to 
switch out guest and switch in host.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/arm.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d9631ec..77b41f5 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -105,6 +105,17 @@ void kvm_arch_check_processor_compat(void *rtn)
 	*(int *)rtn = 0;
 }
 
+/**
+ * kvm_switch_vp_regs() - switch guest/host VFP registers
+ * @vcpu:	pointer to vcpu structure.
+ *
+ * HYP interface functions to save guest and restore host VFP registers
+ */
+static void kvm_switch_fp_regs(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.vfp_guest_saved == 1)
+		kvm_call_hyp(__kvm_restore_host_vfp_state, vcpu);
+}
 
 /**
  * kvm_arch_init_vm - initializes a VM data structure
@@ -292,6 +303,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+
+	/* Check if Guest accessed VFP registers */
+	kvm_switch_fp_regs(vcpu);
+
 	/*
 	 * The arch-generic KVM code expects the cpu field of a vcpu to be -1
 	 * if the vcpu is no longer assigned to a cpu.  This is used for the
-- 
1.7.9.5
