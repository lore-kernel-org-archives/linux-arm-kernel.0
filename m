From: eric.auger@redhat.com (Eric Auger)
Date: Sat,  6 May 2017 17:24:34 +0200
Subject: [PATCH v7 15/24] KVM: arm64: vgic-its: Read config and pending bit in
 add_lpi()
In-Reply-To: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1494084283-12723-16-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating the lpi we now ask the redistributor what is the state
of the LPI (priority, enabled, pending).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- fix a typo

v6: creation
---
 virt/kvm/arm/vgic/vgic-its.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 3601790..ffd0a80 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -36,6 +36,8 @@
 static int vgic_its_save_tables_v0(struct vgic_its *its);
 static int vgic_its_restore_tables_v0(struct vgic_its *its);
 static int vgic_its_commit_v0(struct vgic_its *its);
+static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
+			     struct kvm_vcpu *filter_vcpu);
 
 /*
  * Creates a new (reference to a) struct vgic_irq for a given LPI.
@@ -44,10 +46,12 @@ static int vgic_its_commit_v0(struct vgic_its *its);
  * If this is a "new" LPI, we allocate and initialize a new struct vgic_irq.
  * This function returns a pointer to the _unlocked_ structure.
  */
-static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid)
+static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
+				     struct kvm_vcpu *vcpu)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct vgic_irq *irq = vgic_get_irq(kvm, NULL, intid), *oldirq;
+	int ret;
 
 	/* In this case there is no put, since we keep the reference. */
 	if (irq)
@@ -64,6 +68,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid)
 	irq->config = VGIC_CONFIG_EDGE;
 	kref_init(&irq->refcount);
 	irq->intid = intid;
+	irq->target_vcpu = vcpu;
 
 	spin_lock(&dist->lpi_list_lock);
 
@@ -95,6 +100,19 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid)
 out_unlock:
 	spin_unlock(&dist->lpi_list_lock);
 
+	/*
+	 * We "cache" the configuration table entries in our struct vgic_irq's.
+	 * However we only have those structs for mapped IRQs, so we read in
+	 * the respective config data from memory here upon mapping the LPI.
+	 */
+	ret = update_lpi_config(kvm, irq, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = vgic_v3_lpi_sync_pending_status(kvm, irq);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return irq;
 }
 
@@ -795,6 +813,7 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	u32 event_id = its_cmd_get_id(its_cmd);
 	u32 coll_id = its_cmd_get_collection(its_cmd);
 	struct its_ite *ite;
+	struct kvm_vcpu *vcpu = NULL;
 	struct its_device *device;
 	struct its_collection *collection, *new_coll = NULL;
 	int lpi_nr;
@@ -840,7 +859,10 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	ite->collection = collection;
 	ite->lpi = lpi_nr;
 
-	irq = vgic_add_lpi(kvm, lpi_nr);
+	if (its_is_collection_mapped(collection))
+		vcpu = kvm_get_vcpu(kvm, collection->target_addr);
+
+	irq = vgic_add_lpi(kvm, lpi_nr, vcpu);
 	if (IS_ERR(irq)) {
 		if (new_coll)
 			vgic_its_free_collection(its, coll_id);
@@ -849,15 +871,6 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	}
 	ite->irq = irq;
 
-	update_affinity_ite(kvm, ite);
-
-	/*
-	 * We "cache" the configuration table entries in out struct vgic_irq's.
-	 * However we only have those structs for mapped IRQs, so we read in
-	 * the respective config data from memory here upon mapping the LPI.
-	 */
-	update_lpi_config(kvm, ite->irq, NULL);
-
 	return 0;
 }
 
-- 
2.5.5
