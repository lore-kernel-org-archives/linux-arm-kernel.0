From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  1 Nov 2012 15:01:41 +0100
Subject: [PATCH] ARM: stacktrace: Fix return_address() for CONFIG_FRAME_POINTER
Message-ID: <1351778501-29924-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

return_address() currently relies on walk_stackframe() setting
frame->lr, but walk_stackframe() never sets this field.

Setting frame->lr from walk_stackframe() would require
walk_stackframe() to unwind one frame beyond the frame being
returned, and to track extra state in struct stackframe.

The value of this is debatable, so this patch modifies
caller_address() to unwind one extra level explicitly and reference
frame->pc instead of frame->lr.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/return_address.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 8085417..0854b54 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -26,7 +26,7 @@ static int save_return_addr(struct stackframe *frame, void *d)
 	struct return_address_data *data = d;
 
 	if (!data->level) {
-		data->addr = (void *)frame->lr;
+		data->addr = (void *)frame->pc;
 
 		return 1;
 	} else {
@@ -41,7 +41,7 @@ void *return_address(unsigned int level)
 	struct stackframe frame;
 	register unsigned long current_sp asm ("sp");
 
-	data.level = level + 1;
+	data.level = level + 2;
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.sp = current_sp;
-- 
1.7.5.4
