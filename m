From: rientjes@google.com (David Rientjes)
Date: Mon, 19 Jun 2017 13:25:22 -0700 (PDT)
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
References: <20170615155440.GC26471@leverpostej>
 <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
Message-ID: <alpine.DEB.2.10.1706191322590.95967@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jun 2017, Prasad Sodagudi wrote:

> Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
> static inline functions") re-defining the 'inline' macro but
> __attribute__((always_inline)) is missing. Some compilers may
> not honor inline hint if always_iniline attribute not there.
> So add always_inline attribute to inline as done by
> compiler-gcc.h file.
> 

IIUC, __attribute__((always_inline)) was only needed for gcc versions < 4 
and that the inlining decision making is improved in >= 4.  To make a 
change like this, I would think that we would need to show that clang is 
making suboptimal decisions.  I don't think there's a downside to making 
CONFIG_OPTIMIZE_INLINING specific only to gcc.

If it is shown that __attribute__((always_inline)) is needed for clang as 
well, this should be done as part of compiler-gcc.h to avoid duplicated 
code.

> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  include/linux/compiler-clang.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index d614c5e..deb65b3 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -22,4 +22,9 @@
>   * directives.  Suppress the warning in clang as well.
>   */
>  #undef inline
> +#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
> +    !defined(CONFIG_OPTIMIZE_INLINING)
> +#define inline inline __attribute__((always_inline)) __attribute__((unused)) notrace
> +#else
>  #define inline inline __attribute__((unused)) notrace
> +#endif
