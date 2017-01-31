From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 18:05:48 +0000
Subject: [RFC PATCH 10/13] arm64: kvm: Use common GICv3 sysreg definitions
In-Reply-To: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
References: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485885951-2747-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common definitions for the GICv3 register encodings,
make the KVM code use these, simplifying the sys_reg_descs table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 90befbe..332aa1b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -918,12 +918,8 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
 	  NULL, reset_val, VBAR_EL1, 0 },
 
-	/* ICC_SGI1R_EL1 */
-	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
-	  access_gic_sgi },
-	/* ICC_SRE_EL1 */
-	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1100), Op2(0b101),
-	  access_gic_sre },
+	{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
+	{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
 
 	/* CONTEXTIDR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
-- 
1.9.1
