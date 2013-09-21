From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 21 Sep 2013 19:06:47 +0800
Subject: [PATCH] ARM: include: asm: atomic.h: use type cast 's64' for the
 return value of atomic64_add_return().
Message-ID: <523D7DC7.8030603@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value of atomic64_add_return() is u64 which never less than
zero, so need type cast 's64' for comparing in atomic64_add_negative().

The related error: (allmodconfig for S5PV210, with "EXTRA_CFLAGS=-W"):

  kernel/events/core.c:5404:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index da1c77d..8cf005d 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -475,7 +475,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
 	return ret;
 }
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
+#define atomic64_add_negative(a, v)	((s64)atomic64_add_return((a), (v)) < 0)
 #define atomic64_inc(v)			atomic64_add(1LL, (v))
 #define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
 #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
-- 
1.7.7.6
