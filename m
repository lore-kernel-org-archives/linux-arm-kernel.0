From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Nov 2017 17:58:19 +0000
Subject: [PATCH 5/7] KVM: arm/arm64: vgic-v4: Only perform an unmap for valid
 vLPIs
In-Reply-To: <20171116175821.26544-1-marc.zyngier@arm.com>
References: <20171116175821.26544-1-marc.zyngier@arm.com>
Message-ID: <20171116175821.26544-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before performing an unmap, let's check that what we have was
really mapped the first place.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 53c324aa44ef..4a37292855bc 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -337,8 +337,10 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int virq,
 		goto out;
 
 	WARN_ON(!(irq->hw && irq->host_irq == virq));
-	irq->hw = false;
-	ret = its_unmap_vlpi(virq);
+	if (irq->hw) {
+		irq->hw = false;
+		ret = its_unmap_vlpi(virq);
+	}
 
 out:
 	mutex_unlock(&its->its_lock);
-- 
2.14.2
