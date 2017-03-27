From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:31:05 +0200
Subject: [PATCH v4 15/22] KVM: arm64: ITS: Sort the device and ITE lists
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-16-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Natively sort the device and ITE lists in ascending
deviceId/eventid order. This paves the way to optimized
DTE and ITE scan in guest RAM table where entries are chained
together using a next ID offset.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

---

v3 -> v4:
- added Andre's R-b
---
 virt/kvm/arm/vgic/vgic-its.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 2a1ccbf..7364b7d 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -726,6 +726,21 @@ static void vgic_its_free_collection(struct vgic_its *its, u32 coll_id)
 	kfree(collection);
 }
 
+static void ite_list_insert_sorted(struct list_head *h, struct its_ite *ite)
+{
+	struct list_head *pos = h->next;
+	u32 id = ite->event_id;
+
+	while (pos != h) {
+		struct its_ite *iter =
+			list_entry(pos, struct its_ite, ite_list);
+		if (id < iter->event_id)
+			break;
+		pos = pos->next;
+	}
+	list_add_tail(&ite->ite_list, pos);
+}
+
 /* Must be called with its_lock mutex held */
 static int vgic_its_alloc_ite(struct its_device *device,
 			       struct its_ite **itep,
@@ -742,7 +757,7 @@ static int vgic_its_alloc_ite(struct its_device *device,
 	ite->collection = collection;
 	ite->lpi = lpi_id;
 
-	list_add_tail(&ite->ite_list, &device->itt_head);
+	ite_list_insert_sorted(&device->itt_head, ite);
 	*itep = ite;
 	return 0;
 }
@@ -835,6 +850,22 @@ static void vgic_its_unmap_device(struct kvm *kvm, struct its_device *device)
 	kfree(device);
 }
 
+static void device_list_insert_sorted(struct list_head *h,
+				      struct its_device *dev)
+{
+	struct list_head *pos = h->next;
+	u32 id = dev->device_id;
+
+	while (pos != h) {
+		struct its_device *iter =
+			list_entry(pos, struct its_device, dev_list);
+		if (id < iter->device_id)
+			break;
+		pos = pos->next;
+	}
+	list_add_tail(&dev->dev_list, pos);
+}
+
 /* Must be called with its_lock mutex held */
 static int vgic_its_alloc_device(struct vgic_its *its,
 				 struct its_device **devp,
@@ -852,7 +883,8 @@ static int vgic_its_alloc_device(struct vgic_its *its,
 	device->nb_eventid_bits = nb_eventid_bits;
 	INIT_LIST_HEAD(&device->itt_head);
 
-	list_add_tail(&device->dev_list, &its->device_list);
+	device_list_insert_sorted(&its->device_list, device);
+
 	*devp = device;
 
 	return 0;
-- 
2.5.5
