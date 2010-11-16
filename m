From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:13:04 +0000
Subject: [PATCH] ARM: kuser: Fix incorrect cmpxchg syscall in kuser helpers
Message-ID: <1289913184-8621-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing code invokes the syscall with rubbish in r7,
due to what looks like an incorrect literal load idiom.

Apparently this code is rarely used, so this may not be a tip-top-priority fix.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-armv.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..bb96a7d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -911,7 +911,7 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	 * A special ghost syscall is used for that (see traps.c).
 	 */
 	stmfd	sp!, {r7, lr}
-	ldr	r7, =1f			@ it's 20 bits
+	ldr	r7, 1f			@ it's 20 bits
 	swi	__ARM_NR_cmpxchg
 	ldmfd	sp!, {r7, pc}
 1:	.word	__ARM_NR_cmpxchg
-- 
1.7.1
