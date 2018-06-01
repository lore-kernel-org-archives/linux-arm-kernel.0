From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:38 +0100
Subject: [PATCH 24/33] KVM: arm/arm64: Helper to locate free rdist index
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-25-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

We introduce vgic_v3_rdist_free_slot to help identifying
where we can place a new 2x64KB redistributor.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  3 +--
 virt/kvm/arm/vgic/vgic-v3.c      | 23 +++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h         | 11 +++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index d1aab183a1cc..49ca176e2e08 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -593,8 +593,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	 * function for all VCPUs when the base address is set.  Just return
 	 * without doing any work for now.
 	 */
-	rdreg = list_first_entry(&vgic->rd_regions,
-				 struct vgic_redist_region, list);
+	rdreg = vgic_v3_rdist_free_slot(&vgic->rd_regions);
 	if (!rdreg)
 		return 0;
 
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 56e6e903d998..2a11fe89943a 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -453,6 +453,29 @@ bool vgic_v3_check_base(struct kvm *kvm)
 	return false;
 }
 
+/**
+ * vgic_v3_rdist_free_slot - Look up registered rdist regions and identify one
+ * which has free space to put a new rdist region.
+ *
+ * @rd_regions: redistributor region list head
+ *
+ * A redistributor regions maps n redistributors, n = region size / (2 x 64kB).
+ * Stride between redistributors is 0 and regions are filled in the index order.
+ *
+ * Return: the redist region handle, if any, that has space to map a new rdist
+ * region.
+ */
+struct vgic_redist_region *vgic_v3_rdist_free_slot(struct list_head *rd_regions)
+{
+	struct vgic_redist_region *rdreg;
+
+	list_for_each_entry(rdreg, rd_regions, list) {
+		if (!vgic_v3_redist_region_full(rdreg))
+			return rdreg;
+	}
+	return NULL;
+}
+
 int vgic_v3_map_resources(struct kvm *kvm)
 {
 	int ret = 0;
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 32c25d42c93f..fddd57ff6529 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -265,6 +265,17 @@ static inline int vgic_v3_max_apr_idx(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline bool
+vgic_v3_redist_region_full(struct vgic_redist_region *region)
+{
+	if (!region->count)
+		return false;
+
+	return (region->free_index >= region->count);
+}
+
+struct vgic_redist_region *vgic_v3_rdist_free_slot(struct list_head *rdregs);
+
 int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 			 u32 devid, u32 eventid, struct vgic_irq **irq);
 struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
-- 
2.17.1
