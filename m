From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 12:23:54 +0100
Subject: [PATCH] arm/arm64: KVM: Handle traps of ICC_SRE_EL1 as RAZ/WI
Message-ID: <1416396234-6887-1-git-send-email-ard.biesheuvel@linaro.org>
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
[ardb: added cp15 handling]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: add handling for 32-bit *guests* not 32-bit hosts
---
 arch/arm64/kvm/sys_regs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4cc3b719208e..3d7c2df89946 100644
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
@@ -690,6 +695,10 @@ static const struct sys_reg_desc cp15_regs[] = {
 	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 0), access_vm_reg, NULL, c10_AMAIR0 },
 	{ Op1( 0), CRn(10), CRm( 3), Op2( 1), access_vm_reg, NULL, c10_AMAIR1 },
+
+	/* ICC_SRE */
+	{ Op1( 0), CRn(12), CRm(12), Op2( 5), trap_raz_wi },
+
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
 };
 
-- 
1.8.3.2
