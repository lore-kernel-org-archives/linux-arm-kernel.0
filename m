From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue,  8 Jul 2014 13:16:13 -0700
Subject: [PATCH 3/6] arm: LLVMLinux: Use current_stack_pointer for
 return_address
In-Reply-To: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
Message-ID: <1404850576-2006-4-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and Clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M??ller <dl9pf@gmx.de>
---
 arch/arm/kernel/return_address.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index fafedd8..5bceaef 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -39,13 +39,12 @@ void *return_address(unsigned int level)
 {
 	struct return_address_data data;
 	struct stackframe frame;
-	register unsigned long current_sp asm ("sp");
 
 	data.level = level + 2;
 	data.addr = NULL;
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
-	frame.sp = current_sp;
+	frame.sp = current_stack_pointer;
 	frame.lr = (unsigned long)__builtin_return_address(0);
 	frame.pc = (unsigned long)return_address;
 
-- 
1.9.1
