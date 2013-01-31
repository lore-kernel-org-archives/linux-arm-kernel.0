From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 31 Jan 2013 16:36:27 +0100
Subject: [PATCH 2/2] ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n
In-Reply-To: <1359646587-1788-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1359646587-1788-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1359646587-1788-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Traditionally for !CPU_CP15 read_cpuid and read_cpuid_ext returned the
processor id independent of the parameter passed in. This is wrong of
course but theoretically this doesn't harm because it's only called on
machines having a cp15.

Instead return 0 unconditionally which might make unused code paths be
better optimizable and so smaller and warn about unexpected usage.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/cputype.h |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index a59dcb5..574269e 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -50,6 +50,7 @@ extern unsigned int processor_id;
 		    : "cc");						\
 		__val;							\
 	})
+
 #define read_cpuid_ext(ext_reg)						\
 	({								\
 		unsigned int __val;					\
@@ -59,12 +60,25 @@ extern unsigned int processor_id;
 		    : "cc");						\
 		__val;							\
 	})
-#else
-#define read_cpuid(reg) (processor_id)
-#define read_cpuid_ext(reg) 0
-#endif
+
+#else /* ifdef CONFIG_CPU_CP15 */
 
 /*
+ * read_cpuid and read_cpuid_ext should only ever be called on machines that
+ * have cp15 so warn on other usages.
+ */
+#define read_cpuid(reg)							\
+	({								\
+		WARN_ON_ONCE(1);					\
+		0;							\
+	})
+
+#define read_cpuid_ext(reg) read_cpuid(reg)
+
+#endif /* ifdef CONFIG_CPU_CP15 / else */
+
+#ifdef CONFIG_CPU_CP15
+/*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
  * rather than directly reading processor_id or read_cpuid() directly.
@@ -74,6 +88,15 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(CPUID_ID);
 }
 
+#else /* ifdef CONFIG_CPU_CP15 */
+
+static inline unsigned int __attribute_const__ read_cpuid_id(void)
+{
+	return processor_id;
+}
+
+#endif /* ifdef CONFIG_CPU_CP15 / else */
+
 static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CPUID_CACHETYPE);
-- 
1.7.10.4
