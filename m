From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 10 May 2017 18:01:59 +0100
Subject: [PATCH v1 2/2] KVM: arm: rename pm_fake handler to trap_raz_wi
In-Reply-To: <20170510170200.13285-1-alex.bennee@linaro.org>
References: <20170510170200.13285-1-alex.bennee@linaro.org>
Message-ID: <20170510170200.13285-3-alex.bennee@linaro.org>
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
Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm/kvm/coproc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index b2053393bb1f..6919363ce7cc 100644
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
@@ -527,7 +527,7 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		return emulate_cp15(vcpu, &params);
 
 	/* raz_wi cp14 */
-	(void)pm_fake(vcpu, &params, NULL);
+	(void)trap_raz_wi(vcpu, &params, NULL);
 
 	/* handled */
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
@@ -583,7 +583,7 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		return emulate_cp15(vcpu, &params);
 
 	/* raz_wi cp14 */
-	(void)pm_fake(vcpu, &params, NULL);
+	(void)trap_raz_wi(vcpu, &params, NULL);
 
 	/* handled */
 	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-- 
2.11.0
