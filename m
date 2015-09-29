From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:08 +0300
Subject: [PATCH v5 11/23] arm64:ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-12-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 3a2976d..f53c4e6 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -319,6 +319,26 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 }
 #endif
 
+#ifdef CONFIG_ARM64_ILP32
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
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
 #else /* !CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
@@ -330,17 +350,25 @@ static inline int is_a32_compat_task(void)
 {
 	return 0;
 }
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
 
 #endif /* CONFIG_COMPAT */
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 static inline int is_compat_thread(struct thread_info *thread)
 {
-	return is_a32_compat_thread(thread);
+	return is_a32_compat_thread(thread) || is_ilp32_compat_thread(thread);
 }
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
