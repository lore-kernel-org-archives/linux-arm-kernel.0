From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:47 +0100
Subject: [GIT PULL 18/36] arm/arm64: KVM: wrap 64 bit MMIO accesses with two
 32 bit ones
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-19-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Some GICv3 registers can and will be accessed as 64 bit registers.
Currently the register handling code can only deal with 32 bit
accesses, so we do two consecutive calls to cover this.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b5aa821..a1fda79 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1033,6 +1033,53 @@ static bool vgic_validate_access(const struct vgic_dist *dist,
 	return true;
 }
 
+/*
+ * Call the respective handler function for the given range.
+ * We split up any 64 bit accesses into two consecutive 32 bit
+ * handler calls and merge the result afterwards.
+ * We do this in a little endian fashion regardless of the host's
+ * or guest's endianness, because the GIC is always LE and the rest of
+ * the code (vgic_reg_access) also puts it in a LE fashion already.
+ * At this point we have already identified the handle function, so
+ * range points to that one entry and offset is relative to this.
+ */
+static bool call_range_handler(struct kvm_vcpu *vcpu,
+			       struct kvm_exit_mmio *mmio,
+			       unsigned long offset,
+			       const struct mmio_range *range)
+{
+	u32 *data32 = (void *)mmio->data;
+	struct kvm_exit_mmio mmio32;
+	bool ret;
+
+	if (likely(mmio->len <= 4))
+		return range->handle_mmio(vcpu, mmio, offset);
+
+	/*
+	 * Any access bigger than 4 bytes (that we currently handle in KVM)
+	 * is actually 8 bytes long, caused by a 64-bit access
+	 */
+
+	mmio32.len = 4;
+	mmio32.is_write = mmio->is_write;
+
+	mmio32.phys_addr = mmio->phys_addr + 4;
+	if (mmio->is_write)
+		*(u32 *)mmio32.data = data32[1];
+	ret = range->handle_mmio(vcpu, &mmio32, offset + 4);
+	if (!mmio->is_write)
+		data32[1] = *(u32 *)mmio32.data;
+
+	mmio32.phys_addr = mmio->phys_addr;
+	if (mmio->is_write)
+		*(u32 *)mmio32.data = data32[0];
+	ret |= range->handle_mmio(vcpu, &mmio32, offset);
+	if (!mmio->is_write)
+		data32[0] = *(u32 *)mmio32.data;
+
+	return ret;
+}
+
 /**
  * vgic_handle_mmio_range - handle an in-kernel MMIO access
  * @vcpu:	pointer to the vcpu performing the access
@@ -1064,10 +1111,10 @@ static bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	spin_lock(&vcpu->kvm->arch.vgic.lock);
 	offset -= range->base;
 	if (vgic_validate_access(dist, range, offset)) {
-		updated_state = range->handle_mmio(vcpu, mmio, offset);
+		updated_state = call_range_handler(vcpu, mmio, offset, range);
 	} else {
-		vgic_reg_access(mmio, NULL, offset,
-				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
+		if (!mmio->is_write)
+			memset(mmio->data, 0, mmio->len);
 		updated_state = false;
 	}
 	spin_unlock(&vcpu->kvm->arch.vgic.lock);
-- 
2.1.2.330.g565301e.dirty
