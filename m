From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:44:45 +0000
Subject: [PATCH 2/4] arm64: Avoid masking "old" for LSE cmpxchg()
 implementation
In-Reply-To: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543347887-21101-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CAS instructions implicitly access only the relevant bits of the "old"
argument, so there is no need for explicit masking via type-casting as
there is in the LL/SC implementation.

Move the casting into the LL/SC code and remove it altogether for the LSE
implementation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 8 ++++++++
 arch/arm64/include/asm/atomic_lse.h   | 4 ++--
 arch/arm64/include/asm/cmpxchg.h      | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f02d3bf7b9e6..b53f70dd6e10 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -257,6 +257,14 @@ __LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,		\
 	unsigned long tmp;						\
 	u##sz oldval;							\
 									\
+	/*								\
+	 * Sub-word sizes require explicit casting so that the compare  \
+	 * part of the cmpxchg doesn't end up interpreting non-zero	\
+	 * upper bits of the register containing "old".			\
+	 */								\
+	if (sz < 32)							\
+		old = (u##sz)old;					\
+									\
 	asm volatile(							\
 	"	prfm	pstl1strm, %[v]\n"				\
 	"1:	ld" #acq "xr" #sfx "\t%" #w "[oldval], %[v]\n"		\
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 4d6f917b654e..a424355240c5 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -448,11 +448,11 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 
 #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)			\
 static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,	\
-					      unsigned long old,	\
+					      u##sz old,		\
 					      u##sz new)		\
 {									\
 	register unsigned long x0 asm ("x0") = (unsigned long)ptr;	\
-	register unsigned long x1 asm ("x1") = old;			\
+	register u##sz x1 asm ("x1") = old;				\
 	register u##sz x2 asm ("x2") = new;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 1f0340fc6dad..3f9376f1c409 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -123,9 +123,9 @@ static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpxchg_case##sfx##_8(ptr, (u8)old, new);	\
+		return __cmpxchg_case##sfx##_8(ptr, old, new);		\
 	case 2:								\
-		return __cmpxchg_case##sfx##_16(ptr, (u16)old, new);	\
+		return __cmpxchg_case##sfx##_16(ptr, old, new);		\
 	case 4:								\
 		return __cmpxchg_case##sfx##_32(ptr, old, new);		\
 	case 8:								\
-- 
2.1.4
