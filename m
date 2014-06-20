From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jun 2014 14:00:03 +0100
Subject: [PATCH v3 5/9] arm64: KVM: use separate tables for AArch32 32 and
 64bit traps
In-Reply-To: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403269207-1625-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An interesting "feature" of the CP14 encoding is that there is
an overlap between 32 and 64bit registers, meaning they cannot
live in the same table as we did for CP15.

Create separate tables for 64bit CP14 and CP15 registers, and
let the top level handler use the right one.

Reviewed-by: Anup Patel <anup.patel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index fb6eece..1fb1bff 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -487,13 +487,16 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 static const struct sys_reg_desc cp14_regs[] = {
 };
 
+/* Trapped cp14 64bit registers */
+static const struct sys_reg_desc cp14_64_regs[] = {
+};
+
 /*
  * Trapped cp15 registers. TTBR0/TTBR1 get a double encoding,
  * depending on the way they are accessed (as a 32bit or a 64bit
  * register).
  */
 static const struct sys_reg_desc cp15_regs[] = {
-	{ Op1( 0), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
@@ -534,6 +537,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 1), access_vm_reg, NULL, c10_AMAIR1 },
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
 
+};
+
+static const struct sys_reg_desc cp15_64_regs[] = {
+	{ Op1( 0), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
 	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
 };
 
@@ -759,7 +766,7 @@ int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	target_specific = get_target_table(vcpu->arch.target, false, &num);
 	return kvm_handle_cp_64(vcpu,
-				cp15_regs, ARRAY_SIZE(cp15_regs),
+				cp15_64_regs, ARRAY_SIZE(cp15_64_regs),
 				target_specific, num);
 }
 
@@ -777,7 +784,7 @@ int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
 int kvm_handle_cp14_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	return kvm_handle_cp_64(vcpu,
-				cp14_regs, ARRAY_SIZE(cp14_regs),
+				cp14_64_regs, ARRAY_SIZE(cp14_64_regs),
 				NULL, 0);
 }
 
-- 
1.8.3.4
