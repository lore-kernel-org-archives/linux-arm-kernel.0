From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 20:30:12 -0800
Subject: [PATCH v3 1/9] ARM: KVM: Allow creating the VGIC after VCPUs
In-Reply-To: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384662620-13795-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the VGIC initialization slightly to allow initialization of the
vgic cpu-specific state even if the irqchip (the VGIC) hasn't been
created by user space yet.  This is safe, because the vgic data
structures are already allocated when the CPU is allocated if VGIC
support is compiled into the kernel.  Further, the init process does not
depend on any other information and the sacrifice is a slight
performance degradation for creating VMs in the no-VGIC case.

The reason is that the new device control API doesn't mandate creating
the VGIC before creating the VCPU and it is unreasonable to require user
space to create the VGIC before creating the VCPUs.

At the same time move the irqchip_in_kernel check out of
kvm_vcpu_first_run_init and into the init function to make the per-vcpu
and global init functions symmetric and add comments on the exported
functions making it a bit easier to understand the init flow by only
looking at vgic.c.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c  |    7 ++++---
 virt/kvm/arm/vgic.c |   22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2bc2ec4..e80b6a1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -464,6 +464,8 @@ static void update_vttbr(struct kvm *kvm)
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 {
+	int ret;
+
 	if (likely(vcpu->arch.has_run_once))
 		return 0;
 
@@ -473,9 +475,8 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 * Initialize the VGIC before running a vcpu the first time on
 	 * this VM.
 	 */
-	if (irqchip_in_kernel(vcpu->kvm) &&
-	    unlikely(!vgic_initialized(vcpu->kvm))) {
-		int ret = kvm_vgic_init(vcpu->kvm);
+	if (unlikely(!vgic_initialized(vcpu->kvm))) {
+		ret = kvm_vgic_init(vcpu->kvm);
 		if (ret)
 			return ret;
 	}
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 81e9481..5e9df47 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1243,15 +1243,19 @@ static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
+ * @vcpu: pointer to the vcpu struct
+ *
+ * Initialize the vgic_cpu struct and vgic_dist struct fields pertaining to
+ * this vcpu and enable the VGIC for this VCPU
+ */
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int i;
 
-	if (!irqchip_in_kernel(vcpu->kvm))
-		return 0;
-
 	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
 		return -EBUSY;
 
@@ -1383,10 +1387,22 @@ out:
 	return ret;
 }
 
+/**
+ * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
+ * @kvm: pointer to the kvm struct
+ *
+ * Map the virtual CPU interface into the VM before running any VCPUs.  We
+ * can't do this at creation time, because user space must first set the
+ * virtual CPU interface address in the guest physical address space.  Also
+ * initialize the ITARGETSRn regs to 0 on the emulated distributor.
+ */
 int kvm_vgic_init(struct kvm *kvm)
 {
 	int ret = 0, i;
 
+	if (!irqchip_in_kernel(kvm))
+		return 0;
+
 	mutex_lock(&kvm->lock);
 
 	if (vgic_initialized(kvm))
-- 
1.7.10.4
