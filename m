From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:14 +0000
Subject: [PATCH 20/29] ARM: KVM: use kvm_kernel_vfp_t as an abstract type for
 VFP containers
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to keep the VFP allocation code common, use an abstract type
for the VFP containers. Maps onto struct vfp_hard_struct on ARM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 6 ++++--
 arch/arm/kvm/arm.c              | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index f00a557..0c4e643 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -87,6 +87,8 @@ struct kvm_vcpu_fault_info {
 	u32 hyp_pc;		/* PC when exception was taken from Hyp mode */
 };
 
+typedef struct vfp_hard_struct kvm_kernel_vfp_t;
+
 struct kvm_vcpu_arch {
 	struct kvm_regs regs;
 
@@ -103,8 +105,8 @@ struct kvm_vcpu_arch {
 	struct kvm_vcpu_fault_info fault;
 
 	/* Floating point registers (VFP and Advanced SIMD/NEON) */
-	struct vfp_hard_struct vfp_guest;
-	struct vfp_hard_struct *vfp_host;
+	kvm_kernel_vfp_t vfp_guest;
+	kvm_kernel_vfp_t *vfp_host;
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3c7c50a..f053049 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -49,7 +49,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
-static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
+static kvm_kernel_vfp_t __percpu *kvm_host_vfp_state;
 static unsigned long hyp_default_vectors;
 
 /* Per-CPU variable containing the currently running vcpu. */
@@ -908,7 +908,7 @@ static int init_hyp_mode(void)
 	/*
 	 * Map the host VFP structures
 	 */
-	kvm_host_vfp_state = alloc_percpu(struct vfp_hard_struct);
+	kvm_host_vfp_state = alloc_percpu(kvm_kernel_vfp_t);
 	if (!kvm_host_vfp_state) {
 		err = -ENOMEM;
 		kvm_err("Cannot allocate host VFP state\n");
@@ -916,7 +916,7 @@ static int init_hyp_mode(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		struct vfp_hard_struct *vfp;
+		kvm_kernel_vfp_t *vfp;
 
 		vfp = per_cpu_ptr(kvm_host_vfp_state, cpu);
 		err = create_hyp_mappings(vfp, vfp + 1);
-- 
1.7.12.4
