From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Mon, 10 Aug 2015 21:25:59 +0800
Subject: [PATCH v4 07/15] KVM: arm: add trap handlers for 64-bit debug
 registers
In-Reply-To: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
References: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
Message-ID: <1439213167-8988-8-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add handlers for all the 64-bit debug registers.

There is an overlap between 32 and 64bit registers. Make sure that
64-bit registers preceding 32-bit ones.

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/coproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index b3627f0..2164f4e 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -440,6 +440,12 @@ static const struct coproc_reg cp15_regs[] = {
  * Trapped cp14 registers. We generally ignore most of the external
  * debug, on the principle that they don't really make sense to a
  * guest. Revisit this one day, should this principle change.
+ *
+ * CRn denotes the primary register number, but is copied to the CRm in the
+ * user space API for 64-bit register access in line with the terminology used
+ * in the ARM ARM.
+ * Important: Must be sorted ascending by CRn, CRM, Op1, Op2 and with 64-bit
+ *            registers preceding 32-bit ones.
  */
 static const struct coproc_reg cp14_regs[] = {
 	/* DBGIDR */
@@ -447,10 +453,14 @@ static const struct coproc_reg cp14_regs[] = {
 	/* DBGDTRRXext */
 	{ CRn( 0), CRm( 0), Op1( 0), Op2( 2), is32, trap_raz_wi },
 	DBG_BCR_BVR_WCR_WVR(0),
+	/* DBGDRAR (64bit) */
+	{ CRn( 0), CRm( 1), Op1( 0), Op2( 0), is64, trap_raz_wi },
 	/* DBGDSCRint */
 	{ CRn( 0), CRm( 1), Op1( 0), Op2( 0), is32, trap_dbgdscr,
 				NULL, cp14_DBGDSCRext },
 	DBG_BCR_BVR_WCR_WVR(1),
+	/* DBGDSAR (64bit) */
+	{ CRn( 0), CRm( 2), Op1( 0), Op2( 0), is64, trap_raz_wi },
 	/* DBGDSCRext */
 	{ CRn( 0), CRm( 2), Op1( 0), Op2( 2), is32, trap_debug32,
 				reset_val, cp14_DBGDSCRext, 0 },
-- 
1.7.12.4
