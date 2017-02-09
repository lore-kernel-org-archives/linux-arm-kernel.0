From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Feb 2017 14:59:13 +0000
Subject: [PATCH 15/25] KVM: arm/arm64: vgic: Stop injecting the MSI occurrence
 twice
In-Reply-To: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
References: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1486652363-7696-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

The IRQFD framework calls the architecture dependent function
twice if the corresponding GSI type is edge triggered. For ARM,
the function kvm_set_msi() is getting called twice whenever the
IRQFD receives the event signal. The rest of the code path is
trying to inject the MSI without any validation checks. No need
to call the function vgic_its_inject_msi() second time to avoid
an unnecessary overhead in IRQ queue logic. It also avoids the
possibility of VM seeing the MSI twice.

Simple fix, return -1 if the argument 'level' value is zero.

Cc: stable at vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-irqfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
index d918dcf..f138ed2 100644
--- a/virt/kvm/arm/vgic/vgic-irqfd.c
+++ b/virt/kvm/arm/vgic/vgic-irqfd.c
@@ -99,6 +99,9 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	if (!vgic_has_its(kvm))
 		return -ENODEV;
 
+	if (!level)
+		return -1;
+
 	return vgic_its_inject_msi(kvm, &msi);
 }
 
-- 
2.1.4
