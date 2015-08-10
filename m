From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Mon, 10 Aug 2015 21:26:06 +0800
Subject: [PATCH v4 14/15] KVM: arm: implement lazy world switch for debug
 registers
In-Reply-To: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
References: <1439213167-8988-1-git-send-email-zhichao.huang@linaro.org>
Message-ID: <1439213167-8988-15-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid world-switching all the debug registers when neither the host
nor the guest has configured any [WB]points.

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
---
 arch/arm/kvm/interrupts_head.S | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index b9e7410..7ad0adf 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -332,6 +332,21 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	sub	r12, r2, r12		@ How many WPs to skip
 .endm
 
+/* If VCPU_DEBUG_FLAGS is not set, it means that neither the host
+ * nor the guest has configured any [WB]points.
+ *
+ * We avoid world-switching all the debug registers in that case.
+ *
+ * Assume vcpu pointer in vcpu reg
+ *
+ * clobbers r2
+ */
+.macro skip_debug_state target
+	ldr	r2, [vcpu, #VCPU_DEBUG_FLAGS]
+	cmp	r2, #0
+	beq	\target
+.endm
+
 /* Reads cp14 registers from hardware.
  * Writes cp14 registers in-order to the CP14 struct pointed to by r10
  *
@@ -340,12 +355,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * Clobbers r2-r12
  */
 .macro save_debug_state
+	skip_debug_state 9999f
+
 	read_hw_dbg_num
 	cp14_read_and_str r10, 4, cp14_DBGBVR0, r11
 	cp14_read_and_str r10, 5, cp14_DBGBCR0, r11
 	cp14_read_and_str r10, 6, cp14_DBGWVR0, r12
 	cp14_read_and_str r10, 7, cp14_DBGWCR0, r12
-
+9999:
 	/* DBGDSCR reg */
 	mrc	p14, 0, r2, c0, c1, 0
 	str	r2, [r10, #CP14_OFFSET(cp14_DBGDSCRext)]
@@ -359,12 +376,14 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * Clobbers r2-r12
  */
 .macro restore_debug_state
+	skip_debug_state 9999f
+
 	read_hw_dbg_num
 	cp14_ldr_and_write r10, 4, cp14_DBGBVR0, r11
 	cp14_ldr_and_write r10, 5, cp14_DBGBCR0, r11
 	cp14_ldr_and_write r10, 6, cp14_DBGWVR0, r12
 	cp14_ldr_and_write r10, 7, cp14_DBGWCR0, r12
-
+9999:
 	/* DBGDSCR reg */
 	ldr	r2, [r10, #CP14_OFFSET(cp14_DBGDSCRext)]
 	mcr	p14, 0, r2, c0, c2, 2
-- 
1.7.12.4
