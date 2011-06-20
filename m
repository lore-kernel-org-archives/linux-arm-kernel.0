From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:40:28 +0100
Subject: [PATCH 3/4] ARM: zImage: Jump to the decompressed kernel entry point
	in ARM state
In-Reply-To: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
References: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308577229-23681-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is required in order to enter the kernel correctly
now that the main kernel entry point expects to be called in
ARM state.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/boot/compressed/head.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index f9da419..51af709 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -353,7 +353,8 @@ not_relocated:	mov	r0, #0
 		mov	r0, #0			@ must be zero
 		mov	r1, r7			@ restore architecture number
 		mov	r2, r8			@ restore atags pointer
-		mov	pc, r4			@ call kernel
+ ARM(		mov	pc, r4	)		@ call kernel
+ THUMB(		bx	r4	)		@ entry point is always ARM
 
 		.align	2
 		.type	LC0, #object
-- 
1.7.4.1
