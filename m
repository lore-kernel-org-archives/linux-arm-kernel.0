From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 21 Aug 2014 14:06:50 +0100
Subject: [PATCH v2 09/15] arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
In-Reply-To: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1408626416-11326-10-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic_set_attr() and vgic_get_attr() contain both code specific for
the emulated GIC as well as code for the userland facing, generic
part of the GIC.
Split the guest GIC facing code of from the generic part to allow
easier splitting later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic.c |   79 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index e8f92b2..3386557 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2301,7 +2301,8 @@ out:
 	return ret;
 }
 
-static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+static int vgic_set_common_attr(struct kvm_device *dev,
+				struct kvm_device_attr *attr)
 {
 	int r;
 
@@ -2317,17 +2318,6 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
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
@@ -2356,7 +2346,33 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
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
 
@@ -2374,18 +2390,6 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			return -EFAULT;
 		break;
 	}
-
-	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
-		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg = 0;
-
-		r = vgic_attr_regs_access(dev, attr, &reg, false);
-		if (r)
-			return r;
-		r = put_user(reg, uaddr);
-		break;
-	}
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
@@ -2403,6 +2407,31 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	return r;
 }
 
+static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	ret = vgic_get_common_attr(dev, attr);
+	if (ret != -ENXIO)
+		return ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg = 0;
+
+		ret = vgic_attr_regs_access(dev, attr, &reg, false);
+		if (ret)
+			return ret;
+		return put_user(reg, uaddr);
+	}
+
+	}
+
+	return -ENXIO;
+}
+
 static int vgic_has_attr_regs(const struct mmio_range *ranges,
 			      phys_addr_t offset)
 {
-- 
1.7.9.5
