From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jun 2017 16:54:40 +0100
Subject: Using __always_inline attribute
In-Reply-To: <9198053a46999b0b46dcab992527d0d7@codeaurora.org>
References: <2a762f1f3b355e71c5bca6a6e00bffe0@codeaurora.org>
 <20170614100641.GB16190@arm.com>
 <9198053a46999b0b46dcab992527d0d7@codeaurora.org>
Message-ID: <20170615155440.GC26471@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 14, 2017 at 03:33:59PM -0700, Sodagudi Prasad wrote:
> On 2017-06-14 03:06, Will Deacon wrote:
> >On Tue, Jun 13, 2017 at 03:39:37PM -0700, Sodagudi Prasad wrote:
> >>With a variant of a CLANG(based on 4.0) following errors
> >>observed on Linux
> >>4.12-rc5 tag.

> >>net/built-in.o: In function `__xchg_mb':
> >>arch/arm64/include/asm/cmpxchg.h:99: \
> >>                    undefined reference to `__compiletime_assert_99'
> >>arch/arm64/include/asm/cmpxchg.h:99: \
> >>                    undefined reference to `__compiletime_assert_99
> >>
> >>Clang does not seems to be marking this macro as inline and
> >>causing above
> >>compilation issue due to BUILD_BUG().
> >
> >The only BUILD_BUG I see around here is if the size parameter (which
> >is calculated using sizeof) is not known to be 1,2,4 or 8 at compile
> >time. It would be interesting to know which call site is confusing
> >clang in this way and what code is actually being emitted here.
> >
> >If it's just that __xchg_mb isn't being inlined into the
> >__xchg_wrapper macro, then your patch should be ok, but I'd like to
> >be sure it's not something else. I'm also surprised you haven't see
> >this crop up in other places.
> >
> After digging further, we observed that inline definition was
> changed recently and causing this issue.
> Here is missing part of inline macro definition __attribute__((unused)).
> 
> Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
> static inline functions") have redefined the inline macro as below
> #define inline inline __attribute__((unused))
> 
> But actual definition of inline macro defined compiler-gcc.h file as
> shown below.
> #define inline          inline
> __attribute__((always_inline)) notrace

FWIW, this happesn to be true for arm64 today, but it's not always the
case. When ARCH_SUPPORTS_OPTIMIZED_INLINING && OPTIMIZE_INLINING, inline
is not equivalent to __always_inline.

It looks like x86 has ARCH_SUPPORTS_OPTIMIZED_INLINING and selects
OPTIMIZE_INLINING in its defconfigs, so core code should be clean, and
presumably the option is a net win on x86.

It mgiht be worth taking a look if this would be beneficial for arm64,
even if we have to apply a few s/inline/__always_inline/ fixups as with
this case.

> As always_inline attribute is missing in inline definition, compile
> may not inline macros __xchg_mb in
> arch/arm64/include/asm/cmpxchg.h file and leading to error.
> 
> Some compilers may not honor inline as inline if always_inline
> attribute is removed because of
> -inline-threshold compiler options.
> 
> Here is the change to fix this issue-
> diff --git a/include/linux/compiler-clang.h
> b/include/linux/compiler-clang.h
> index d614c5e..a0e6433 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -22,4 +22,4 @@
>   * directives.  Suppress the warning in clang as well.
>   */
>  #undef inline
> -#define inline inline __attribute__((unused)) notrace
> +#define inline __attribute__((always_inline))
> __attribute__((unused)) notrace

Assuming this has the same gaurds for ARCH_SUPPORTS_OPTIMIZED_INLINING
&& OPTIMIZE_INLINING, it looks fine to me. Otherwise, I suspect this may
be overly pessimistic.

Thanks,
Mark.
