From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 17:31:28 +0200
Subject: [PATCH v3 6/7] KVM: arm/arm64: enable MSI routing
In-Reply-To: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
References: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438615889-10892-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now, only irqchip routing entries could be set. This patch
adds the capability to insert MSI routing entries.

For ARM64, let's also increase KVM_MAX_IRQ_ROUTES to 4096: this
include SPI irqchip routes plus MSI routes. In the future this
might be extended.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v2 -> v3:
- remove any reference to KVM_IRQ_ROUTING_EXTENDED_MSI type
- unconditionnaly uapi flags and devid downto the kernel
  routing entry struct
- handle KVM_MSI_VALID_DEVID flag in kvm_set_irq_routing
- note about KVM_CAP_MSI_DEVID moved in the first patch file
  of the series

v1 -> v2:
- adapt to new routing entry types

RFC -> PATCH:
- move api MSI routing updates into that patch file
- use new devid field of user api struct
---
 Documentation/virtual/kvm/api.txt | 5 +++++
 include/linux/kvm_host.h          | 2 ++
 virt/kvm/arm/vgic.c               | 8 ++++++++
 virt/kvm/irqchip.c                | 2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index b6913c9..4f15347 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2352,6 +2352,11 @@ On arm/arm64, gsi routing being supported, the following can happen:
 - in case no routing entry is associated to this gsi, injection fails
 - in case the gsi is associated to an irqchip routing entry,
   irqchip.pin + 32 corresponds to the injected SPI ID.
+- in case the gsi is associated to an MSI routing entry,
+  * without GICv3 ITS in-kernel emulation, MSI data matches the SPI ID
+    of the injected SPI
+  * with GICv3 ITS in-kernel emulation, the MSI message and device ID
+    are translated into an LPI.
 
 4.76 KVM_PPC_ALLOCATE_HTAB
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b784465..d00a113 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -995,6 +995,8 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 
 #ifdef CONFIG_S390
 #define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
+#elif defined(CONFIG_ARM64)
+#define KVM_MAX_IRQ_ROUTES 4096
 #else
 #define KVM_MAX_IRQ_ROUTES 1024
 #endif
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 1b092e3..0165f34 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2260,6 +2260,14 @@ int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
 		    (e->irqchip.irqchip >= KVM_NR_IRQCHIPS))
 			goto out;
 		break;
+	case KVM_IRQ_ROUTING_MSI:
+		e->set = kvm_set_msi;
+		e->msi.address_lo = ue->u.msi.address_lo;
+		e->msi.address_hi = ue->u.msi.address_hi;
+		e->msi.data = ue->u.msi.data;
+		e->flags = ue->flags;
+		e->devid = ue->u.msi.devid;
+		break;
 	default:
 		goto out;
 	}
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index e1559d4..48ebc4d 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -217,7 +217,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 			goto out;
 
 		r = -EINVAL;
-		if (ue->flags)
+		if (ue->flags & ~KVM_MSI_VALID_DEVID)
 			goto out;
 		r = setup_routing_entry(new, e, ue);
 		if (r)
-- 
1.9.1
