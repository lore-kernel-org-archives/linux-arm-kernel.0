From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Sat, 16 May 2015 12:45:51 +0800
Subject: [PATCH 10/10] KVM: arm: enable trapping of all debug registers
In-Reply-To: <1431751551-4788-1-git-send-email-zhichao.huang@linaro.org>
References: <1431751551-4788-1-git-send-email-zhichao.huang@linaro.org>
Message-ID: <1431751551-4788-11-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable trapping of the debug registers, allowing guests to use
the debug infrastructure.

Signed-off-by: Zhichao Huang <zhichao.huang@linaro.org>
---
 arch/arm/kvm/interrupts_head.S | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index ed406be..107bda4 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -886,10 +886,21 @@ ARM_BE8(rev	r6, r6  )
 .endm
 
 /* Configures the HDCR (Hyp Debug Configuration Register) on entry/return
- * (hardware reset value is 0) */
+ * (hardware reset value is 0)
+ *
+ * Clobbers r2-r4
+ */
 .macro set_hdcr operation
 	mrc	p15, 4, r2, c1, c1, 1
-	ldr	r3, =(HDCR_TPM|HDCR_TPMCR)
+	ldr	r3, =(HDCR_TPM|HDCR_TPMCR|HDCR_TDRA|HDCR_TDOSA)
+
+	// Check for KVM_ARM_DEBUG_DIRTY, and set debug to trap
+	// if not dirty.
+	ldr	r4, [vcpu, #VCPU_DEBUG_FLAGS]
+	cmp	r4, #KVM_ARM_DEBUG_DIRTY
+	beq	1f
+	orr	r3, r3,  #HDCR_TDA
+1:
 	.if \operation == vmentry
 	orr	r2, r2, r3		@ Trap some perfmon accesses
 	.else
-- 
1.7.12.4
