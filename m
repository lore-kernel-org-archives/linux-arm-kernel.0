From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Aug 2018 14:15:01 +0100
Subject: [PATCH 4/4] KVM: arm: vgic-v3: Add support for ICC_SGI0R and
 ICC_ASGI1R accesses
In-Reply-To: <20180808131501.584-1-marc.zyngier@arm.com>
References: <20180808131501.584-1-marc.zyngier@arm.com>
Message-ID: <20180808131501.584-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to generate Group0 SGIs, let's add some decoding logic to
access_gic_sgi(), and pass the generating group accordingly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index ec517992c12d..0dc0ca061d78 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -246,6 +246,7 @@ static bool access_gic_sgi(struct kvm_vcpu *vcpu,
 			   const struct coproc_reg *r)
 {
 	u64 reg;
+	int group;
 
 	if (!p->is_write)
 		return read_from_write_only(vcpu, p);
@@ -253,7 +254,25 @@ static bool access_gic_sgi(struct kvm_vcpu *vcpu,
 	reg = (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
 	reg |= *vcpu_reg(vcpu, p->Rt1) ;
 
-	vgic_v3_dispatch_sgi(vcpu, reg, 1);
+	/*
+	 * In a system where GICD_CTLR.DS=1, a ICC_SGI0R access generates
+	 * Group0 SGIs only, while ICC_SGI1R can generate either group,
+	 * depending on the SGI configuration. ICC_ASGI1R is effectively
+	 * equivalent to ICC_SGI0R, as there is no "alternative" secure
+	 * group.
+	 */
+	switch (p->Op1) {
+	default:		/* Keep GCC quiet */
+	case 0:			/* ICC_SGI1R */
+		group = 1;
+		break;
+	case 1:			/* ICC_ASGI1R */
+	case 2:			/* ICC_SGI0R */
+		group = 0;
+		break;
+	}
+
+	vgic_v3_dispatch_sgi(vcpu, reg, group);
 
 	return true;
 }
@@ -459,6 +478,10 @@ static const struct coproc_reg cp15_regs[] = {
 
 	/* ICC_SGI1R */
 	{ CRm64(12), Op1( 0), is64, access_gic_sgi},
+	/* ICC_ASGI1R */
+	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
+	/* ICC_SGI0R */
+	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
 
 	/* VBAR: swapped by interrupt.S. */
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
-- 
2.18.0
