From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  4 May 2017 13:44:40 +0200
Subject: [PATCH v6 20/24] KVM: arm64: vgic-its: vgic_its_check_id returns the
 entry's GPA
In-Reply-To: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
References: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1493898284-29504-21-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As vgic_its_check_id() computes the device/collection entry's
GPA, let's return it so that new callers can retrieve it easily.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Christoffer Dall <cdall@linaro.org>

---
v5 -> v6:
- add Christoffer's A-b

v3 -> v4:
- check eaddr is not NULL to allow passing NULL eaddr parameter
  to vgic_its_check_id

v2: new
---
 virt/kvm/arm/vgic/vgic-its.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 6bef9147..a3ed52a 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -668,7 +668,8 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
  * is actually valid (covered by a memslot and guest accessible).
  * For this we have to read the respective first level entry.
  */
-static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id)
+static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
+			      gpa_t *eaddr)
 {
 	int l1_tbl_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
 	u64 indirect_ptr, type = GITS_BASER_TYPE(baser);
@@ -699,6 +700,8 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id)
 		addr = BASER_ADDRESS(baser) + id * esz;
 		gfn = addr >> PAGE_SHIFT;
 
+		if (eaddr)
+			*eaddr = addr;
 		return kvm_is_visible_gfn(its->dev->kvm, gfn);
 	}
 
@@ -731,6 +734,8 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id)
 	indirect_ptr += index * esz;
 	gfn = indirect_ptr >> PAGE_SHIFT;
 
+	if (eaddr)
+		*eaddr = indirect_ptr;
 	return kvm_is_visible_gfn(its->dev->kvm, gfn);
 }
 
@@ -740,7 +745,7 @@ static int vgic_its_alloc_collection(struct vgic_its *its,
 {
 	struct its_collection *collection;
 
-	if (!vgic_its_check_id(its, its->baser_coll_table, coll_id))
+	if (!vgic_its_check_id(its, its->baser_coll_table, coll_id, NULL))
 		return E_ITS_MAPC_COLLECTION_OOR;
 
 	collection = kzalloc(sizeof(*collection), GFP_KERNEL);
@@ -913,7 +918,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	gpa_t itt_addr = its_cmd_get_ittaddr(its_cmd);
 	struct its_device *device;
 
-	if (!vgic_its_check_id(its, its->baser_device_table, device_id))
+	if (!vgic_its_check_id(its, its->baser_device_table, device_id, NULL))
 		return E_ITS_MAPD_DEVICE_OOR;
 
 	if (valid && num_eventid_bits > VITS_TYPER_IDBITS)
-- 
2.5.5
