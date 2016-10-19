From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 17:22:22 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
 <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
Message-ID: <20161019162222.GT9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 09:01:33AM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2016 at 8:56 AM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> > On 2016.10.19 at 08:55 -0700, Linus Torvalds wrote:
> >>
> >> Well, in the meantime we apparently have to live with it. Unless Will
> >> is using some unreleased gcc version that nobody else is using and we
> >> can just ignore it?
> >
> > Yes, he is using gcc-7 that is unreleased. (It will be released April
> > next year.)
> 
> Ahh, self-built? So it's not part of some experimental ARM distro
> setup and this will be annoying lots of people?

Our friendly compiler guys built it, but it's just a snapshot of trunk,
so it's all heading towards GCC 7.0. AFAIU, the problematic optimisation
is also a mid-end pass, so it would affect other architectures too.

> If so, still think that we could just get rid of the ____ilog2_NaN()
> thing as it's not _that_ important, but it's certainly not very
> high-priority. Will can do it in his tree too for testing, and it can
> remind people to get the gcc problem fixed.

I'm carrying the diff below, which fixes arm64 defconfig, but I'm worried
that we might be relying on this trick elsewhere. The arm __bad_cmpxchg
function, for example.

Will

--->8

diff --git a/include/linux/log2.h b/include/linux/log2.h
index fd7ff3d91e6a..9cf5ad69065d 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -16,12 +16,6 @@
 #include <linux/bitops.h>
 
 /*
- * deal with unrepresentable constant logarithms
- */
-extern __attribute__((const, noreturn))
-int ____ilog2_NaN(void);
-
-/*
  * non-constant log of base 2 calculators
  * - the arch may override these in asm/bitops.h if they can be implemented
  *   more efficiently than using fls() and fls64()
@@ -85,7 +79,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define ilog2(n)				\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n) < 1 ? ____ilog2_NaN() :	\
+		(n) < 1 ? 0 :			\
 		(n) & (1ULL << 63) ? 63 :	\
 		(n) & (1ULL << 62) ? 62 :	\
 		(n) & (1ULL << 61) ? 61 :	\
@@ -149,9 +143,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 		(n) & (1ULL <<  3) ?  3 :	\
 		(n) & (1ULL <<  2) ?  2 :	\
 		(n) & (1ULL <<  1) ?  1 :	\
-		(n) & (1ULL <<  0) ?  0 :	\
-		____ilog2_NaN()			\
-				   ) :		\
+		0) :				\
 	(sizeof(n) <= 4) ?			\
 	__ilog2_u32(n) :			\
 	__ilog2_u64(n)				\
@@ -194,7 +186,6 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  * @n: parameter
  *
  * The first few values calculated by this routine:
- *  ob2(0) = 0
  *  ob2(1) = 0
  *  ob2(2) = 1
  *  ob2(3) = 2
