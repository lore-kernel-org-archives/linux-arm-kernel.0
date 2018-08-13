From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:30 +0100
Subject: [PATCH 12/37] KVM: arm/arm64: vgic: Define GICD_IIDR fields for GICv2
 and GIv3
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

Instead of hardcoding the shifts and masks in the GICD_IIDR register
emulation, let's add the definition of these fields to the GIC header
files and use them.

This will make things more obvious when we're going to bump the revision
in the IIDR when we'll make guest-visible changes to the implementation.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqchip/arm-gic-v3.h | 10 ++++++++++
 include/linux/irqchip/arm-gic.h    | 10 ++++++++++
 virt/kvm/arm/vgic/vgic-mmio-v2.c   |  3 ++-
 virt/kvm/arm/vgic/vgic-mmio-v3.c   |  3 ++-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index cbb872c1b607..b22f9dfa61af 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -61,6 +61,16 @@
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
 #define GICD_CTLR_ENABLE_G1		(1U << 0)
 
+#define GICD_IIDR_IMPLEMENTER_SHIFT	0
+#define GICD_IIDR_IMPLEMENTER_MASK	(0xfff << GICD_IIDR_IMPLEMENTER_SHIFT)
+#define GICD_IIDR_REVISION_SHIFT	12
+#define GICD_IIDR_REVISION_MASK		(0xf << GICD_IIDR_REVISION_SHIFT)
+#define GICD_IIDR_VARIANT_SHIFT		16
+#define GICD_IIDR_VARIANT_MASK		(0xf << GICD_IIDR_VARIANT_SHIFT)
+#define GICD_IIDR_PRODUCT_ID_SHIFT	24
+#define GICD_IIDR_PRODUCT_ID_MASK	(0xff << GICD_IIDR_PRODUCT_ID_SHIFT)
+
+
 /*
  * In systems with a single security state (what we emulate in KVM)
  * the meaning of the interrupt group enable bits is slightly different
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 68d8b1f73682..484f5bfa9f3d 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -71,6 +71,16 @@
 					(GICD_INT_DEF_PRI << 8) |\
 					GICD_INT_DEF_PRI)
 
+#define GICD_IIDR_IMPLEMENTER_SHIFT	0
+#define GICD_IIDR_IMPLEMENTER_MASK	(0xfff << GICD_IIDR_IMPLEMENTER_SHIFT)
+#define GICD_IIDR_REVISION_SHIFT	12
+#define GICD_IIDR_REVISION_MASK		(0xf << GICD_IIDR_REVISION_SHIFT)
+#define GICD_IIDR_VARIANT_SHIFT		16
+#define GICD_IIDR_VARIANT_MASK		(0xf << GICD_IIDR_VARIANT_SHIFT)
+#define GICD_IIDR_PRODUCT_ID_SHIFT	24
+#define GICD_IIDR_PRODUCT_ID_MASK	(0xff << GICD_IIDR_PRODUCT_ID_SHIFT)
+
+
 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
 #define GICH_VMCR			0x8
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index ffc587bf4742..af44e569373a 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -37,7 +37,8 @@ static unsigned long vgic_mmio_read_v2_misc(struct kvm_vcpu *vcpu,
 		value |= (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
 		break;
 	case GIC_DIST_IIDR:
-		value = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+		value = (PRODUCT_ID_KVM << GICD_IIDR_PRODUCT_ID_SHIFT) |
+			(IMPLEMENTER_ARM << GICD_IIDR_IMPLEMENTER_SHIFT);
 		break;
 	default:
 		return 0;
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 287784095b5b..c03f42409b98 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -81,7 +81,8 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 		}
 		break;
 	case GICD_IIDR:
-		value = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
+		value = (PRODUCT_ID_KVM << GICD_IIDR_PRODUCT_ID_SHIFT) |
+			(IMPLEMENTER_ARM << GICD_IIDR_IMPLEMENTER_SHIFT);
 		break;
 	default:
 		return 0;
-- 
2.18.0
