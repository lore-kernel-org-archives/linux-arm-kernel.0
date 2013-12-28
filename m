From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Dec 2013 11:15:39 +0000
Subject: [PATCH 07/15] KVM: arm-vgic: Make vgic mmio functions more generic
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1388229347-24185-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Rename the vgic_ranges array to vgic_dist_ranges to be more specific and
to prepare for handling CPU interface register access as well (for
save/restore of VGIC state).

Pass offset from distributor or interface MMIO base to
find_matching_range function instead of the physical address of the
access in the VM memory map.  This allows other callers unaware of the
VM specifics, but with generic VGIC knowledge to reuse the function.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 45db48d..e2596f6 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -602,7 +602,7 @@ struct mmio_range {
 			    phys_addr_t offset);
 };
 
-static const struct mmio_range vgic_ranges[] = {
+static const struct mmio_range vgic_dist_ranges[] = {
 	{
 		.base		= GIC_DIST_CTRL,
 		.len		= 12,
@@ -669,14 +669,13 @@ static const struct mmio_range vgic_ranges[] = {
 static const
 struct mmio_range *find_matching_range(const struct mmio_range *ranges,
 				       struct kvm_exit_mmio *mmio,
-				       phys_addr_t base)
+				       phys_addr_t offset)
 {
 	const struct mmio_range *r = ranges;
-	phys_addr_t addr = mmio->phys_addr - base;
 
 	while (r->len) {
-		if (addr >= r->base &&
-		    (addr + mmio->len) <= (r->base + r->len))
+		if (offset >= r->base &&
+		    (offset + mmio->len) <= (r->base + r->len))
 			return r;
 		r++;
 	}
@@ -713,7 +712,8 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		return true;
 	}
 
-	range = find_matching_range(vgic_ranges, mmio, base);
+	offset = mmio->phys_addr - base;
+	range = find_matching_range(vgic_dist_ranges, mmio, offset);
 	if (unlikely(!range || !range->handle_mmio)) {
 		pr_warn("Unhandled access %d %08llx %d\n",
 			mmio->is_write, mmio->phys_addr, mmio->len);
-- 
1.8.5.1
