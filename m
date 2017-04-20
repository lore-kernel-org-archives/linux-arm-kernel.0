From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Apr 2017 09:42:07 +0100
Subject: [PATCH] arm64: prefetch: Change assembly to be compatible with
 gcc and clang
In-Reply-To: <20170419212211.95803-1-mka@chromium.org>
References: <20170419212211.95803-1-mka@chromium.org>
Message-ID: <20170420084206.GB31436@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 02:22:11PM -0700, Matthias Kaehlcke wrote:
> clang fails to build with the current code:
> 
> arch/arm64/include/asm/processor.h:172:15: error: invalid operand in
> inline asm: 'prfm pldl1keep, ${0:a}'
> 
> Apparently clang does not support the 'a' modifier. Change the
> constraint from 'p' ('An operand that is a valid memory address is
> allowed') to 'Q' ('A memory address which uses a single base register
> with no offset'), which works for both gcc and clang.

It looks like the current %a0 template and p constraint were inherited
from arch/arm, as they've been there from day one on arm64.

Looking at the arch/arm history, the "a" operand modifier and "p"
constraint were introduced in commit:

  16f719de62809e22 ("[ARM] 5196/1: fix inline asm constraints for preload")

... so as to avoid GCC assuming prefetch of a pointer implied it was not
NULL. Until that point, we'd used no operand modifier and "o"
constraint.

It's not clear to me whether "o", "p", and "Q" constraints differ in
this regard on AArch64, or if the issue regarding NULL is still
relevant. The GCC docs say the "p" constraint is used for "a valid
memory address", which does sound like it shouldn't be NULL.

Otherwise, this does look consistent with what we do elsewhere.

Thanks,
Mark.

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/include/asm/processor.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index c97b8bd2acba..bfdc82e924a5 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -165,21 +165,21 @@ extern struct task_struct *cpu_switch_to(struct task_struct *prev,
>  #define ARCH_HAS_PREFETCH
>  static inline void prefetch(const void *ptr)
>  {
> -	asm volatile("prfm pldl1keep, %a0\n" : : "p" (ptr));
> +	asm volatile("prfm pldl1keep, %0\n" : : "Q" (ptr));
>  }
>  
>  #define ARCH_HAS_PREFETCHW
>  static inline void prefetchw(const void *ptr)
>  {
> -	asm volatile("prfm pstl1keep, %a0\n" : : "p" (ptr));
> +	asm volatile("prfm pstl1keep, %0\n" : : "Q" (ptr));
>  }
>  
>  #define ARCH_HAS_SPINLOCK_PREFETCH
>  static inline void spin_lock_prefetch(const void *ptr)
>  {
>  	asm volatile(ARM64_LSE_ATOMIC_INSN(
> -		     "prfm pstl1strm, %a0",
> -		     "nop") : : "p" (ptr));
> +		     "prfm pstl1strm, %0",
> +		     "nop") : : "Q" (ptr));
>  }
>  
>  #define HAVE_ARCH_PICK_MMAP_LAYOUT
> -- 
> 2.12.2.816.g2cccc81164-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
