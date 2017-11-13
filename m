From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:31 +0100
Subject: [PULL 06/27] KVM: arm/arm64: vITS: Add a helper to update the
 affinity of an LPI
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-7-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to help integrating the vITS code with GICv4, let's add
a new helper that deals with updating the affinity of an LPI,
which will later be augmented with super duper extra GICv4
goodness.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 1de4e68ef1b6..09accdfed189 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -336,6 +336,15 @@ static int vgic_copy_lpi_list(struct kvm_vcpu *vcpu, u32 **intid_ptr)
 	return i;
 }
 
+static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
+{
+	spin_lock(&irq->irq_lock);
+	irq->target_vcpu = vcpu;
+	spin_unlock(&irq->irq_lock);
+
+	return 0;
+}
+
 /*
  * Promotes the ITS view of affinity of an ITTE (which redistributor this LPI
  * is targeting) to the VGIC's view, which deals with target VCPUs.
@@ -350,10 +359,7 @@ static void update_affinity_ite(struct kvm *kvm, struct its_ite *ite)
 		return;
 
 	vcpu = kvm_get_vcpu(kvm, ite->collection->target_addr);
-
-	spin_lock(&ite->irq->irq_lock);
-	ite->irq->target_vcpu = vcpu;
-	spin_unlock(&ite->irq->irq_lock);
+	update_affinity(ite->irq, vcpu);
 }
 
 /*
@@ -696,11 +702,7 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 	ite->collection = collection;
 	vcpu = kvm_get_vcpu(kvm, collection->target_addr);
 
-	spin_lock(&ite->irq->irq_lock);
-	ite->irq->target_vcpu = vcpu;
-	spin_unlock(&ite->irq->irq_lock);
-
-	return 0;
+	return update_affinity(ite->irq, vcpu);
 }
 
 /*
-- 
2.14.2
