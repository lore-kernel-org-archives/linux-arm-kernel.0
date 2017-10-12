From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:09 +0200
Subject: [PATCH 05/37] KVM: Record the executing ioctl number on the vcpu
 struct
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-6-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures may decide to do different things during
kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
arm64 is about to do significant work in vcpu load/put when running a
vcpu, but not when doing things like KVM_SET_ONE_REG or
KVM_SET_MP_STATE.

Therefore, store the ioctl number that we are executing on the VCPU
during the first vcpu_load() which succeeds in getting the vcpu->mutex
and set the ioctl number to 0 when exiting kvm_vcpu_ioctl() after
successfully loading the vcpu.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr?m?? <rkrcmar@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/x86/kvm/vmx.c       | 2 +-
 arch/x86/kvm/x86.c       | 8 ++++----
 include/linux/kvm_host.h | 3 ++-
 virt/kvm/kvm_main.c      | 6 ++++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6970249..d729889 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9493,7 +9493,7 @@ static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
        struct vcpu_vmx *vmx = to_vmx(vcpu);
        int r;
 
-       r = vcpu_load(vcpu);
+       r = vcpu_load(vcpu, vcpu->ioctl);
        BUG_ON(r);
        vmx_switch_vmcs(vcpu, &vmx->vmcs01);
        free_nested(vmx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd17b7d..68d9c95 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7723,7 +7723,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	int r;
 
 	kvm_vcpu_mtrr_init(vcpu);
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, vcpu->ioctl);
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
@@ -7739,7 +7739,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	kvm_hv_vcpu_postcreate(vcpu);
 
-	if (vcpu_load(vcpu))
+	if (vcpu_load(vcpu, vcpu->ioctl))
 		return;
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
@@ -7759,7 +7759,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	int r;
 	vcpu->arch.apf.msr_val = 0;
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, vcpu->ioctl);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
@@ -8116,7 +8116,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 {
 	int r;
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, vcpu->ioctl);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538..da0acc0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -274,6 +274,7 @@ struct kvm_vcpu {
 	bool preempted;
 	struct kvm_vcpu_arch arch;
 	struct dentry *debugfs_dentry;
+	unsigned int ioctl; /* ioctl currently executing or 0 */
 };
 
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
@@ -533,7 +534,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
-int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+int __must_check vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a2..1911ef0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -147,12 +147,13 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-int vcpu_load(struct kvm_vcpu *vcpu)
+int vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl)
 {
 	int cpu;
 
 	if (mutex_lock_killable(&vcpu->mutex))
 		return -EINTR;
+	vcpu->ioctl = ioctl;
 	cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -2529,7 +2530,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, ioctl);
 	if (r)
 		return r;
 	switch (ioctl) {
@@ -2704,6 +2705,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	}
 out:
 	vcpu_put(vcpu);
+	vcpu->ioctl = 0;
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.9.0
