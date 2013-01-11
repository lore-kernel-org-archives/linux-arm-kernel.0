From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:12 +0000
Subject: [PATCH 1/6] ARM: virt: Avoid bx instruction for compatibility with
 <=ARMv4
In-Reply-To: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1357918457-20469-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Non-T variants of ARMv4 do not support the bx instruction.

However, __hyp_stub_install is always called from the same
instruction set used to build the bulk of the kernel, so bx should
not be necessary.

This patch uses the traditional "mov pc" instead of bx.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dave Martin <dave.martin@linaro.org>
[will: fixed up remaining bx instruction]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 65b2417..3c60256 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -99,7 +99,7 @@ ENTRY(__hyp_stub_install_secondary)
 	 * immediately.
 	 */
 	compare_cpu_mode_with_primary	r4, r5, r6, r7
-	bxne	lr
+	movne	pc, lr
 
 	/*
 	 * Once we have given up on one CPU, we do not try to install the
@@ -111,7 +111,7 @@ ENTRY(__hyp_stub_install_secondary)
 	 */
 
 	cmp	r4, #HYP_MODE
-	bxne	lr			@ give up if the CPU is not in HYP mode
+	movne	pc, lr			@ give up if the CPU is not in HYP mode
 
 /*
  * Configure HSCTLR to set correct exception endianness/instruction set
@@ -200,7 +200,7 @@ ENDPROC(__hyp_get_vectors)
 	@ fall through
 ENTRY(__hyp_set_vectors)
 	__HVC(0)
-	bx	lr
+	mov	pc, lr
 ENDPROC(__hyp_set_vectors)
 
 #ifndef ZIMAGE
-- 
1.8.0
