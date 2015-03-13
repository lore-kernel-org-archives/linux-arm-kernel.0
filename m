From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Mar 2015 16:10:07 +0000
Subject: [PATCH 07/12] KVM: arm/arm64: simplify vgic_find_range() and callers
In-Reply-To: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1426263012-22935-8-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vgic_find_range() function in vgic.c takes a struct kvm_exit_mmio
argument, but actually only used the length field in there. Since we
need to get rid of that structure in that part of the code anyway,
let's rework the function (and it's callers) to pass the length
argument to the function directly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic-v2-emul.c |    2 +-
 virt/kvm/arm/vgic.c         |   22 ++++++++--------------
 virt/kvm/arm/vgic.h         |    3 +--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/virt/kvm/arm/vgic-v2-emul.c b/virt/kvm/arm/vgic-v2-emul.c
index 5002905..0defac6 100644
--- a/virt/kvm/arm/vgic-v2-emul.c
+++ b/virt/kvm/arm/vgic-v2-emul.c
@@ -699,7 +699,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 	default:
 		BUG();
 	}
-	r = vgic_find_range(ranges, &mmio, offset);
+	r = vgic_find_range(ranges, 4, offset);
 
 	if (unlikely(!r || !r->handle_mmio)) {
 		ret = -ENXIO;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index fe3ac08..7aae19b 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -650,16 +650,13 @@ void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 
 const
 struct vgic_io_range *vgic_find_range(const struct vgic_io_range *ranges,
-				      struct kvm_exit_mmio *mmio,
-				      phys_addr_t offset)
+				      int len, gpa_t offset)
 {
-	const struct vgic_io_range *r = ranges;
-
-	while (r->len) {
-		if (offset >= r->base &&
-		    (offset + mmio->len) <= (r->base + r->len))
-			return r;
-		r++;
+	while (ranges->len) {
+		if (offset >= ranges->base &&
+		    (offset + len) <= (ranges->base + ranges->len))
+			return ranges;
+		ranges++;
 	}
 
 	return NULL;
@@ -750,7 +747,7 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	unsigned long offset;
 
 	offset = mmio->phys_addr - mmio_base;
-	range = vgic_find_range(ranges, mmio, offset);
+	range = vgic_find_range(ranges, mmio->len, offset);
 	if (unlikely(!range || !range->handle_mmio)) {
 		pr_warn("Unhandled access %d %08llx %d\n",
 			mmio->is_write, mmio->phys_addr, mmio->len);
@@ -1839,10 +1836,7 @@ int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 int vgic_has_attr_regs(const struct vgic_io_range *ranges, phys_addr_t offset)
 {
-	struct kvm_exit_mmio dev_attr_mmio;
-
-	dev_attr_mmio.len = 4;
-	if (vgic_find_range(ranges, &dev_attr_mmio, offset))
+	if (vgic_find_range(ranges, 4, offset))
 		return 0;
 	else
 		return -ENXIO;
diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
index 21d062f..ffafb15 100644
--- a/virt/kvm/arm/vgic.h
+++ b/virt/kvm/arm/vgic.h
@@ -90,8 +90,7 @@ static inline bool is_in_range(phys_addr_t addr, unsigned long len,
 
 const
 struct vgic_io_range *vgic_find_range(const struct vgic_io_range *ranges,
-				      struct kvm_exit_mmio *mmio,
-				      phys_addr_t offset);
+				      int len, gpa_t offset);
 
 bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			    struct kvm_exit_mmio *mmio,
-- 
1.7.9.5
