From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Jul 2016 16:54:08 +0100
Subject: [PATCH 06/13] KVM: arm64: vgic-its: Fix misleading nr_entries in
 vgic_its_check_device_id
In-Reply-To: <1468857255-9543-1-git-send-email-marc.zyngier@arm.com>
References: <1468857255-9543-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1468857255-9543-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nr_entries variable in vgic_its_check_device_id actually
describe the size of the L1 table, and not the number of
entries in this table.

Rename it to l1_tbl_size, so that we can now change the code
with a better understanding of what is what.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 2ac5927..268a0c7 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -687,18 +687,18 @@ static bool vgic_its_check_device_id(struct kvm *kvm, struct vgic_its *its,
 				     int device_id)
 {
 	u64 r = its->baser_device_table;
-	int nr_entries = GITS_BASER_NR_PAGES(r) * SZ_64K;
+	int l1_tbl_size = GITS_BASER_NR_PAGES(r) * SZ_64K;
 	int index;
 	u64 indirect_ptr;
 	gfn_t gfn;
 
 
 	if (!(r & GITS_BASER_INDIRECT))
-		return device_id < (nr_entries / GITS_BASER_ENTRY_SIZE(r));
+		return device_id < (l1_tbl_size / GITS_BASER_ENTRY_SIZE(r));
 
 	/* calculate and check the index into the 1st level */
 	index = device_id / (SZ_64K / GITS_BASER_ENTRY_SIZE(r));
-	if (index >= (nr_entries / sizeof(u64)))
+	if (index >= (l1_tbl_size / sizeof(u64)))
 		return false;
 
 	/* Each 1st level entry is represented by a 64-bit value. */
-- 
2.1.4
