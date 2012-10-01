From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:07:40 -0400
Subject: [PATCH v2 01/10] ARM: KVM: Keep track of currently running vcpus
In-Reply-To: <20121001090716.49038.90056.stgit@ubuntu>
References: <20121001090716.49038.90056.stgit@ubuntu>
Message-ID: <20121001090740.49038.4761.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When an interrupt occurs for the guest, it is sometimes necessary
to find out which vcpu was running at that point.

Keep track of which vcpu is being tun in kvm_arch_vcpu_ioctl_run(),
and allow the data to be retrived using either:
- kvm_arm_get_running_vcpu(): returns the vcpu running at this point
  on the current CPU. Can only be used in a non-preemptable context.
- kvm_arm_get_running_vcpus(): returns the per-CPU variable holding
  the the running vcpus, useable for per-CPU interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_host.h |    9 +++++++++
 arch/arm/kvm/arm.c              |   30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index e4b5352..69a8680 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -151,4 +151,13 @@ static inline int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 {
 	return 0;
 }
+
+struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
+struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
+
+int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu);
+struct kvm_one_reg;
+int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 50e9585..8764dd0 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -53,11 +53,38 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
 static unsigned long hyp_default_vectors;
 
+/* Per-CPU variable containing the currently running vcpu. */
+static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
+
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
+{
+	BUG_ON(preemptible());
+	__get_cpu_var(kvm_arm_running_vcpu) = vcpu;
+}
+
+/**
+ * kvm_arm_get_running_vcpu - get the vcpu running on the current CPU.
+ * Must be called from non-preemptible context
+ */
+struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
+{
+	BUG_ON(preemptible());
+	return __get_cpu_var(kvm_arm_running_vcpu);
+}
+
+/**
+ * kvm_arm_get_running_vcpus - get the per-CPU array on currently running vcpus.
+ */
+struct kvm_vcpu __percpu **kvm_get_running_vcpus(void)
+{
+	return &kvm_arm_running_vcpu;
+}
+
 int kvm_arch_hardware_enable(void *garbage)
 {
 	return 0;
@@ -296,10 +323,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
 		flush_cache_all(); /* We'd really want v7_flush_dcache_all() */
 	}
+
+	kvm_arm_set_running_vcpu(vcpu);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_arm_set_running_vcpu(NULL);
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
