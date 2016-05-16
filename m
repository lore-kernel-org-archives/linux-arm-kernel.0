From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 16 May 2016 10:54:31 +0100
Subject: [PATCH v4 46/56] KVM: arm/arm64: vgic-new: Add userland access to
 VGIC dist registers
In-Reply-To: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1463392481-26583-104-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userland may want to save and restore the state of the in-kernel VGIC,
so we provide the code which takes a userland request and translate
that into calls to our MMIO framework.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 50 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 78621283..c3ec453 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -238,7 +238,55 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 				 struct kvm_device_attr *attr,
 				 u32 *reg, bool is_write)
 {
-	return -ENXIO;
+	gpa_t addr;
+	int cpuid, ret, c;
+	struct kvm_vcpu *vcpu, *tmp_vcpu;
+
+	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
+		 KVM_DEV_ARM_VGIC_CPUID_SHIFT;
+	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
+	addr = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+
+	mutex_lock(&dev->kvm->lock);
+
+	ret = vgic_init(dev->kvm);
+	if (ret)
+		goto out;
+
+	if (cpuid >= atomic_read(&dev->kvm->online_vcpus)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Ensure that no other VCPU is running by checking the vcpu->cpu
+	 * field.  If no other VPCUs are running we can safely access the VGIC
+	 * state, because even if another VPU is run after this point, that
+	 * VCPU will not touch the vgic state, because it will block on
+	 * getting the vgic->lock in kvm_vgic_sync_hwstate().
+	 */
+	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm) {
+		if (unlikely(tmp_vcpu->cpu != -1)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		ret = -EINVAL;
+		break;
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, reg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out:
+	mutex_unlock(&dev->kvm->lock);
+	return ret;
 }
 
 /* V2 ops */
-- 
2.8.2
