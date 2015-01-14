From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 14 Jan 2015 16:31:15 +0000
Subject: [PATCH v7 11/20] arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
In-Reply-To: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1421253084-9663-12-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic_set_attr() and vgic_get_attr() contain both code specific for
the emulated GIC as well as code for the userland facing, generic
part of the GIC.
Split the guest GIC facing code of from the generic part to allow
easier splitting later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changelog v6...v7:
 (none)

Changelog v5...v6:
 (none)

Changelog v4...v5:
 (add Reviewed-by:)

Changelog v3...v4:
 (none)

 virt/kvm/arm/vgic.c |   78 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 7589e2c..06073fa 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2440,7 +2440,8 @@ out:
 	return ret;
 }
 
-static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+static int vgic_set_common_attr(struct kvm_device *dev,
+				struct kvm_device_attr *attr)
 {
 	int r;
 
@@ -2456,17 +2457,6 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = kvm_vgic_addr(dev->kvm, type, &addr, true);
 		return (r == -ENODEV) ? -ENXIO : r;
 	}
-
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg;
-
-		if (get_user(reg, uaddr))
-			return -EFAULT;
-
-		return vgic_attr_regs_access(dev, attr, &reg, true);
-	}
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 val;
@@ -2510,7 +2500,33 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return -ENXIO;
 }
 
-static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_set_common_attr(dev, attr);
+	if (ret != -ENXIO)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg;
+
+		if (get_user(reg, uaddr))
+			return -EFAULT;
+
+		return vgic_attr_regs_access(dev, attr, &reg, true);
+	}
+
+	}
+
+	return -ENXIO;
+}
+
+static int vgic_get_common_attr(struct kvm_device *dev,
+				struct kvm_device_attr *attr)
 {
 	int r = -ENXIO;
 
@@ -2528,27 +2544,41 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			return -EFAULT;
 		break;
 	}
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+
+		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
+		break;
+	}
+
+	}
+
+	return r;
+}
+
+static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_get_common_attr(dev, attr);
+	if (ret != -ENXIO)
+		return ret;
 
+	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
 	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 reg = 0;
 
-		r = vgic_attr_regs_access(dev, attr, &reg, false);
-		if (r)
-			return r;
-		r = put_user(reg, uaddr);
-		break;
-	}
-	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
-		break;
+		ret = vgic_attr_regs_access(dev, attr, &reg, false);
+		if (ret)
+			return ret;
+		return put_user(reg, uaddr);
 	}
 
 	}
 
-	return r;
+	return -ENXIO;
 }
 
 static int vgic_has_attr_regs(const struct mmio_range *ranges,
-- 
1.7.9.5
