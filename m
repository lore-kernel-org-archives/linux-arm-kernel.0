From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue, 26 Aug 2014 21:29:34 -0700
Subject: [PATCH V2 6/6] arm64: LLVMLinux: Use global stack pointer in
 return_address()
In-Reply-To: <1409113774-3172-1-git-send-email-behanw@converseincode.com>
References: <20140826141608.GT23445@arm.com>
 <1409113774-3172-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409113774-3172-7-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The global register current_stack_pointer holds the current stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Author: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm64/kernel/return_address.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 89102a6..6c4fd28 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -36,13 +36,12 @@ void *return_address(unsigned int level)
 {
 	struct return_address_data data;
 	struct stackframe frame;
-	register unsigned long current_sp asm ("sp");
 
 	data.level = level + 2;
 	data.addr = NULL;
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
-	frame.sp = current_sp;
+	frame.sp = current_stack_pointer;
 	frame.pc = (unsigned long)return_address; /* dummy */
 
 	walk_stackframe(&frame, save_return_addr, &data);
-- 
1.9.1
