From: j.fanguede@virtualopensystems.com (=?UTF-8?q?J=C3=A9r=C3=A9my=20Fangu=C3=A8de?=)
Date: Thu,  8 Feb 2018 12:57:19 +0100
Subject: [PATCH] KVM: arm64: Enable the EL1 physical timer for AArch32 guests
Message-ID: <1518091039-17356-1-git-send-email-j.fanguede@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some 32bits guest OS can use the CNTP timer, however KVM does not
handle the accesses, injecting a fault instead.

Use the proper handlers to emulate the EL1 Physical Timer (CNTP)
register accesses of AArch32 guests.

Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
---
 arch/arm64/kvm/sys_regs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 50a43c7..c0ab4f7 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1545,6 +1545,11 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
 
+	/* CNTP_TVAL */
+	{ Op1( 0), CRn(14), CRm( 2), Op2( 0), access_cntp_tval },
+	/* CNTP_CTL */
+	{ Op1( 0), CRn(14), CRm( 2), Op2( 1), access_cntp_ctl },
+
 	/* PMEVCNTRn */
 	PMU_PMEVCNTR(0),
 	PMU_PMEVCNTR(1),
@@ -1618,6 +1623,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ Op1( 0), CRn( 0), CRm( 9), Op2( 0), access_pmu_evcntr },
 	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
 	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
+	{ Op1( 2), CRn( 0), CRm(14), Op2( 0), access_cntp_cval },
 };
 
 /* Target specific emulation tables */
-- 
2.7.4
