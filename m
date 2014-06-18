From: ccross@android.com (Colin Cross)
Date: Wed, 18 Jun 2014 13:10:09 -0700
Subject: [PATCH] ARM64: implement TASK_SIZE_OF
Message-ID: <1403122209-26352-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/sched.h implements TASK_SIZE_OF as TASK_SIZE if it
is not set by the architecture headers.  TASK_SIZE uses the
current task to determine the size of the virtual address space.
On a 64-bit kernel this will cause reading /proc/pid/pagemap of a
64-bit process from a 32-bit process to return EOF when it reads
past 0xffffffff.

Implement TASK_SIZE_OF exactly the same as TASK_SIZE with
test_tsk_thread_flag instead of test_thread_flag.

Cc: stable at vger.kernel.org
Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm64/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 993bce527b85..902eb708804a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -56,6 +56,8 @@
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
+#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+				TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
 #endif /* CONFIG_COMPAT */
-- 
2.0.0.526.g5318336
