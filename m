From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Mar 2017 12:05:28 +0100
Subject: [PATCH 3/5] KVM: arm64: vgic: Rename vgic_v3_cpu to vgic_cpu
In-Reply-To: <20170321110530.15857-1-cdall@linaro.org>
References: <20170321110530.15857-1-cdall@linaro.org>
Message-ID: <20170321110530.15857-4-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a temporary variable that points to the vgic_cpu structure, and
not the GICv3 specific part, which is a bit misleading compared to the
convention in the rest of the code.

As we are about to mess with the logic of userspace access, let's rename
this.

No functional change.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/vgic-sys-reg-v3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index 48848db..33f111c 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -20,7 +20,7 @@
 
 static bool write_gic_ctlr(struct kvm_vcpu *vcpu, u32 val)
 {
-	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	u32 host_pri_bits, host_id_bits, host_seis, host_a3v, seis, a3v;
 	struct vgic_vmcr vmcr;
 
@@ -32,17 +32,17 @@ static bool write_gic_ctlr(struct kvm_vcpu *vcpu, u32 val)
 	 */
 	host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
 			 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
-	if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
+	if (host_pri_bits > vgic_cpu->num_pri_bits)
 		return false;
 
-	vgic_v3_cpu->num_pri_bits = host_pri_bits;
+	vgic_cpu->num_pri_bits = host_pri_bits;
 
 	host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
 			ICC_CTLR_EL1_ID_BITS_SHIFT;
-	if (host_id_bits > vgic_v3_cpu->num_id_bits)
+	if (host_id_bits > vgic_cpu->num_id_bits)
 		return false;
 
-	vgic_v3_cpu->num_id_bits = host_id_bits;
+	vgic_cpu->num_id_bits = host_id_bits;
 
 	host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
 		     ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
@@ -70,15 +70,15 @@ static bool write_gic_ctlr(struct kvm_vcpu *vcpu, u32 val)
 
 static u32 read_gic_ctlr(struct kvm_vcpu *vcpu)
 {
-	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	u32 val = 0;
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
 
-	val |= (vgic_v3_cpu->num_pri_bits - 1) <<
+	val |= (vgic_cpu->num_pri_bits - 1) <<
 		ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
+	val |= vgic_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
 	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
 		ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
 		ICC_CTLR_EL1_SEIS_SHIFT;
-- 
2.9.0
