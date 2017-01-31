From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 18:05:51 +0000
Subject: [RFC PATCH 13/13] arm64: kvm: Use common Set/Way sys definitions
In-Reply-To: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
References: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485885951-2747-14-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common definitions for the encoding of Set/Way cache
maintenance operations, make the KVM code use these, simplifying the
sys_reg_descs table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2b0b5fc..0d81bd4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -824,15 +824,9 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  * more demanding guest...
  */
 static const struct sys_reg_desc sys_reg_descs[] = {
-	/* DC ISW */
-	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b0110), Op2(0b010),
-	  access_dcsw },
-	/* DC CSW */
-	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1010), Op2(0b010),
-	  access_dcsw },
-	/* DC CISW */
-	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
-	  access_dcsw },
+	{ SYS_DESC(SYS_DC_ISW), access_dcsw },
+	{ SYS_DESC(SYS_DC_CSW), access_dcsw },
+	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
 
 	DBG_BCR_BVR_WCR_WVR_EL1(0),
 	DBG_BCR_BVR_WCR_WVR_EL1(1),
-- 
1.9.1
