From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:47:40 -0400
Subject: [PATCH] arm: LLVMLinux: Calculate current_thread_info from fp
In-Reply-To: <1378504062-9117-1-git-send-email-behanw@converseincode.com>
References: <1378504062-9117-1-git-send-email-behanw@converseincode.com>
Message-ID: <1378504062-9117-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the frame pointer to calculate the start of the stack for current_thread_info()
The existing code uses the stack pointer to do this calculation.
Using the frame pointer yeilds the same value in a portable way.
This change supports being able to compile the kernel with gcc and Clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/include/asm/thread_info.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index df5e13d..cb50933 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -106,8 +106,9 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
 
 static inline struct thread_info *current_thread_info(void)
 {
-	register unsigned long sp asm ("sp");
-	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
+	return (struct thread_info *)
+		((u32)(__builtin_frame_address(0))
+		& ~(THREAD_SIZE - 1));
 }
 
 #define thread_saved_pc(tsk)	\
-- 
1.8.1.2
