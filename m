From: kpark3469@gmail.com (kpark3469 at gmail.com)
Date: Wed, 30 Jan 2013 10:20:49 +0900
Subject: [PATCH v2] arm: fix returning wrong CALLER_ADDRx
Message-ID: <1359508849-2831-1-git-send-email-kpark3469@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sahara <keun-o.park@windriver.com>

This makes return_address return correct value for ftrace feature.
unwind_frame does not update frame->lr but frame->pc for backtrace.
And, the initialization for data.addr was missing so that wrong value
returned when unwind_frame failed.

Signed-off-by: Sahara <keun-o.park@windriver.com>
Reviewed-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/return_address.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 8085417..fafedd8 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -26,7 +26,7 @@ static int save_return_addr(struct stackframe *frame, void *d)
 	struct return_address_data *data = d;
 
 	if (!data->level) {
-		data->addr = (void *)frame->lr;
+		data->addr = (void *)frame->pc;
 
 		return 1;
 	} else {
@@ -41,7 +41,8 @@ void *return_address(unsigned int level)
 	struct stackframe frame;
 	register unsigned long current_sp asm ("sp");
 
-	data.level = level + 1;
+	data.level = level + 2;
+	data.addr = NULL;
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.sp = current_sp;
-- 
1.7.1
