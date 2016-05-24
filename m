From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 May 2016 11:09:33 +0200
Subject: [PULL 39/59] KVM: arm/arm64: vgic-new: Add GICv3 IROUTER register
 handlers
In-Reply-To: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
References: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1464080993-10884-40-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Since GICv3 supports much more than the 8 CPUs the GICv2 ITARGETSR
register can handle, the new IROUTER register covers the whole range
of possible target (V)CPUs by using the same MPIDR that the cores
report themselves.
In addition to translating this MPIDR into a vcpu pointer we store
the originally written value as well. The architecture allows to
write any values into the register, which must be read back as written.

Since we don't support affinity level 3, we don't need to take care
about the upper word of this 64-bit register, which simplifies the
handling a bit.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 22e512c..4dcef9e 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -75,6 +75,45 @@ static void vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
 	}
 }
 
+static unsigned long vgic_mmio_read_irouter(struct kvm_vcpu *vcpu,
+					    gpa_t addr, unsigned int len)
+{
+	int intid = VGIC_ADDR_TO_INTID(addr, 64);
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid);
+
+	if (!irq)
+		return 0;
+
+	/* The upper word is RAZ for us. */
+	if (addr & 4)
+		return 0;
+
+	return extract_bytes(READ_ONCE(irq->mpidr), addr & 7, len);
+}
+
+static void vgic_mmio_write_irouter(struct kvm_vcpu *vcpu,
+				    gpa_t addr, unsigned int len,
+				    unsigned long val)
+{
+	int intid = VGIC_ADDR_TO_INTID(addr, 64);
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, NULL, intid);
+
+	if (!irq)
+		return;
+
+	/* The upper word is WI for us since we don't implement Aff3. */
+	if (addr & 4)
+		return;
+
+	spin_lock(&irq->irq_lock);
+
+	/* We only care about and preserve Aff0, Aff1 and Aff2. */
+	irq->mpidr = val & GENMASK(23, 0);
+	irq->target_vcpu = kvm_mpidr_to_vcpu(vcpu->kvm, irq->mpidr);
+
+	spin_unlock(&irq->irq_lock);
+}
+
 static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 					      gpa_t addr, unsigned int len)
 {
@@ -170,7 +209,7 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 1,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IROUTER,
-		vgic_mmio_read_raz, vgic_mmio_write_wi, 64,
+		vgic_mmio_read_irouter, vgic_mmio_write_irouter, 64,
 		VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH(GICD_IDREGS,
 		vgic_mmio_read_v3_idregs, vgic_mmio_write_wi, 48,
-- 
2.1.2.330.g565301e.dirty
