From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2017 11:22:53 +0000
Subject: [PATCH] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170214213941.3026318-1-arnd@arndb.de>
References: <20170214213941.3026318-1-arnd@arndb.de>
Message-ID: <20170215112253.GB9630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:39:28PM +0100, Arnd Bergmann wrote:
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
>  arch/arm64/include/asm/bug.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> index 561190d15881..461751429fc3 100644
> --- a/arch/arm64/include/asm/bug.h
> +++ b/arch/arm64/include/asm/bug.h
> @@ -20,9 +20,10 @@
>  
>  #include <asm/brk-imm.h>
>  
> -#ifdef CONFIG_GENERIC_BUG
>  #define HAVE_ARCH_BUG
>  
> +#ifdef CONFIG_GENERIC_BUG
> +
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
>  #define __BUGVERBOSE_LOCATION(file, line)				\
> @@ -57,6 +58,14 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
>  
>  #define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
>  
> +#else
> +
> +#define BUG() do {					\
> +	asm volatile("brk %[imm]"			\
> +		     :: [imm] "i" (BUG_BRK_IMM));	\
> +	unreachable();					\
> +} while (0)

Do we need to duplicate the asm, or can we reuse the existing BUG
definition in this header? The only extra thing we do is push a __bug_table
entry, but I can't see why that would be a problem.

Will
