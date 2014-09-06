From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 17:06:15 -0700
Subject: [PATCH v2 5/7] arm: LLVMLinux: Calculate current_thread_info from
 current_stack_pointer
In-Reply-To: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
References: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409961977-11762-6-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/include/asm/thread_info.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index bb43515..b9dc3dc 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -112,8 +112,8 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
-	register unsigned long sp asm ("sp");
-	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
+	return (struct thread_info *)
+		(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
 #define thread_saved_pc(tsk)	\
-- 
1.9.1
