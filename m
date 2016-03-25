From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:58 +0000
Subject: [RFC PATCH 35/45] KVM: arm/arm64: vgic-new: Add userland access to
 VGIC dist registers
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-36-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_kvm_device.c | 50 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic_kvm_device.c b/virt/kvm/arm/vgic/vgic_kvm_device.c
index d9f2383..2e2f8b6 100644
--- a/virt/kvm/arm/vgic/vgic_kvm_device.c
+++ b/virt/kvm/arm/vgic/vgic_kvm_device.c
@@ -264,7 +264,55 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
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
+		ret = vgic_v2_dist_access(vcpu, is_write, addr, 4, reg);
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
2.7.3
