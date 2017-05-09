From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  9 May 2017 12:44:35 +0200
Subject: [PULL 06/37] arm/arm64: vgic: turn vgic_find_mmio_region into public
In-Reply-To: <20170509104506.30929-1-cdall@linaro.org>
References: <20170509104506.30929-1-cdall@linaro.org>
Message-ID: <20170509104506.30929-7-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

We plan to use vgic_find_mmio_region in vgic-its.c so let's
turn it into a public function.

Also let's take the opportunity to rename the region parameter
into regions to emphasize this latter is an array of regions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 11 +++++------
 virt/kvm/arm/vgic/vgic-mmio.h |  5 +++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 2a5db13..1c17b2a 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -446,13 +446,12 @@ static int match_region(const void *key, const void *elt)
 	return 0;
 }
 
-/* Find the proper register handler entry given a certain address offset. */
-static const struct vgic_register_region *
-vgic_find_mmio_region(const struct vgic_register_region *region, int nr_regions,
-		      unsigned int offset)
+const struct vgic_register_region *
+vgic_find_mmio_region(const struct vgic_register_region *regions,
+		      int nr_regions, unsigned int offset)
 {
-	return bsearch((void *)(uintptr_t)offset, region, nr_regions,
-		       sizeof(region[0]), match_region);
+	return bsearch((void *)(uintptr_t)offset, regions, nr_regions,
+		       sizeof(regions[0]), match_region);
 }
 
 void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 98bb566..6eec91b 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -192,4 +192,9 @@ u64 vgic_sanitise_shareability(u64 reg);
 u64 vgic_sanitise_field(u64 reg, u64 field_mask, int field_shift,
 			u64 (*sanitise_fn)(u64));
 
+/* Find the proper register handler entry given a certain address offset */
+const struct vgic_register_region *
+vgic_find_mmio_region(const struct vgic_register_region *regions,
+		      int nr_regions, unsigned int offset);
+
 #endif
-- 
2.9.0
