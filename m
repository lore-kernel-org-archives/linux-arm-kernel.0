From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Mon, 26 Jun 2017 17:11:51 -0700
Subject: [patch resend 4.12] compiler, clang: always inline when
 CONFIG_OPTIMIZE_INLINING is disabled
In-Reply-To: <alpine.DEB.2.10.1706261552200.1075@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1706261552200.1075@chino.kir.corp.google.com>
Message-ID: <dbce95bb489d763c38dfc042cc820b9e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-26 16:03, David Rientjes wrote:
> The motivation of commit abb2ea7dfd82 ("compiler, clang: suppress 
> warning
> for unused static inline functions") is to suppress clang's warnings 
> about
> unused static inline functions.
> 
> For configs without CONFIG_OPTIMIZE_INLINING enabled, such as any 
> non-x86
> architecture, `inline' in the kernel implies that
> __attribute__((always_inline)) is used.
> 
> Some code depends on that behavior, see
> https://lkml.org/lkml/2017/6/13/918:
> 
> net/built-in.o: In function `__xchg_mb':
> arch/arm64/include/asm/cmpxchg.h:99: undefined reference to
> `__compiletime_assert_99'
> arch/arm64/include/asm/cmpxchg.h:99: undefined reference to
> `__compiletime_assert_99
> 
> The full fix would be to identify these breakages and annotate the
> functions with __always_inline instead of `inline'.  But since we are 
> late
> in the 4.12-rc cycle, simply carry forward the forced inlining behavior
> and work toward moving arm64, and other architectures, toward
> CONFIG_OPTIMIZE_INLINING behavior.
> 
> Reported-by: Sodagudi Prasad <psodagud@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Resend of http://marc.info/?l=linux-kernel&m=149681501816319 for 4.12
>  inclusion.
> 
>  Prasad, please add your Tested-by.
> 

I have compile tested this change with clang, please add -

Tested-by: Sodagudi Prasad <psodagud@codeaurora.org>

-Thanks, Prasad

>  include/linux/compiler-clang.h |  8 --------
>  include/linux/compiler-gcc.h   | 18 +++++++++++-------
>  2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/compiler-clang.h 
> b/include/linux/compiler-clang.h
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -15,11 +15,3 @@
>   * with any version that can compile the kernel
>   */
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), 
> __COUNTER__)
> -
> -/*
> - * GCC does not warn about unused static inline functions for
> - * -Wunused-function.  This turns out to avoid the need for complex 
> #ifdef
> - * directives.  Suppress the warning in clang as well.
> - */
> -#undef inline
> -#define inline inline __attribute__((unused)) notrace
> diff --git a/include/linux/compiler-gcc.h 
> b/include/linux/compiler-gcc.h
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -66,18 +66,22 @@
> 
>  /*
>   * Force always-inline if the user requests it so via the .config,
> - * or if gcc is too old:
> + * or if gcc is too old.
> + * GCC does not warn about unused static inline functions for
> + * -Wunused-function.  This turns out to avoid the need for complex 
> #ifdef
> + * directives.  Suppress the warning in clang as well by using 
> "unused"
> + * function attribute, which is redundant but not harmful for gcc.
>   */
>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
>      !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
> -#define inline		inline		__attribute__((always_inline)) notrace
> -#define __inline__	__inline__	__attribute__((always_inline)) notrace
> -#define __inline	__inline	__attribute__((always_inline)) notrace
> +#define inline inline		__attribute__((always_inline,unused)) notrace
> +#define __inline__ __inline__	__attribute__((always_inline,unused)) 
> notrace
> +#define __inline __inline	__attribute__((always_inline,unused)) 
> notrace
>  #else
>  /* A lot of inline functions can cause havoc with function tracing */
> -#define inline		inline		notrace
> -#define __inline__	__inline__	notrace
> -#define __inline	__inline	notrace
> +#define inline inline		__attribute__((unused)) notrace
> +#define __inline__ __inline__	__attribute__((unused)) notrace
> +#define __inline __inline	__attribute__((unused)) notrace
>  #endif
> 
>  #define __always_inline	inline __attribute__((always_inline))

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
