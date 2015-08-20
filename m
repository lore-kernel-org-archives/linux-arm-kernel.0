From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Aug 2015 11:38:11 +0100
Subject: [PATCH] arm: Adding support for atomic half word exchange
In-Reply-To: <1707387422.329291440052843653.JavaMail.weblogic@ep2mlwas04c>
References: <1707387422.329291440052843653.JavaMail.weblogic@ep2mlwas04c>
Message-ID: <20150820103810.GC19328@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 07:40:44AM +0100, Sarbojit Ganguly wrote:
> My apologies, the e-mail editor was not configured properly.
> CC'ed to relevant maintainers and reposting once again with proper formatting.
> 
> Since 16 bit half word exchange was not there and MCS based qspinlock
> by Waiman's xchg_tail() requires an atomic exchange on a half word, 
> here is a small modification to __xchg() code to support the exchange.
> ARMv6 and lower does not have support for LDREXH, so we need to make sure things
> do not break when we're compiling on ARMv6.
> 
> Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
> ---
>  arch/arm/include/asm/cmpxchg.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 1692a05..547101d 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -50,6 +50,24 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>                         : "r" (x), "r" (ptr)
>                         : "memory", "cc");
>                 break;
> +#if !defined (CONFIG_CPU_V6)
> +               /*
> +                * Halfword exclusive exchange
> +                * This is new implementation as qspinlock
> +                * wants 16 bit atomic CAS.
> +                * This is not supported on ARMv6.
> +                */

I don't think you need this comment. We don't use qspinlock on arch/arm/.

> +       case 2:
> +               asm volatile("@ __xchg2\n"
> +               "1:     ldrexh  %0, [%3]\n"
> +               "       strexh  %1, %2, [%3]\n"
> +               "       teq     %1, #0\n"
> +               "       bne     1b"
> +               : "=&r" (ret), "=&r" (tmp)
> +               : "r" (x), "r" (ptr)
> +               : "memory", "cc");
> +               break;
> +#endif
>         case 4:
>                 asm volatile("@ __xchg4\n"
>                 "1:     ldrex   %0, [%3]\n"

We have the same issue with the byte exclusives, so I think you need
to extend the guard you're adding to cover that case too (which is a bug
in current mainline).

Will
