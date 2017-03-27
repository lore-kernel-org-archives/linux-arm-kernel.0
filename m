From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:31:08 +0200
Subject: [PATCH v4 18/22] KVM: arm64: ITS: Collection table save/restore
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-19-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flush path copies the collection entries into guest RAM
at the GPA specified in the BASER register. This obviously
requires the BASER to be set. The last written element
is a dummy collection table entry.

We do not index by collection ID as the collection entry
can fit into 8 bytes while containing the collection ID.

On restore path we re-allocate the collection objects.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- replaced u64 *ptr by gpa_t gpa
- check the collection does not exist before allocating it

v1 -> v2:
- reword commit message and directly use 8 as entry size
- no kvm parameter anymore
- add helper for flush/restore cte
- table size computed here
- add le64/cpu conversions
---
 virt/kvm/arm/vgic/vgic-its.c | 99 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 8eaeba4..df984b6 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1828,13 +1828,89 @@ static int vgic_its_restore_device_tables(struct vgic_its *its)
 	return -ENXIO;
 }
 
+static int vgic_its_flush_cte(struct vgic_its *its,
+			      struct its_collection *collection, gpa_t gpa)
+{
+	u64 val;
+	int ret;
+
+	val = ((u64)1 << 63 | ((u64)collection->target_addr << 16) |
+	       collection->collection_id);
+	val = cpu_to_le64(val);
+	ret = kvm_write_guest(its->dev->kvm, gpa, &val, 8);
+	return ret;
+}
+
+static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, bool *valid)
+{
+	struct its_collection *collection;
+	u32 target_addr;
+	u32 coll_id;
+	u64 val;
+	int ret;
+
+	*valid = false;
+
+	ret = kvm_read_guest(its->dev->kvm, gpa, &val, 8);
+	if (ret)
+		return ret;
+	val = le64_to_cpu(val);
+	*valid = val & BIT_ULL(63);
+
+	if (!*valid)
+		return 0;
+
+	target_addr = (u32)(val >> 16);
+	coll_id = val & 0xFFFF;
+
+	collection = find_collection(its, coll_id);
+	if (collection)
+		return -EEXIST;
+	ret = vgic_its_alloc_collection(its, &collection, coll_id);
+	if (ret)
+		return ret;
+	collection->target_addr = target_addr;
+	return 0;
+}
+
 /**
  * vgic_its_flush_collection_table - flush the collection table into
  * guest RAM
  */
 static int vgic_its_flush_collection_table(struct vgic_its *its)
 {
-	return -ENXIO;
+	struct its_collection *collection;
+	u64 val;
+	gpa_t gpa;
+	size_t max_size, filled = 0;
+	int ret;
+
+	gpa = BASER_ADDRESS(its->baser_coll_table);
+	if (!gpa)
+		return 0;
+
+	max_size = GITS_BASER_NR_PAGES(its->baser_coll_table) * SZ_64K;
+
+	list_for_each_entry(collection, &its->collection_list, coll_list) {
+		if (filled == max_size)
+			return -ENOSPC;
+		ret = vgic_its_flush_cte(its, collection, gpa);
+		if (ret)
+			return ret;
+		gpa += 8;
+		filled += 8;
+	}
+
+	if (filled == max_size)
+		return 0;
+
+	/*
+	 * table is not fully filled, add a last dummy element
+	 * with valid bit unset
+	 */
+	val = 0;
+	ret = kvm_write_guest(its->dev->kvm, gpa, &val, 8);
+	return ret;
 }
 
 /**
@@ -1844,7 +1920,26 @@ static int vgic_its_flush_collection_table(struct vgic_its *its)
  */
 static int vgic_its_restore_collection_table(struct vgic_its *its)
 {
-	return -ENXIO;
+	size_t max_size, read = 0;
+	gpa_t gpa;
+	int ret;
+
+	gpa = BASER_ADDRESS(its->baser_coll_table);
+	if (!gpa)
+		return 0;
+
+	max_size = GITS_BASER_NR_PAGES(its->baser_coll_table) * SZ_64K;
+
+	while (read < max_size) {
+		bool valid;
+
+		ret = vgic_its_restore_cte(its, gpa, &valid);
+		if (!valid || ret)
+			break;
+		gpa += 8;
+		read += 8;
+	}
+	return ret;
 }
 
 /**
-- 
2.5.5
