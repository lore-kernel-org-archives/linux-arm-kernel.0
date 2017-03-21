From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Mar 2017 12:05:27 +0100
Subject: [PATCH 2/5] KVM: arm64: vgic: Factor out access_gic_ctlr into
 separate r/w functions
In-Reply-To: <20170321110530.15857-1-cdall@linaro.org>
References: <20170321110530.15857-1-cdall@linaro.org>
Message-ID: <20170321110530.15857-3-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have one large function to deal with accesses to the
virtual ICC_CTLR_EL1 from userspace.  But the read and write paths don't
share much logic, and as we're about to mess with this implementaiton,
factor the two paths out into separate functions.

No functional change.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/vgic-sys-reg-v3.c | 134 ++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index 79f37e3..48848db 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -18,80 +18,96 @@
 #include "vgic.h"
 #include "sys_regs.h"
 
-static bool access_gic_ctlr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static bool write_gic_ctlr(struct kvm_vcpu *vcpu, u32 val)
 {
-	u32 host_pri_bits, host_id_bits, host_seis, host_a3v, seis, a3v;
 	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
+	u32 host_pri_bits, host_id_bits, host_seis, host_a3v, seis, a3v;
 	struct vgic_vmcr vmcr;
-	u64 val;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		val = p->regval;
-
-		/*
-		 * Disallow restoring VM state if not supported by this
-		 * hardware.
-		 */
-		host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
-				 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
-		if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
-			return false;
 
-		vgic_v3_cpu->num_pri_bits = host_pri_bits;
+	/*
+	 * Disallow restoring VM state if not supported by this
+	 * hardware.
+	 */
+	host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
+			 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
+	if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
+		return false;
 
-		host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
-				ICC_CTLR_EL1_ID_BITS_SHIFT;
-		if (host_id_bits > vgic_v3_cpu->num_id_bits)
-			return false;
+	vgic_v3_cpu->num_pri_bits = host_pri_bits;
 
-		vgic_v3_cpu->num_id_bits = host_id_bits;
+	host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
+			ICC_CTLR_EL1_ID_BITS_SHIFT;
+	if (host_id_bits > vgic_v3_cpu->num_id_bits)
+		return false;
 
-		host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
-			     ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
-		seis = (val & ICC_CTLR_EL1_SEIS_MASK) >>
-			ICC_CTLR_EL1_SEIS_SHIFT;
-		if (host_seis != seis)
-			return false;
+	vgic_v3_cpu->num_id_bits = host_id_bits;
 
-		host_a3v = ((kvm_vgic_global_state.ich_vtr_el2 &
-			    ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT);
-		a3v = (val & ICC_CTLR_EL1_A3V_MASK) >> ICC_CTLR_EL1_A3V_SHIFT;
-		if (host_a3v != a3v)
-			return false;
+	host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
+		     ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
+	seis = (val & ICC_CTLR_EL1_SEIS_MASK) >>
+		ICC_CTLR_EL1_SEIS_SHIFT;
+	if (host_seis != seis)
+		return false;
 
-		/*
-		 * Here set VMCR.CTLR in ICC_CTLR_EL1 layout.
-		 * The vgic_set_vmcr() will convert to ICH_VMCR layout.
-		 */
-		vmcr.ctlr = val & ICC_CTLR_EL1_CBPR_MASK;
-		vmcr.ctlr |= val & ICC_CTLR_EL1_EOImode_MASK;
-		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		val = 0;
-		val |= (vgic_v3_cpu->num_pri_bits - 1) <<
-			ICC_CTLR_EL1_PRI_BITS_SHIFT;
-		val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
-		val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-			ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
-			ICC_CTLR_EL1_SEIS_SHIFT;
-		val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-			ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT) <<
-			ICC_CTLR_EL1_A3V_SHIFT;
-		/*
-		 * The VMCR.CTLR value is in ICC_CTLR_EL1 layout.
-		 * Extract it directly using ICC_CTLR_EL1 reg definitions.
-		 */
-		val |= vmcr.ctlr & ICC_CTLR_EL1_CBPR_MASK;
-		val |= vmcr.ctlr & ICC_CTLR_EL1_EOImode_MASK;
-
-		p->regval = val;
-	}
+	host_a3v = ((kvm_vgic_global_state.ich_vtr_el2 &
+		    ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT);
+	a3v = (val & ICC_CTLR_EL1_A3V_MASK) >> ICC_CTLR_EL1_A3V_SHIFT;
+	if (host_a3v != a3v)
+		return false;
 
+	/*
+	 * Here set VMCR.CTLR in ICC_CTLR_EL1 layout.
+	 * The vgic_set_vmcr() will convert to ICH_VMCR layout.
+	 */
+	vmcr.ctlr = val & ICC_CTLR_EL1_CBPR_MASK;
+	vmcr.ctlr |= val & ICC_CTLR_EL1_EOImode_MASK;
+
+	vgic_set_vmcr(vcpu, &vmcr);
 	return true;
 }
 
+static u32 read_gic_ctlr(struct kvm_vcpu *vcpu)
+{
+	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
+	u32 val = 0;
+	struct vgic_vmcr vmcr;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+
+	val |= (vgic_v3_cpu->num_pri_bits - 1) <<
+		ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
+	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
+		ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
+		ICC_CTLR_EL1_SEIS_SHIFT;
+	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
+		ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT) <<
+		ICC_CTLR_EL1_A3V_SHIFT;
+	/*
+	 * The VMCR.CTLR value is in ICC_CTLR_EL1 layout.
+	 * Extract it directly using ICC_CTLR_EL1 reg definitions.
+	 */
+	val |= vmcr.ctlr & ICC_CTLR_EL1_CBPR_MASK;
+	val |= vmcr.ctlr & ICC_CTLR_EL1_EOImode_MASK;
+
+	return val;
+}
+
+static bool access_gic_ctlr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			    const struct sys_reg_desc *r)
+{
+	bool ret = true;
+
+	if (p->is_write)
+		ret = write_gic_ctlr(vcpu, p->regval);
+	else
+		p->regval = read_gic_ctlr(vcpu);
+
+	return ret;
+}
+
 static bool access_gic_pmr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-- 
2.9.0
