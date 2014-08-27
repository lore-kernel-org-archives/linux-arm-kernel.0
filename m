From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue, 26 Aug 2014 21:29:31 -0700
Subject: [PATCH V2 3/6] arm64: LLVMLinux: Calculate current_thread_info from
 current_stack_pointer
In-Reply-To: <1409113774-3172-1-git-send-email-behanw@converseincode.com>
References: <20140826141608.GT23445@arm.com>
 <1409113774-3172-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409113774-3172-4-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to get the value of the stack pointer.
This change supports being able to compile the kernel with both gcc and clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
Reviewed-by: Olof Johansson <olof@lixom.net>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 356e037..459bf8e 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -80,8 +80,8 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
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
