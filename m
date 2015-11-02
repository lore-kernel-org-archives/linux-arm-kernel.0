From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:36 +0300
Subject: [PATCH v6 07/17] arm64:ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-8-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/compat.h      | 38 +++++++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/thread_info.h |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 9700e5e..95d2d72 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -324,9 +324,35 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ILP32
+
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
+}
+
+#else
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif
+
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #else /* !CONFIG_COMPAT */
@@ -341,6 +367,16 @@ static inline int is_a32_compat_task(void)
 	return 0;
 }
 
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* __KERNEL__ */
 #endif /* __ASM_COMPAT_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 7d03565..e72de74 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -112,6 +112,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* AARCH32 process */
 #define TIF_SWITCH_MM		23	/* deferred switch_mm */
+#define TIF_32BIT_AARCH64	24	/* 32 bit process on AArch64(ILP32) */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-- 
2.1.4
