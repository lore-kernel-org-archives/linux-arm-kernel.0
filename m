From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:51:34 +0100
Subject: [PATCH 05/85] KVM: arm64: Enable the EL1 physical timer for AArch32
 guests
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>

Some 32bits guest OS can use the CNTP timer, however KVM does not
handle the accesses, injecting a fault instead.

Use the proper handlers to emulate the EL1 Physical Timer (CNTP)
register accesses of AArch32 guests.

Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 55982b565eb2..6feb4a2215cb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1565,6 +1565,11 @@ static const struct sys_reg_desc cp15_regs[] = {
 
 	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
 
+	/* CNTP_TVAL */
+	{ Op1( 0), CRn(14), CRm( 2), Op2( 0), access_cntp_tval },
+	/* CNTP_CTL */
+	{ Op1( 0), CRn(14), CRm( 2), Op2( 1), access_cntp_ctl },
+
 	/* PMEVCNTRn */
 	PMU_PMEVCNTR(0),
 	PMU_PMEVCNTR(1),
@@ -1638,6 +1643,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ Op1( 0), CRn( 0), CRm( 9), Op2( 0), access_pmu_evcntr },
 	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
 	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
+	{ Op1( 2), CRn( 0), CRm(14), Op2( 0), access_cntp_cval },
 };
 
 /* Target specific emulation tables */
-- 
2.14.2
