From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Oct 2015 15:54:31 +0100
Subject: [PATCH v3] arm: Adding support for atomic half word
 exchange
In-Reply-To: <795992290.5810091444118582583.JavaMail.weblogic@epmlwas01d>
References: <795992290.5810091444118582583.JavaMail.weblogic@epmlwas01d>
Message-ID: <20151006145431.GA12382@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 08:03:02AM +0000, Sarbojit Ganguly wrote:
> Here is the version 3 of the patch correcting earlier issues.

This looks good to me now:

  Acked-by: Will Deacon <will.deacon@arm.com>

> v2 -> v3 : Removed the comment related to Qspinlock, changed !defined to
> #ifndef.
> v1 -> v2 : Extended the guard code to cover the byte exchange case as 
> well following opinion of Will Deacon.
> Checkpatch has been run and issues were taken care of.

The part of your text up until here doesn't belong in the commit message.
You'll also need to send this to Russell's patch system.

Will

> Since support for half-word atomic exchange was not there and Qspinlock
> on ARM requires it, modified __xchg() to add support for that as well.
> ARMv6 and lower does not support ldrex{b,h} so, added a guard code
> to prevent build breaks.
> 
> Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
> ---
>  arch/arm/include/asm/cmpxchg.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 916a274..c6436c1 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -39,6 +39,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  
>  	switch (size) {
>  #if __LINUX_ARM_ARCH__ >= 6
> +#ifndef CONFIG_CPU_V6 /* MIN ARCH >= V6K */
>  	case 1:
>  		asm volatile("@	__xchg1\n"
>  		"1:	ldrexb	%0, [%3]\n"
> @@ -49,6 +50,17 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  			: "r" (x), "r" (ptr)
>  			: "memory", "cc");
>  		break;
> +	case 2:
> +		asm volatile("@	__xchg2\n"
> +		"1:	ldrexh	%0, [%3]\n"
> +		"	strexh	%1, %2, [%3]\n"
> +		"	teq	%1, #0\n"
> +		"	bne	1b"
> +			: "=&r" (ret), "=&r" (tmp)
> +			: "r" (x), "r" (ptr)
> +			: "memory", "cc");
> +		break;
> +#endif
>  	case 4:
>  		asm volatile("@	__xchg4\n"
>  		"1:	ldrex	%0, [%3]\n"
> -- 
> 1.9.1
