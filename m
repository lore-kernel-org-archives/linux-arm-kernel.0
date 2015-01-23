From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:01 +0100
Subject: [GIT PULL 32/36] arm/arm64: KVM: enable kernel side of GICv3 emulation
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-33-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

With all the necessary GICv3 emulation code in place, we can now
connect the code to the GICv3 backend in the kernel.
The LR register handling is different depending on the emulated GIC
model, so provide different implementations for each.
Also allow non-v2-compatible GICv3 implementations (which don't
provide MMIO regions for the virtual CPU interface in the DT), but
restrict those hosts to support GICv3 guests only.
If the device tree provides a GICv2 compatible GICV resource entry,
but that one is faulty, just disable the GICv2 emulation and let the
user use at least the GICv3 emulation for guests.
To provide proper support for the legacy KVM_CREATE_IRQCHIP ioctl,
note virtual GICv2 compatibility in struct vgic_params and use it
on creating a VGICv2.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h |  2 ++
 virt/kvm/arm/vgic-v2.c |  1 +
 virt/kvm/arm/vgic-v3.c | 76 +++++++++++++++++++++++++++++++++-----------------
 virt/kvm/arm/vgic.c    | 14 ++++++++++
 4 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index b9b2e05..39039d5 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -134,6 +134,8 @@ struct vgic_params {
 	/* Virtual control interface base address */
 	void __iomem	*vctrl_base;
 	int		max_gic_vcpus;
+	/* Only needed for the legacy KVM_CREATE_IRQCHIP */
+	bool		can_emulate_gicv2;
 };
 
 struct vgic_vm_ops {
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index e8b82b2..a0a7b5d 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -229,6 +229,7 @@ int vgic_v2_probe(struct device_node *vgic_node,
 		goto out_unmap;
 	}
 
+	vgic->can_emulate_gicv2 = true;
 	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
 
 	vgic->vcpu_base = vcpu_res.start;
diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
index 5249048..3a62d8a 100644
--- a/virt/kvm/arm/vgic-v3.c
+++ b/virt/kvm/arm/vgic-v3.c
@@ -34,6 +34,7 @@
 #define GICH_LR_VIRTUALID		(0x3ffUL << 0)
 #define GICH_LR_PHYSID_CPUID_SHIFT	(10)
 #define GICH_LR_PHYSID_CPUID		(7UL << GICH_LR_PHYSID_CPUID_SHIFT)
+#define ICH_LR_VIRTUALID_MASK		(BIT_ULL(32) - 1)
 
 /*
  * LRs are stored in reverse order in memory. make sure we index them
@@ -48,12 +49,17 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
 	struct vgic_lr lr_desc;
 	u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
 
-	lr_desc.irq	= val & GICH_LR_VIRTUALID;
-	if (lr_desc.irq <= 15)
-		lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		lr_desc.irq = val & ICH_LR_VIRTUALID_MASK;
 	else
-		lr_desc.source = 0;
-	lr_desc.state	= 0;
+		lr_desc.irq = val & GICH_LR_VIRTUALID;
+
+	lr_desc.source = 0;
+	if (lr_desc.irq <= 15 &&
+	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2)
+		lr_desc.source = (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
+
+	lr_desc.state = 0;
 
 	if (val & ICH_LR_PENDING_BIT)
 		lr_desc.state |= LR_STATE_PENDING;
@@ -68,8 +74,20 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
 static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
 			   struct vgic_lr lr_desc)
 {
-	u64 lr_val = (((u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT) |
-		      lr_desc.irq);
+	u64 lr_val;
+
+	lr_val = lr_desc.irq;
+
+	/*
+	 * Currently all guest IRQs are Group1, as Group0 would result
+	 * in a FIQ in the guest, which it wouldn't expect.
+	 * Eventually we want to make this configurable, so we may revisit
+	 * this in the future.
+	 */
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		lr_val |= ICH_LR_GROUP;
+	else
+		lr_val |= (u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT;
 
 	if (lr_desc.state & LR_STATE_PENDING)
 		lr_val |= ICH_LR_PENDING_BIT;
@@ -154,7 +172,15 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
 	 */
 	vgic_v3->vgic_vmcr = 0;
 
-	vgic_v3->vgic_sre = 0;
+	/*
+	 * If we are emulating a GICv3, we do it in an non-GICv2-compatible
+	 * way, so we force SRE to 1 to demonstrate this to the guest.
+	 * This goes with the spec allowing the value to be RAO/WI.
+	 */
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;
+	else
+		vgic_v3->vgic_sre = 0;
 
 	/* Get the show on the road... */
 	vgic_v3->vgic_hcr = ICH_HCR_EN;
@@ -209,34 +235,34 @@ int vgic_v3_probe(struct device_node *vgic_node,
 	 * maximum of 16 list registers. Just ignore bit 4...
 	 */
 	vgic->nr_lr = (ich_vtr_el2 & 0xf) + 1;
+	vgic->can_emulate_gicv2 = false;
 
 	if (of_property_read_u32(vgic_node, "#redistributor-regions", &gicv_idx))
 		gicv_idx = 1;
 
 	gicv_idx += 3; /* Also skip GICD, GICC, GICH */
 	if (of_address_to_resource(vgic_node, gicv_idx, &vcpu_res)) {
-		kvm_err("Cannot obtain GICV region\n");
-		ret = -ENXIO;
-		goto out;
-	}
-
-	if (!PAGE_ALIGNED(vcpu_res.start)) {
-		kvm_err("GICV physical address 0x%llx not page aligned\n",
+		kvm_info("GICv3: no GICV resource entry\n");
+		vgic->vcpu_base = 0;
+	} else if (!PAGE_ALIGNED(vcpu_res.start)) {
+		pr_warn("GICV physical address 0x%llx not page aligned\n",
 			(unsigned long long)vcpu_res.start);
-		ret = -ENXIO;
-		goto out;
-	}
-
-	if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
-		kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
+		vgic->vcpu_base = 0;
+	} else if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
+		pr_warn("GICV size 0x%llx not a multiple of page size 0x%lx\n",
 			(unsigned long long)resource_size(&vcpu_res),
 			PAGE_SIZE);
-		ret = -ENXIO;
-		goto out;
+		vgic->vcpu_base = 0;
+	} else {
+		vgic->vcpu_base = vcpu_res.start;
+		vgic->can_emulate_gicv2 = true;
+		kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
+					KVM_DEV_TYPE_ARM_VGIC_V2);
 	}
-	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (vgic->vcpu_base == 0)
+		kvm_info("disabling GICv2 emulation\n");
+	kvm_register_device_ops(&kvm_arm_vgic_v3_ops, KVM_DEV_TYPE_ARM_VGIC_V3);
 
-	vgic->vcpu_base = vcpu_res.start;
 	vgic->vctrl_base = NULL;
 	vgic->type = VGIC_V3;
 	vgic->max_gic_vcpus = KVM_MAX_VCPUS;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 6d23e57..2efba82 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1550,6 +1550,11 @@ static int init_vgic_model(struct kvm *kvm, int type)
 	case KVM_DEV_TYPE_ARM_VGIC_V2:
 		vgic_v2_init_emulation(kvm);
 		break;
+#ifdef CONFIG_ARM_GIC_V3
+	case KVM_DEV_TYPE_ARM_VGIC_V3:
+		vgic_v3_init_emulation(kvm);
+		break;
+#endif
 	default:
 		return -ENODEV;
 	}
@@ -1573,6 +1578,15 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	}
 
 	/*
+	 * This function is also called by the KVM_CREATE_IRQCHIP handler,
+	 * which had no chance yet to check the availability of the GICv2
+	 * emulation. So check this here again. KVM_CREATE_DEVICE does
+	 * the proper checks already.
+	 */
+	if (type == KVM_DEV_TYPE_ARM_VGIC_V2 && !vgic->can_emulate_gicv2)
+		return -ENODEV;
+
+	/*
 	 * Any time a vcpu is run, vcpu_load is called which tries to grab the
 	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
 	 * that no other VCPUs are run while we create the vgic.
-- 
2.1.2.330.g565301e.dirty
