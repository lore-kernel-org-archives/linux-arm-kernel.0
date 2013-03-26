From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 16:37:22 +0000
Subject: [PATCH] ARM: KVM: promote vfp_host pointer to generic host cpu context
Message-ID: <1364315842-20317-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use the vfp_host pointer to store the host VFP context, should
the guest start using VFP itself.

Actually, we can use this pointer in a more generic way to store
CPU speficic data, and arm64 is using it to dump the whole host
state before switching to the guest.

Simply rename the vfp_host field to host_cpu_context, and the
corresponding type to kvm_cpu_context_t. No change in functionnality.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h |  8 +++++---
 arch/arm/kvm/arm.c              | 28 ++++++++++++++--------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 78813b8..a7a0bb5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -87,7 +87,7 @@ struct kvm_vcpu_fault_info {
 	u32 hyp_pc;		/* PC when exception was taken from Hyp mode */
 };
 
-typedef struct vfp_hard_struct kvm_kernel_vfp_t;
+typedef struct vfp_hard_struct kvm_cpu_context_t;
 
 struct kvm_vcpu_arch {
 	struct kvm_regs regs;
@@ -105,8 +105,10 @@ struct kvm_vcpu_arch {
 	struct kvm_vcpu_fault_info fault;
 
 	/* Floating point registers (VFP and Advanced SIMD/NEON) */
-	kvm_kernel_vfp_t vfp_guest;
-	kvm_kernel_vfp_t *vfp_host;
+	struct vfp_hard_struct vfp_guest;
+
+	/* Host FP context */
+	kvm_cpu_context_t *host_cpu_context;
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e821c37..2ce90bb 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -48,7 +48,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
-static kvm_kernel_vfp_t __percpu *kvm_host_vfp_state;
+static kvm_cpu_context_t __percpu *kvm_host_cpu_state;
 static unsigned long hyp_default_vectors;
 
 /* Per-CPU variable containing the currently running vcpu. */
@@ -325,7 +325,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->cpu = cpu;
-	vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
+	vcpu->arch.host_cpu_context = this_cpu_ptr(kvm_host_cpu_state);
 
 	/*
 	 * Check whether this vcpu requires the cache to be flushed on
@@ -889,24 +889,24 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Map the host VFP structures
+	 * Map the host CPU structures
 	 */
-	kvm_host_vfp_state = alloc_percpu(kvm_kernel_vfp_t);
-	if (!kvm_host_vfp_state) {
+	kvm_host_cpu_state = alloc_percpu(kvm_cpu_context_t);
+	if (!kvm_host_cpu_state) {
 		err = -ENOMEM;
-		kvm_err("Cannot allocate host VFP state\n");
+		kvm_err("Cannot allocate host CPU state\n");
 		goto out_free_mappings;
 	}
 
 	for_each_possible_cpu(cpu) {
-		kvm_kernel_vfp_t *vfp;
+		kvm_cpu_context_t *cpu_ctxt;
 
-		vfp = per_cpu_ptr(kvm_host_vfp_state, cpu);
-		err = create_hyp_mappings(vfp, vfp + 1);
+		cpu_ctxt = per_cpu_ptr(kvm_host_cpu_state, cpu);
+		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1);
 
 		if (err) {
-			kvm_err("Cannot map host VFP state: %d\n", err);
-			goto out_free_vfp;
+			kvm_err("Cannot map host CPU state: %d\n", err);
+			goto out_free_context;
 		}
 	}
 
@@ -915,7 +915,7 @@ static int init_hyp_mode(void)
 	 */
 	err = kvm_vgic_hyp_init();
 	if (err)
-		goto out_free_vfp;
+		goto out_free_context;
 
 #ifdef CONFIG_KVM_ARM_VGIC
 		vgic_present = true;
@@ -933,8 +933,8 @@ static int init_hyp_mode(void)
 	kvm_info("Hyp mode initialized successfully\n");
 
 	return 0;
-out_free_vfp:
-	free_percpu(kvm_host_vfp_state);
+out_free_context:
+	free_percpu(kvm_host_cpu_state);
 out_free_mappings:
 	free_hyp_pmds();
 out_free_stack_pages:
-- 
1.8.1.4
