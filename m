From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 19:09:39 +0000
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170314213939.3874497-1-arnd@arndb.de>
References: <20170314213939.3874497-1-arnd@arndb.de>
Message-ID: <20170320190939.GR17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 14, 2017 at 10:39:21PM +0100, Arnd Bergmann wrote:
> This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
> asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
> arm64 consistent with arm and x86, and avoids lots of warnings in
> randconfig builds, such as:
> 
> kernel/seccomp.c: In function '__seccomp_filter':
> kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Originally submitted v1 on Feb 14 as a simple addition of a few lines.
> v2 is a new version doing the same thing with a cleaner rewrite of
> the file, using three lines less, after a suggested from Will Deacon.
> 
> No need to get this into v4.11 though, especially as the rewrite
> makes it a bit risky. Please queue this for v4.12 if you like the
> new version.
> ---
>  arch/arm64/include/asm/bug.h | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)

Thanks for updating this. It looks correct to me, but I have one question
below.

> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> index 561190d15881..bfc6021760e5 100644
> --- a/arch/arm64/include/asm/bug.h
> +++ b/arch/arm64/include/asm/bug.h
> @@ -20,9 +20,6 @@
>  
>  #include <asm/brk-imm.h>
>  
> -#ifdef CONFIG_GENERIC_BUG
> -#define HAVE_ARCH_BUG
> -
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
>  #define __BUGVERBOSE_LOCATION(file, line)				\
> @@ -36,28 +33,37 @@
>  #define _BUGVERBOSE_LOCATION(file, line)
>  #endif
>  
> -#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
> +#ifdef CONFIG_GENERIC_BUG
>  
> -#define __BUG_FLAGS(flags) asm volatile (		\
> +#define __BUG_ENTRY(flags) 				\
>  		".pushsection __bug_table,\"a\"\n\t"	\
>  		".align 2\n\t"				\
>  	"0:	.long 1f - 0b\n\t"			\
>  _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
>  		".short " #flags "\n\t"			\
>  		".popsection\n"				\
> -							\
> -	"1:	brk %[imm]"				\
> -		:: [imm] "i" (BUG_BRK_IMM)		\
> -)
> +	"1:	"
> +#else
> +#define __BUG_ENTRY(flags) ""
> +#endif
> +
> +#define __BUG_FLAGS(flags)				\
> +	asm volatile (					\
> +		__BUG_ENTRY(0)				\
> +		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
> +	);
>  
> -#define BUG() do {				\
> -	_BUG_FLAGS(0);				\
> -	unreachable();				\
> +#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)

What is this for? I don't see _BUG_FLAGS used anywhere, but I could
be missing some macro expansion.

Will
