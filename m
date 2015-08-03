From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  3 Aug 2015 17:31:29 +0200
Subject: [PATCH v3 7/7] KVM: arm: enable KVM_SIGNAL_MSI and MSI routing
In-Reply-To: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
References: <1438615889-10892-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1438615889-10892-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ITS modality is not available, let's simply support MSI
injection by transforming the MSI.data into an SPI ID.

This becomes possible to use KVM_SIGNAL_MSI ioctl and MSI
routing for arm too.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
- reword the commit message
- add sanity check about devid provision

v1 -> v2:
- introduce vgic_v2m_inject_msi in vgic-v2-emul.c following Andre's
  advice
---
 arch/arm/kvm/Kconfig        |  1 +
 virt/kvm/arm/vgic-v2-emul.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 151e710..0f58baf 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -31,6 +31,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select HAVE_KVM_MSI
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
index 8faa28c..ba2b393 100644
--- a/virt/kvm/arm/vgic-v2-emul.c
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -478,6 +478,21 @@ static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 }
 
 /**
+ * vgic_v2m_inject_msi: emulates GICv2M MSI injection by injecting
+ * the SPI ID matching the msi data
+ *
+ * @kvm: pointer to the kvm struct
+ * @msi: the msi struct handle
+ */
+static int vgic_v2m_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
+{
+	if (msi->flags & KVM_MSI_VALID_DEVID)
+		return -EINVAL;
+
+	return kvm_vgic_inject_irq(kvm, 0, msi->data, 1);
+}
+
+/**
  * kvm_vgic_map_resources - Configure global VGIC state before running any VCPUs
  * @kvm: pointer to the kvm struct
  *
@@ -566,6 +581,7 @@ void vgic_v2_init_emulation(struct kvm *kvm)
 	dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
 	dist->vm_ops.init_model = vgic_v2_init_model;
 	dist->vm_ops.map_resources = vgic_v2_map_resources;
+	dist->vm_ops.inject_msi = vgic_v2m_inject_msi;
 
 	dist->vgic_cpu_base = VGIC_ADDR_UNDEF;
 	dist->vgic_dist_base = VGIC_ADDR_UNDEF;
-- 
1.9.1
