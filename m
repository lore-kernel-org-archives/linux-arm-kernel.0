From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 11 May 2017 13:46:12 +0100
Subject: [PATCH v2 2/2] KVM: arm: rename pm_fake handler to trap_raz_wi
In-Reply-To: <20170511124612.11212-1-alex.bennee@linaro.org>
References: <20170511124612.11212-1-alex.bennee@linaro.org>
Message-ID: <20170511124612.11212-3-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhichao Huang <zhichao.huang@linaro.org>

pm_fake doesn't quite describe what the handler does (ignoring writes
and returning 0 for reads).

As we're about to use it (a lot) in a different context, rename it
with a (admitedly cryptic) name that make sense for all users.

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2:
  - fix minor merge conflicts
  - add maz a-b
---
 arch/arm/kvm/coproc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index c3ed6bd5ddf3..31bd9bb0b765 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -260,7 +260,7 @@ static bool access_gic_sre(struct kvm_vcpu *vcpu,
  * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
  * all PM registers, which doesn't crash the guest kernel at least.
  */
-static bool pm_fake(struct kvm_vcpu *vcpu,
+static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 		    const struct coproc_params *p,
 		    const struct coproc_reg *r)
 {
@@ -270,19 +270,19 @@ static bool pm_fake(struct kvm_vcpu *vcpu,
 		return read_zero(vcpu, p);
 }
 
-#define access_pmcr pm_fake
-#define access_pmcntenset pm_fake
-#define access_pmcntenclr pm_fake
-#define access_pmovsr pm_fake
-#define access_pmselr pm_fake
-#define access_pmceid0 pm_fake
-#define access_pmceid1 pm_fake
-#define access_pmccntr pm_fake
-#define access_pmxevtyper pm_fake
-#define access_pmxevcntr pm_fake
-#define access_pmuserenr pm_fake
-#define access_pmintenset pm_fake
-#define access_pmintenclr pm_fake
+#define access_pmcr trap_raz_wi
+#define access_pmcntenset trap_raz_wi
+#define access_pmcntenclr trap_raz_wi
+#define access_pmovsr trap_raz_wi
+#define access_pmselr trap_raz_wi
+#define access_pmceid0 trap_raz_wi
+#define access_pmceid1 trap_raz_wi
+#define access_pmccntr trap_raz_wi
+#define access_pmxevtyper trap_raz_wi
+#define access_pmxevcntr trap_raz_wi
+#define access_pmuserenr trap_raz_wi
+#define access_pmintenset trap_raz_wi
+#define access_pmintenclr trap_raz_wi
 
 /* Architected CP15 registers.
  * CRn denotes the primary register number, but is copied to the CRm in the
@@ -547,7 +547,7 @@ int kvm_handle_cp14_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	struct coproc_params params = decode_64bit_hsr(vcpu);
 
 	/* raz_wi cp14 */
-	pm_fake(vcpu, &params, NULL);
+	trap_raz_wi(vcpu, &params, NULL);
 
 	/* handled */
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
@@ -602,7 +602,7 @@ int kvm_handle_cp14_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	struct coproc_params params = decode_32bit_hsr(vcpu);
 
 	/* raz_wi cp14 */
-	pm_fake(vcpu, &params, NULL);
+	trap_raz_wi(vcpu, &params, NULL);
 
 	/* handled */
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-- 
2.11.0
