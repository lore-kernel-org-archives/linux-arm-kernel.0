From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:14 +0000
Subject: [PATCH 3/6] ARM: virt: simplify __hyp_stub_install epilog
In-Reply-To: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1357918457-20469-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

__hyp_stub_install duplicates quite a bit of safe_svcmode_maskall
by forcing the CPU back to SVC. This is unnecessary, as
safe_svcmode_maskall is called just after.

Furthermore, the way we build SPSR_hyp is buggy as we fail to mask
the interrupts, leading to interesting behaviours on TC2 + UEFI.

The fix is to simply remove this code and rely on safe_svcmode_maskall
to do the right thing.

Cc: <stable@vger.kernel.org>
Reviewed-by: Dave Martin <dave.martin@linaro.org>
Reported-by: Harry Liebel <harry.liebel@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 3c60256..1315c4c 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -120,7 +120,8 @@ ENTRY(__hyp_stub_install_secondary)
  * Eventually, CPU-specific code might be needed -- assume not for now
  *
  * This code relies on the "eret" instruction to synchronize the
- * various coprocessor accesses.
+ * various coprocessor accesses. This is done when we switch to SVC
+ * (see safe_svcmode_maskall).
  */
 	@ Now install the hypervisor stub:
 	adr	r7, __hyp_stub_vectors
@@ -155,14 +156,7 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
 1:
 #endif
 
-	bic	r7, r4, #MODE_MASK
-	orr	r7, r7, #SVC_MODE
-THUMB(	orr	r7, r7, #PSR_T_BIT	)
-	msr	spsr_cxsf, r7		@ This is SPSR_hyp.
-
-	__MSR_ELR_HYP(14)		@ msr elr_hyp, lr
-	__ERET				@ return, switching to SVC mode
-					@ The boot CPU mode is left in r4.
+	bx	lr			@ The boot CPU mode is left in r4.
 ENDPROC(__hyp_stub_install_secondary)
 
 __hyp_stub_do_trap:
-- 
1.8.0
