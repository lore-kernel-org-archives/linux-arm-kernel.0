From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:31 +0100
Subject: [PATCH v3 16/19] KVM: arm64: ITS: vgic_its_check_id returns the
 entry's GPA
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-17-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As vgic_its_check_id() computes the device/collection entry's
GPA, let's return it so that new callers can retrieve it easily.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2: new
---
 virt/kvm/arm/vgic/vgic-its.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index ad67759..1060125 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -637,7 +637,8 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
  * is actually valid (covered by a memslot and guest accessible).
  * For this we have to read the respective first level entry.
  */
-static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
+static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id,
+			      gpa_t *eaddr)
 {
 	int l1_tbl_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
 	int index;
@@ -657,6 +658,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
 		addr = BASER_ADDRESS(baser) + id * esz;
 		gfn = addr >> PAGE_SHIFT;
 
+		*eaddr = addr;
 		return kvm_is_visible_gfn(its->dev->kvm, gfn);
 	}
 
@@ -689,6 +691,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, int id)
 	indirect_ptr += index * esz;
 	gfn = indirect_ptr >> PAGE_SHIFT;
 
+	*eaddr = indirect_ptr;
 	return kvm_is_visible_gfn(its->dev->kvm, gfn);
 }
 
@@ -697,8 +700,9 @@ static int vgic_its_alloc_collection(struct vgic_its *its,
 				     u32 coll_id)
 {
 	struct its_collection *collection;
+	gpa_t eaddr;
 
-	if (!vgic_its_check_id(its, its->baser_coll_table, coll_id))
+	if (!vgic_its_check_id(its, its->baser_coll_table, coll_id, &eaddr))
 		return E_ITS_MAPC_COLLECTION_OOR;
 
 	collection = kzalloc(sizeof(*collection), GFP_KERNEL);
@@ -910,8 +914,9 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	size_t size = its_cmd_get_size(its_cmd);
 	gpa_t itt_addr = its_cmd_get_ittaddr(its_cmd);
 	struct its_device *device;
+	gpa_t eaddr;
 
-	if (!vgic_its_check_id(its, its->baser_device_table, device_id))
+	if (!vgic_its_check_id(its, its->baser_device_table, device_id, &eaddr))
 		return E_ITS_MAPD_DEVICE_OOR;
 
 	if (valid && size > VITS_TYPER_IDBITS)
-- 
2.5.5
