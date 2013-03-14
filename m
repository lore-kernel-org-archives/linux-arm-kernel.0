From: kpark3469@gmail.com (kpark3469 at gmail.com)
Date: Thu, 14 Mar 2013 13:35:01 +0900
Subject: [PATCH v3] arm: fix a wrong value returned from CALLER_ADDRn
Message-ID: <1363235701-21342-1-git-send-email-kpark3469@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sahara <keun-o.park@windriver.com>

This makes return_address() return a correct value for CALLER_ADDRn.
To have a correct value from CALLER_ADDRn, we need to fix three points.

* The unwind_frame() does not update frame->lr but frame->pc for backtrace.
So frame->pc is meaningful for backtrace.

* data.level should be adjusted by adding 2 additional iteration levels.
With the current +1 level adjustment, the result of CALLER_ADDR1 will
be the same return address with CALLER_ADDR0.

* The initialization of data.addr to NULL is needed.
When unwind_fame() fails right after data.level reaches zero,
the routine returns data.addr which has uninitialized garbage value.

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
