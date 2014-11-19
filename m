From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 12:02:29 +0100
Subject: [PATCH] arm/arm64: KVM: Handle traps of ICC_SRE_EL1 as RAZ/WI
Message-ID: <1416394949-23496-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When running on a system with a GICv3, we currenly don't allow the guest
to access the system register interface of the GICv3.  We do this by
clearing the ICC_SRE_EL2.Enable, which causes all guest accesses to
ICC_SRE_EL1 to trap to EL2 and causes all guest accesses to other ICC_
registers to cause an undefined exception in the guest.

However, we currently don't handle the trap of guest accesses to
ICC_SRE_EL1 and will spill out a warning.  The trap just needs to handle
the access as RAZ/WI, and a guest that tries to prod this register and
set ICC_SRE_EL1.SRE=1, must read back the value (which Linux already
does) to see if it succeeded, and will thus observe that ICC_SRE_EL1.SRE
was not set.

Add the simple trap handler in the sorted table of the system registers.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
[ardb: added 32-bit counterpart]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
--
v2: added 32-bit counterpart, renaming pm_fake to trap_raz_wi in the process,
    hence the additional changes on that side
---
 arch/arm/kvm/coproc.c     | 49 +++++++++++++++++++++++++----------------------
 arch/arm64/kvm/sys_regs.c |  5 +++++
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 7928dbdf2102..a7cf90dd51ff 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -268,6 +268,16 @@ bool access_sctlr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool trap_raz_wi(struct kvm_vcpu *vcpu,
+			const struct coproc_params *p,
+			const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+	else
+		return read_zero(vcpu, p);
+}
+
 /*
  * We could trap ID_DFR0 and tell the guest we don't support performance
  * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
@@ -277,29 +287,19 @@ bool access_sctlr(struct kvm_vcpu *vcpu,
  * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
  * all PM registers, which doesn't crash the guest kernel at least.
  */
-static bool pm_fake(struct kvm_vcpu *vcpu,
-		    const struct coproc_params *p,
-		    const struct coproc_reg *r)
-{
-	if (p->is_write)
-		return ignore_write(vcpu, p);
-	else
-		return read_zero(vcpu, p);
-}
-
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
+#define access_pmcr		trap_raz_wi
+#define access_pmcntenset	trap_raz_wi
+#define access_pmcntenclr	trap_raz_wi
+#define access_pmovsr		trap_raz_wi
+#define access_pmselr		trap_raz_wi
+#define access_pmceid0		trap_raz_wi
+#define access_pmceid1		trap_raz_wi
+#define access_pmccntr		trap_raz_wi
+#define access_pmxevtyper	trap_raz_wi
+#define access_pmxevcntr	trap_raz_wi
+#define access_pmuserenr	trap_raz_wi
+#define access_pmintenset	trap_raz_wi
+#define access_pmintenclr	trap_raz_wi
 
 /* Architected CP15 registers.
  * CRn denotes the primary register number, but is copied to the CRm in the
@@ -405,6 +405,9 @@ static const struct coproc_reg cp15_regs[] = {
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c12_VBAR, 0x00000000 },
 
+	/* ICC_SRE */
+	{ CRn(12), CRm(12), Op1( 0), Op2( 5), is32, trap_raz_wi },
+
 	/* CONTEXTIDR/TPIDRURW/TPIDRURO/TPIDRPRW: swapped by interrupt.S. */
 	{ CRn(13), CRm( 0), Op1( 0), Op2( 1), is32,
 			access_vm_reg, reset_val, c13_CID, 0x00000000 },
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4cc3b719208e..8f81945c4365 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -424,6 +424,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	/* VBAR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
 	  NULL, reset_val, VBAR_EL1, 0 },
+
+	/* ICC_SRE_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1100), Op2(0b101),
+	  trap_raz_wi },
+
 	/* CONTEXTIDR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
 	  access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
-- 
1.8.3.2
