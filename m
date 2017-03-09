From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Mar 2017 17:07:24 +0000
Subject: [PATCH 12/15] KVM: arm64: Use common physical timer sysreg definitions
In-Reply-To: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489079247-31092-13-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common definitions for the physical timer control
registers, make the KVM code use these, simplifying the sys_reg_descs
table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1f3062b..860707f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1016,15 +1016,9 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
 	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
 	  NULL, reset_unknown, TPIDRRO_EL0 },
 
-	/* CNTP_TVAL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b000),
-	  access_cntp_tval },
-	/* CNTP_CTL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b001),
-	  access_cntp_ctl },
-	/* CNTP_CVAL_EL0 */
-	{ Op0(0b11), Op1(0b011), CRn(0b1110), CRm(0b0010), Op2(0b010),
-	  access_cntp_cval },
+	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_cntp_tval },
+	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_cntp_ctl },
+	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_cntp_cval },
 
 	/* PMEVCNTRn_EL0 */
 	PMU_PMEVCNTR_EL0(0),
-- 
1.9.1
