From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 20 Jul 2016 18:32:25 +0530
Subject: [RFC PATCH v1 1/4] arm/arm64: vgic-new: Introduce 64-bit reg access
 support
In-Reply-To: <1469019748-31005-1-git-send-email-vijay.kilari@gmail.com>
References: <1469019748-31005-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1469019748-31005-2-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

vgic_attr_regs_access() handles only 32-bit register
value. Introduce union ureg to handle both 32 and 64 bit
register size.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index cc843fe..cace996 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -19,6 +19,11 @@
 #include <asm/kvm_mmu.h>
 #include "vgic.h"
 
+union ureg {
+	u32 reg32;
+	u64 reg64;
+};
+
 /* common helpers */
 
 static int vgic_check_ioaddr(struct kvm *kvm, phys_addr_t *ioaddr,
@@ -255,7 +260,7 @@ void kvm_register_vgic_device(unsigned long type)
  */
 static int vgic_attr_regs_access(struct kvm_device *dev,
 				 struct kvm_device_attr *attr,
-				 u32 *reg, bool is_write)
+				 union ureg *reg, bool is_write)
 {
 	gpa_t addr;
 	int cpuid, ret, c;
@@ -293,10 +298,10 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
-		ret = vgic_v2_cpuif_uaccess(vcpu, is_write, addr, reg);
+		ret = vgic_v2_cpuif_uaccess(vcpu, is_write, addr, &reg->reg32);
 		break;
 	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
-		ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, reg);
+		ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, &reg->reg32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -328,9 +333,9 @@ static int vgic_v2_set_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
 	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg;
+		union ureg reg;
 
-		if (get_user(reg, uaddr))
+		if (get_user(reg.reg32, uaddr))
 			return -EFAULT;
 
 		return vgic_attr_regs_access(dev, attr, &reg, true);
@@ -353,12 +358,12 @@ static int vgic_v2_get_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
 	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
-		u32 reg = 0;
+		union ureg reg;
 
 		ret = vgic_attr_regs_access(dev, attr, &reg, false);
 		if (ret)
 			return ret;
-		return put_user(reg, uaddr);
+		return put_user(reg.reg32, uaddr);
 	}
 	}
 
-- 
1.7.9.5
