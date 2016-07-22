From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:29:06 +0100
Subject: [PATCH 49/55] KVM: arm64: vgic-its: Validate the device table L1 entry
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-50-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking that the device_id fits if the table, and we must make
sure that the associated memory is also accessible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 268a0c7..4943d6a 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -693,8 +693,17 @@ static bool vgic_its_check_device_id(struct kvm *kvm, struct vgic_its *its,
 	gfn_t gfn;
 
 
-	if (!(r & GITS_BASER_INDIRECT))
-		return device_id < (l1_tbl_size / GITS_BASER_ENTRY_SIZE(r));
+	if (!(r & GITS_BASER_INDIRECT)) {
+		phys_addr_t addr;
+
+		if (device_id >= (l1_tbl_size / GITS_BASER_ENTRY_SIZE(r)))
+			return false;
+
+		addr = BASER_ADDRESS(r) + device_id * GITS_BASER_ENTRY_SIZE(r);
+		gfn = addr >> PAGE_SHIFT;
+
+		return kvm_is_visible_gfn(kvm, gfn);
+	}
 
 	/* calculate and check the index into the 1st level */
 	index = device_id / (SZ_64K / GITS_BASER_ENTRY_SIZE(r));
-- 
2.8.1
