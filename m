From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:32 +0100
Subject: [PATCH v2 8/9] arm/arm64: KVM: vgic: make number of irqs a
 configurable attribute
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make the number of interrupt configurable, use the new
fancy device management API to add KVM_DEV_ARM_VGIC_GRP_NR_IRQS as
a VGIC configurable attribute.

Userspace can now specify the exact size of the GIC (by increments
of 32 interrupts).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/uapi/asm/kvm.h   |  1 +
 arch/arm64/include/uapi/asm/kvm.h |  1 +
 virt/kvm/arm/vgic.c               | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index e6ebdd3..8b51c1a 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -173,6 +173,7 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
+#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index e633ff8..b5cd6ed 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -159,6 +159,7 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
+#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 6e13ff9..b0cd417 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2165,6 +2165,28 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 		return vgic_attr_regs_access(dev, attr, &reg, true);
 	}
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 val;
+		int ret = 0;
+
+		if (get_user(val, uaddr))
+			return -EFAULT;
+
+		if (val > 1024 || (val & 31))
+			return -EINVAL;
+
+		mutex_lock(&dev->kvm->lock);
+
+		if (vgic_initialized(dev->kvm))
+			ret = -EBUSY;
+		else
+			dev->kvm->arch.vgic.nr_irqs = val;
+
+		mutex_unlock(&dev->kvm->lock);
+
+		return ret;
+	}
 
 	}
 
@@ -2201,6 +2223,11 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = put_user(reg, uaddr);
 		break;
 	}
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
+		break;
+	}
 
 	}
 
@@ -2237,6 +2264,8 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
 		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
 		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
+	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
+		return 0;
 	}
 	return -ENXIO;
 }
-- 
1.8.3.4
