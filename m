From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 11:20:20 +0000
Subject: [RFC PATCH] arm64: Fix __addr_ok and __range_ok macros
In-Reply-To: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
References: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
Message-ID: <20140313112019.GD30339@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:41:28PM +0000, Christopher Covington wrote:
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -66,12 +66,12 @@ static inline void set_fs(mm_segment_t fs)
>  #define segment_eq(a,b)	((a) == (b))
>  
>  /*
> - * Return 1 if addr < current->addr_limit, 0 otherwise.
> + * Return 1 if addr <= current->addr_limit, 0 otherwise.
>   */
>  #define __addr_ok(addr)							\
>  ({									\
>  	unsigned long flag;						\
> -	asm("cmp %1, %0; cset %0, lo"					\
> +	asm("cmp %1, %0; cset %0, ls"					\
>  		: "=&r" (flag)						\
>  		: "r" (addr), "0" (current_thread_info()->addr_limit)	\
>  		: "cc");						\

As Will said, this doesn't look right. Why do you need TASK_SIZE_64 to
be valid?

> @@ -83,7 +83,7 @@ static inline void set_fs(mm_segment_t fs)
>   * Returns 1 if the range is valid, 0 otherwise.
>   *
>   * This is equivalent to the following test:
> - * (u65)addr + (u65)size < (u65)current->addr_limit
> + * (u65)addr + (u65)size <= current->addr_limit
>   *
>   * This needs 65-bit arithmetic.
>   */
> @@ -91,7 +91,7 @@ static inline void set_fs(mm_segment_t fs)
>  ({									\
>  	unsigned long flag, roksum;					\
>  	__chk_user_ptr(addr);						\
> -	asm("adds %1, %1, %3; ccmp %1, %4, #2, cc; cset %0, cc"		\
> +	asm("adds %1, %1, %3; ccmp %1, %4, #3, cc; cset %0, ls"		\
>  		: "=&r" (flag), "=&r" (roksum)				\
>  		: "1" (addr), "Ir" (size),				\
>  		  "r" (current_thread_info()->addr_limit)		\

Just trying to understand: if adds does not set the C flag, we go on and
do the ccmp. If addr + size <= addr_limit, "cset ls" sets the flag
variable. If addr + size actually sets the C flag, we need to make sure
that "cset ls" doesn't trigger, which would mean to set C flag and clear
Z flag. So why do you change the ccmp flags from #2 to #3? It looks to
me like #2 is enough.

-- 
Catalin
