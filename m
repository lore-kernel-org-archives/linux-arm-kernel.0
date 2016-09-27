From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:11 +0200
Subject: [PULL 03/50] KVM: arm/arm64: Rename vgic_attr_regs_access to
 vgic_attr_regs_access_v2
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-4-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a rename so we can implement a v3-specific function later.

We take the chance to get rid of the V2/V3 ops comments as well.

No functional change.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 19fa331..163b057 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -294,17 +294,17 @@ static bool lock_all_vcpus(struct kvm *kvm)
 	return true;
 }
 
-/** vgic_attr_regs_access: allows user space to read/write VGIC registers
- *
- * @dev: kvm device handle
- * @attr: kvm device attribute
- * @reg: address the value is read or written
- * @is_write: write flag
+/**
+ * vgic_attr_regs_access_v2 - allows user space to access VGIC v2 state
  *
+ * @dev:      kvm device handle
+ * @attr:     kvm device attribute
+ * @reg:      address the value is read or written
+ * @is_write: true if userspace is writing a register
  */
-static int vgic_attr_regs_access(struct kvm_device *dev,
-				 struct kvm_device_attr *attr,
-				 u32 *reg, bool is_write)
+static int vgic_attr_regs_access_v2(struct kvm_device *dev,
+				    struct kvm_device_attr *attr,
+				    u32 *reg, bool is_write)
 {
 	struct vgic_reg_attr reg_attr;
 	gpa_t addr;
@@ -347,8 +347,6 @@ out:
 	return ret;
 }
 
-/* V2 ops */
-
 static int vgic_v2_set_attr(struct kvm_device *dev,
 			    struct kvm_device_attr *attr)
 {
@@ -367,7 +365,7 @@ static int vgic_v2_set_attr(struct kvm_device *dev,
 		if (get_user(reg, uaddr))
 			return -EFAULT;
 
-		return vgic_attr_regs_access(dev, attr, &reg, true);
+		return vgic_attr_regs_access_v2(dev, attr, &reg, true);
 	}
 	}
 
@@ -389,7 +387,7 @@ static int vgic_v2_get_attr(struct kvm_device *dev,
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 reg = 0;
 
-		ret = vgic_attr_regs_access(dev, attr, &reg, false);
+		ret = vgic_attr_regs_access_v2(dev, attr, &reg, false);
 		if (ret)
 			return ret;
 		return put_user(reg, uaddr);
@@ -433,8 +431,6 @@ struct kvm_device_ops kvm_arm_vgic_v2_ops = {
 	.has_attr = vgic_v2_has_attr,
 };
 
-/* V3 ops */
-
 #ifdef CONFIG_KVM_ARM_VGIC_V3
 
 static int vgic_v3_set_attr(struct kvm_device *dev,
-- 
2.9.0
