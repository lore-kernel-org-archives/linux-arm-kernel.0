From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:34 +0300
Subject: [PATCH v6 08/20] arm64: ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-9-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
---
 arch/arm64/include/asm/is_compat.h   | 30 +++++++++++++++++++++++++++---
 arch/arm64/include/asm/thread_info.h |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
index 476db90..89b1f65 100644
--- a/arch/arm64/include/asm/is_compat.h
+++ b/arch/arm64/include/asm/is_compat.h
@@ -36,7 +36,6 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 #else
 
 static inline int is_a32_compat_task(void)
-
 {
 	return 0;
 }
@@ -45,14 +44,39 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 {
 	return 0;
 }
-
 #endif /* CONFIG_AARCH32_EL0 */
 
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
+#endif /* CONFIG_ARM64_ILP32 */
+
 #ifdef CONFIG_COMPAT
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #endif /* CONFIG_COMPAT */
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
2.5.0
