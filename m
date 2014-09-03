From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:19:05 -0700
Subject: [PATCH 11/24] ARM64: Add is_ilp32_compat_task and
 is_ilp32_compat_thread
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-12-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the functions which returns if the current task is an
ILP32 task and one returns if the thread is an ILP32 thread.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/compat.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 8fcfb29..9082b27 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -332,5 +332,27 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ILP32
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT) && !is_a32_compat_task();
+}
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT) &&
+	       !is_a32_compat_thread(thread);
+}
+#else
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+#endif
+
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_COMPAT_H */
-- 
1.7.2.5
