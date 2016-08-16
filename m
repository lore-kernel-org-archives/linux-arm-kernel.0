From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 16 Aug 2016 17:10:34 +0200
Subject: [PATCH 2/2] KVM: arm/arm64: Rename vgic_attr_regs_access to
 vgic_attr_regs_access_v2
In-Reply-To: <20160816151034.16930-1-christoffer.dall@linaro.org>
References: <20160816151034.16930-1-christoffer.dall@linaro.org>
Message-ID: <20160816151034.16930-3-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a rename so we can implement a v3-specific function later.  No
functional change.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 22d7ab3..2e18f03 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -296,17 +296,20 @@ static bool lock_all_vcpus(struct kvm *kvm)
 	return true;
 }
 
-/** vgic_attr_regs_access: allows user space to read/write VGIC registers
- *
- * @dev: kvm device handle
- * @attr: kvm device attribute
- * @reg: address the value is read or written
- * @is_write: write flag
+/* V2 ops */
+
+
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
@@ -349,8 +352,6 @@ out:
 	return ret;
 }
 
-/* V2 ops */
-
 static int vgic_v2_set_attr(struct kvm_device *dev,
 			    struct kvm_device_attr *attr)
 {
@@ -369,7 +370,7 @@ static int vgic_v2_set_attr(struct kvm_device *dev,
 		if (get_user(reg, uaddr))
 			return -EFAULT;
 
-		return vgic_attr_regs_access(dev, attr, &reg, true);
+		return vgic_attr_regs_access_v2(dev, attr, &reg, true);
 	}
 	}
 
@@ -391,7 +392,7 @@ static int vgic_v2_get_attr(struct kvm_device *dev,
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 reg = 0;
 
-		ret = vgic_attr_regs_access(dev, attr, &reg, false);
+		ret = vgic_attr_regs_access_v2(dev, attr, &reg, false);
 		if (ret)
 			return ret;
 		return put_user(reg, uaddr);
-- 
2.9.0
