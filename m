From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 12:00:10 +0100
Subject: [PATCH 1/3] arm64: barrier: Implement smp_cond_load_relaxed
In-Reply-To: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
References: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
Message-ID: <1530010812-17161-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can provide an implementation of smp_cond_load_relaxed using READ_ONCE
and __cmpwait_relaxed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f11518af96a9..822a9192c551 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -128,6 +128,19 @@ do {									\
 	__u.__val;							\
 })
 
+#define smp_cond_load_relaxed(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	typeof(*ptr) VAL;						\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+	}								\
+	VAL;								\
+})
+
 #define smp_cond_load_acquire(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
-- 
2.1.4
