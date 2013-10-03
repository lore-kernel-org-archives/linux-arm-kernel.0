From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 Oct 2013 19:17:33 +0100
Subject: [PATCH v2 2/3] ARM: cmpxchg: implement cmpxchg64_relaxed
In-Reply-To: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
References: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
Message-ID: <1380824254-22337-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces cmpxchg64_relaxed for arm, which performs a 64-bit
cmpxchg operation without barrier semantics. cmpxchg64_local is updated
to use the new operation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cmpxchg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index fbd978f..df2fbba 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -270,11 +270,13 @@ static inline unsigned long long __cmpxchg64_mb(unsigned long long *ptr,
 					(unsigned long long)(o),	\
 					(unsigned long long)(n)))
 
-#define cmpxchg64_local(ptr, o, n)					\
+#define cmpxchg64_relaxed(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64((ptr),				\
 					(unsigned long long)(o),	\
 					(unsigned long long)(n)))
 
+#define cmpxchg64_local(ptr, o, n)	cmpxchg64_relaxed((ptr), (o), (n))
+
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
 #endif /* __ASM_ARM_CMPXCHG_H */
-- 
1.8.2.2
