From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Apr 2018 13:56:32 +0100
Subject: [PATCH] arm64: cmpwait: Clear event register before arming exclusive
 monitor
Message-ID: <1525092992-16819-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When waiting for a cacheline to change state in cmpwait, we may immediately
wake-up the first time around the outer loop if the event register was
already set (for example, because of the event stream).

Avoid these spurious wakeups by explicitly clearing the event register
before loading the cacheline and setting the exclusive monitor.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cmpxchg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 4f5fd2a36e6e..3b0938281541 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -204,7 +204,9 @@ static inline void __cmpwait_case_##name(volatile void *ptr,		\
 	unsigned long tmp;						\
 									\
 	asm volatile(							\
-	"	ldxr" #sz "\t%" #w "[tmp], %[v]\n"		\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sz "\t%" #w "[tmp], %[v]\n"			\
 	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
 	"	cbnz	%" #w "[tmp], 1f\n"				\
 	"	wfe\n"							\
-- 
2.1.4
