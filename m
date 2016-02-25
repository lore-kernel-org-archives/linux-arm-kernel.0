From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 20:10:42 +0100
Subject: [PATCH] arm64: lse: deal with clobbered x16 register after branch via
 PLT
Message-ID: <1456427442-21023-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LSE atomics implementation uses runtime patching to patch in calls
to out of line non-LSE atomics implementations on cores that lack hardware
support for LSE. To avoid paying the overhead cost of a function call even
if no call ends up being made, the bl instruction is kept invisible to the
compiler, and the out of line implementations preserve all registers, not
just the ones that they must preserve as per the AAPCS64.

However, commit fd045f6cd98e ("arm64: add support for module PLTs") added
support for routing branch instructions via veneers if the branch target
offset exceeds the range of the ordinary relative branch instructions.
Since this deals with jump and call instructions that are exposed to ELF
relocations, the PLT code uses register x16 to hold the address of the
branch target when it performs an indirect branch-to-register, something
which is explicitly allowed by the AAPCS64 (and compiler generated code
does not expect register x16 to retain its value across a bl instruction).

Since the lse runtime patched bl instructions don't adhere to the AAPCS64,
they don't deal with this clobbering of register x16. So add it to the
clobber list of the asm() statements that perform the call instructions,
and drop x16 from the list of registers that are caller saved in the out
of line non-LSE implementations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/atomic_lse.h | 38 ++++++++++----------
 arch/arm64/lib/Makefile             |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 197e06afbf71..5bb51340571e 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -36,7 +36,7 @@ static inline void atomic_andnot(int i, atomic_t *v)
 	"	stclr	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic_or(int i, atomic_t *v)
@@ -48,7 +48,7 @@ static inline void atomic_or(int i, atomic_t *v)
 	"	stset	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic_xor(int i, atomic_t *v)
@@ -60,7 +60,7 @@ static inline void atomic_xor(int i, atomic_t *v)
 	"	steor	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic_add(int i, atomic_t *v)
@@ -72,7 +72,7 @@ static inline void atomic_add(int i, atomic_t *v)
 	"	stadd	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 #define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
@@ -90,7 +90,7 @@ static inline int atomic_add_return##name(int i, atomic_t *v)		\
 	"	add	%w[i], %w[i], w30")				\
 	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: "x30" , ##cl);						\
+	: "x16", "x30", ##cl);						\
 									\
 	return w0;							\
 }
@@ -116,7 +116,7 @@ static inline void atomic_and(int i, atomic_t *v)
 	"	stclr	%w[i], %[v]")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic_sub(int i, atomic_t *v)
@@ -133,7 +133,7 @@ static inline void atomic_sub(int i, atomic_t *v)
 	"	stadd	%w[i], %[v]")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 #define ATOMIC_OP_SUB_RETURN(name, mb, cl...)				\
@@ -153,7 +153,7 @@ static inline int atomic_sub_return##name(int i, atomic_t *v)		\
 	"	add	%w[i], %w[i], w30")				\
 	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: "x30" , ##cl);						\
+	: "x16", "x30" , ##cl);						\
 									\
 	return w0;							\
 }
@@ -177,7 +177,7 @@ static inline void atomic64_andnot(long i, atomic64_t *v)
 	"	stclr	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic64_or(long i, atomic64_t *v)
@@ -189,7 +189,7 @@ static inline void atomic64_or(long i, atomic64_t *v)
 	"	stset	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic64_xor(long i, atomic64_t *v)
@@ -201,7 +201,7 @@ static inline void atomic64_xor(long i, atomic64_t *v)
 	"	steor	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic64_add(long i, atomic64_t *v)
@@ -213,7 +213,7 @@ static inline void atomic64_add(long i, atomic64_t *v)
 	"	stadd	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
@@ -231,7 +231,7 @@ static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
 	"	add	%[i], %[i], x30")				\
 	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: "x30" , ##cl);						\
+	: "x16", "x30", ##cl);						\
 									\
 	return x0;							\
 }
@@ -257,7 +257,7 @@ static inline void atomic64_and(long i, atomic64_t *v)
 	"	stclr	%[i], %[v]")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 static inline void atomic64_sub(long i, atomic64_t *v)
@@ -274,7 +274,7 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 	"	stadd	%[i], %[v]")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
-	: "x30");
+	: "x16", "x30");
 }
 
 #define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)				\
@@ -294,7 +294,7 @@ static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
 	"	add	%[i], %[i], x30")				\
 	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: "x30" , ##cl);						\
+	: "x16", "x30", ##cl);						\
 									\
 	return x0;							\
 }
@@ -330,7 +330,7 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 	"2:")
 	: [ret] "+&r" (x0), [v] "+Q" (v->counter)
 	:
-	: "x30", "cc", "memory");
+	: "x16", "x30", "cc", "memory");
 
 	return x0;
 }
@@ -359,7 +359,7 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
 	"	mov	%" #w "[ret], " #w "30")			\
 	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr)		\
 	: [old] "r" (x1), [new] "r" (x2)				\
-	: "x30" , ##cl);						\
+	: "x16", "x30", ##cl);						\
 									\
 	return x0;							\
 }
@@ -416,7 +416,7 @@ static inline long __cmpxchg_double##name(unsigned long old1,		\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
 	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
 	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
-	: "x30" , ##cl);						\
+	: "x16", "x30", ##cl);						\
 									\
 	return x0;							\
 }
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 1a811ecf71da..a2843ac38d7f 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -15,4 +15,4 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
-		   -fcall-saved-x16 -fcall-saved-x17 -fcall-saved-x18
+		   -fcall-saved-x17 -fcall-saved-x18
-- 
2.5.0
