From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 10 Oct 2013 10:35:21 +0800
Subject: [PATCH 3/3] arm64: include: asm: atomic.h: use 'unsigned int' and
 'atomic_t' instead of 'unsigned long' for atomic_clear_mask()
In-Reply-To: <5256121A.9030504@asianux.com>
References: <52561137.3070608@asianux.com> <5256117A.4000009@asianux.com>
 <5256121A.9030504@asianux.com>
Message-ID: <52561269.60900@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current kernel wide source, for arm64, only s390 scsi drivers use
atomic_clear_mask(), now, s390 itself need use 'unsigned int' and
'atomic_t', so need match s390's atomic_clear_mask().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/atomic.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 8363644..58808fc 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -126,16 +126,17 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 	return oldval;
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *ptr)
 {
-	unsigned long tmp, tmp2;
+	unsigned int tmp;
+	unsigned long tmp2;
 
 	asm volatile("// atomic_clear_mask\n"
-"1:	ldxr	%0, %2\n"
-"	bic	%0, %0, %3\n"
-"	stxr	%w1, %0, %2\n"
+"1:	ldxr	%w0, %2\n"
+"	bic	%w0, %w0, %w3\n"
+"	stxr	%w1, %w0, %2\n"
 "	cbnz	%w1, 1b"
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (*addr)
+	: "=&r" (tmp), "=&r" (tmp2), "+Q" (ptr->counter)
 	: "Ir" (mask)
 	: "cc");
 }
-- 
1.7.7.6
