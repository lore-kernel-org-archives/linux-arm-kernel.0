From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Oct 2015 17:00:18 +0100
Subject: [PATCH v2] arm: Adding support for atomic half word exchange
In-Reply-To: <1912649938.590071444050653292.JavaMail.weblogic@epmlwas01c>
References: <1912649938.590071444050653292.JavaMail.weblogic@epmlwas01c>
Message-ID: <20151005160017.GA3211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 01:10:53PM +0000, Sarbojit Ganguly wrote:
> My sincere apologies for the format issue. This was due to the e-mail editor
> which reformats the text.
> I am reposting the patch, please let me know if it is ok this time.
> 
> 
> v1-->v2 : Extended the guard code to cover the byte exchange case as 
> well following opinion of Will Deacon.
> Checkpatch has been run and issues were taken care of.
> 
> Since support for half-word atomic exchange was not there and Qspinlock
> on ARM requires it, modified __xchg() to add support for that as well.
> ARMv6 and lower does not support ldrex{b,h} so, added a guard code
> to prevent build breaks.
> 
> Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
> ---
>  arch/arm/include/asm/cmpxchg.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 916a274..a53cbeb 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -39,6 +39,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  
>  	switch (size) {
>  #if __LINUX_ARM_ARCH__ >= 6
> +#if !defined(CONFIG_CPU_V6)

#ifndef ? (to match the __cmpxchg code).

>  	case 1:
>  		asm volatile("@	__xchg1\n"
>  		"1:	ldrexb	%0, [%3]\n"
> @@ -49,6 +50,22 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  			: "r" (x), "r" (ptr)
>  			: "memory", "cc");
>  		break;
> +
> +		/*
> +		 * Half-word atomic exchange, required
> +		 * for Qspinlock support on ARM.
> +		 */

I think I said it before, but I don't think this comment is of any real
value.

Other than those, this looks ok to me.

Will
