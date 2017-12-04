From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:36 +0100
Subject: [PULL 07/19] KVM: arm/arm64: vgic-v4: Only perform an unmap for valid
 vLPIs
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-5-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Before performing an unmap, let's check that what we have was
really mapped the first place.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
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
