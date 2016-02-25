From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2016 18:29:03 +0000
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <CAKv+Gu_Bv0CsMrCR=fiowZjtmmepjdLi7RX94wv_oDdrbjr3iw@mail.gmail.com>
References: <CAKv+Gu94LAAwj2f9Sj9imn68V0VTF+NOtUPsE3tQnVzNDhAATw@mail.gmail.com>
 <20160225162622.GC16546@arm.com>
 <CAKv+Gu8Qx21M=ymne1S4CQUFrXKHTnWFygGBLtXbxiUD9GkiWw@mail.gmail.com>
 <20160225164208.GD16546@arm.com>
 <CAKv+Gu-REUdVJF-_wGU=LRaVRZqsD9bgny9S52pMLp+Es4E-1A@mail.gmail.com>
 <20160225164630.GF16546@arm.com>
 <CAKv+Gu8GYhPeXvgpAoHxYTYfqEHLqqLHVU9U6o3nvxew8dGo6A@mail.gmail.com>
 <CAKv+Gu_dXEQ1U2XY2=xX7R8MoPB0jKM7Vh3zgZB9tBuMfQYuGg@mail.gmail.com>
 <20160225165601.GG16546@arm.com>
 <CAKv+Gu_Bv0CsMrCR=fiowZjtmmepjdLi7RX94wv_oDdrbjr3iw@mail.gmail.com>
Message-ID: <20160225182902.GA29259@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 06:31:04PM +0100, Ard Biesheuvel wrote:
> On 25 February 2016 at 17:56, Will Deacon <will.deacon@arm.com> wrote:
> > the plt will do:
> >
> > get_addr_of_callee_into_x16_and_clobber_x17_or_something
> > br callee
> >
> > then the callee will be compiled with all those weird options, but *not*
> > the ones specifying x16 and x17. That means it can happily use those guys
> > as scratch, because the caller will take care of them.
> >
> 
> Yes, that makes sense. But if you don't relax that restriction, you
> only need the alternative __LL_SC_CALL for modules.

Totally untested patch below, but I'll give it a whirl tomorrow.

It looks a bit mental.

Will

--->8

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 197e06afbf71..5b595b32ab40 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -33,6 +33,8 @@ static inline void atomic_andnot(int i, atomic_t *v)
 	register atomic_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(andnot),
+	"	nop\n"
+	"	nop\n"
 	"	stclr	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -45,6 +47,8 @@ static inline void atomic_or(int i, atomic_t *v)
 	register atomic_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(or),
+	"	nop\n"
+	"	nop\n"
 	"	stset	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -57,6 +61,8 @@ static inline void atomic_xor(int i, atomic_t *v)
 	register atomic_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(xor),
+	"	nop\n"
+	"	nop\n"
 	"	steor	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -69,6 +75,8 @@ static inline void atomic_add(int i, atomic_t *v)
 	register atomic_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(add),
+	"	nop\n"
+	"	nop\n"
 	"	stadd	%w[i], %[v]\n")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -83,9 +91,9 @@ static inline int atomic_add_return##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
 	__LL_SC_ATOMIC(add_return##name),				\
 	/* LSE atomics */						\
+	"	nop\n"							\
 	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
 	"	add	%w[i], %w[i], w30")				\
 	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
@@ -109,9 +117,9 @@ static inline void atomic_and(int i, atomic_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC(and),
 	/* LSE atomics */
+	"	nop\n"
 	"	mvn	%w[i], %w[i]\n"
 	"	stclr	%w[i], %[v]")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
@@ -126,9 +134,9 @@ static inline void atomic_sub(int i, atomic_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC(sub),
 	/* LSE atomics */
+	"	nop\n"
 	"	neg	%w[i], %w[i]\n"
 	"	stadd	%w[i], %[v]")
 	: [i] "+r" (w0), [v] "+Q" (v->counter)
@@ -144,9 +152,7 @@ static inline int atomic_sub_return##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC(sub_return##name)				\
-	"	nop",							\
+	__LL_SC_ATOMIC(sub_return##name),				\
 	/* LSE atomics */						\
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
@@ -174,6 +180,8 @@ static inline void atomic64_andnot(long i, atomic64_t *v)
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(andnot),
+	"	nop\n"
+	"	nop\n"
 	"	stclr	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -186,6 +194,8 @@ static inline void atomic64_or(long i, atomic64_t *v)
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(or),
+	"	nop\n"
+	"	nop\n"
 	"	stset	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -198,6 +208,8 @@ static inline void atomic64_xor(long i, atomic64_t *v)
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(xor),
+	"	nop\n"
+	"	nop\n"
 	"	steor	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -210,6 +222,8 @@ static inline void atomic64_add(long i, atomic64_t *v)
 	register atomic64_t *x1 asm ("x1") = v;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(add),
+	"	nop\n"
+	"	nop\n"
 	"	stadd	%[i], %[v]\n")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
 	: "r" (x1)
@@ -224,9 +238,9 @@ static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
 	__LL_SC_ATOMIC64(add_return##name),				\
 	/* LSE atomics */						\
+	"	nop\n"							\
 	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
 	"	add	%[i], %[i], x30")				\
 	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
@@ -250,9 +264,9 @@ static inline void atomic64_and(long i, atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC64(and),
 	/* LSE atomics */
+	"	nop\n"
 	"	mvn	%[i], %[i]\n"
 	"	stclr	%[i], %[v]")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
@@ -267,9 +281,9 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC64(sub),
 	/* LSE atomics */
+	"	nop\n"
 	"	neg	%[i], %[i]\n"
 	"	stadd	%[i], %[v]")
 	: [i] "+r" (x0), [v] "+Q" (v->counter)
@@ -285,9 +299,7 @@ static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC64(sub_return##name)				\
-	"	nop",							\
+	__LL_SC_ATOMIC64(sub_return##name),				\
 	/* LSE atomics */						\
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
@@ -312,12 +324,10 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC64(dec_if_positive)
 	"	nop\n"
 	"	nop\n"
 	"	nop\n"
-	"	nop\n"
 	"	nop",
 	/* LSE atomics */
 	"1:	ldr	x30, %[v]\n"
@@ -350,9 +360,7 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-		__LL_SC_CMPXCHG(name)					\
-	"	nop",							\
+		__LL_SC_CMPXCHG(name),					\
 	/* LSE atomics */						\
 	"	mov	" #w "30, %" #w "[old]\n"			\
 	"	cas" #mb #sz "\t" #w "30, %" #w "[new], %[v]\n"		\
@@ -404,8 +412,6 @@ static inline long __cmpxchg_double##name(unsigned long old1,		\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
 	"	nop\n"							\
-	"	nop\n"							\
-	"	nop\n"							\
 	__LL_SC_CMPXCHG_DBL(name),					\
 	/* LSE atomics */						\
 	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 3de42d68611d..8252dc6b3046 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -25,7 +25,10 @@ __asm__(".arch_extension	lse");
 #define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
 
 /* Macro for constructing calls to out-of-line ll/sc atomics */
-#define __LL_SC_CALL(op)	"bl\t" __stringify(__LL_SC_PREFIX(op)) "\n"
+#define __LL_SC_CALL(op)						\
+	"stp	x16, x17, [sp, #-16]!\n"				\
+	"bl\t" __stringify(__LL_SC_PREFIX(op)) "\n"			\
+	"ldp	x16, x17, [sp], #16\n"
 
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 1a811ecf71da..c86b7909ef31 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -4,15 +4,16 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o
 
-# Tell the compiler to treat all general purpose registers as
-# callee-saved, which allows for efficient runtime patching of the bl
-# instruction in the caller with an atomic instruction when supported by
-# the CPU. Result and argument registers are handled correctly, based on
-# the function prototype.
+# Tell the compiler to treat all general purpose registers (with the
+# exception of the IP registers, which are already handled by the caller
+# in case of a PLT) as callee-saved, which allows for efficient runtime
+# patching of the bl instruction in the caller with an atomic instruction
+# when supported by the CPU. Result and argument registers are handled
+# correctly, based on the function prototype.
 lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
 CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
 		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
-		   -fcall-saved-x16 -fcall-saved-x17 -fcall-saved-x18
+		   -fcall-saved-x18
