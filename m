From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:25 -0500
Subject: [RFC 29/55] KVM: arm/arm64: Set up the prepared vgic state
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-30-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since vgic state is properly prepared and is pointed by hw_v2_cpu_if,
let's use it to manipulate vgic.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 virt/kvm/arm/hyp/vgic-v2-sr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/hyp/vgic-v2-sr.c b/virt/kvm/arm/hyp/vgic-v2-sr.c
index c8aeb7b..5d4898f 100644
--- a/virt/kvm/arm/hyp/vgic-v2-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v2-sr.c
@@ -22,10 +22,15 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
+static __hyp_text struct vgic_v2_cpu_if *__hyp_get_cpu_if(struct kvm_vcpu *vcpu)
+{
+	return kern_hyp_va(vcpu->arch.vgic_cpu.hw_v2_cpu_if);
+}
+
 static void __hyp_text save_maint_int_state(struct kvm_vcpu *vcpu,
 					    void __iomem *base)
 {
-	struct vgic_v2_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_v2_cpu_if *cpu_if = __hyp_get_cpu_if(vcpu);
 	int nr_lr = (kern_hyp_va(&kvm_vgic_global_state))->nr_lr;
 	u32 eisr0, eisr1;
 	int i;
@@ -67,7 +72,7 @@ static void __hyp_text save_maint_int_state(struct kvm_vcpu *vcpu,
 
 static void __hyp_text save_elrsr(struct kvm_vcpu *vcpu, void __iomem *base)
 {
-	struct vgic_v2_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_v2_cpu_if *cpu_if = __hyp_get_cpu_if(vcpu);
 	int nr_lr = (kern_hyp_va(&kvm_vgic_global_state))->nr_lr;
 	u32 elrsr0, elrsr1;
 
@@ -86,7 +91,7 @@ static void __hyp_text save_elrsr(struct kvm_vcpu *vcpu, void __iomem *base)
 
 static void __hyp_text save_lrs(struct kvm_vcpu *vcpu, void __iomem *base)
 {
-	struct vgic_v2_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_v2_cpu_if *cpu_if = __hyp_get_cpu_if(vcpu);
 	int nr_lr = (kern_hyp_va(&kvm_vgic_global_state))->nr_lr;
 	int i;
 
@@ -107,7 +112,7 @@ static void __hyp_text save_lrs(struct kvm_vcpu *vcpu, void __iomem *base)
 void __hyp_text __vgic_v2_save_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
-	struct vgic_v2_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_v2_cpu_if *cpu_if = __hyp_get_cpu_if(vcpu);
 	struct vgic_dist *vgic = &kvm->arch.vgic;
 	void __iomem *base = kern_hyp_va(vgic->vctrl_base);
 
@@ -138,7 +143,7 @@ void __hyp_text __vgic_v2_save_state(struct kvm_vcpu *vcpu)
 void __hyp_text __vgic_v2_restore_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
-	struct vgic_v2_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v2;
+	struct vgic_v2_cpu_if *cpu_if = __hyp_get_cpu_if(vcpu);
 	struct vgic_dist *vgic = &kvm->arch.vgic;
 	void __iomem *base = kern_hyp_va(vgic->vctrl_base);
 	int nr_lr = (kern_hyp_va(&kvm_vgic_global_state))->nr_lr;
-- 
1.9.1
