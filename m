From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 14:08:51 +0100
Subject: [PATCH] arm64: sysreg: Fix unprotected macro argmuent in
 write_sysreg
In-Reply-To: <1500983561-5723-1-git-send-email-Dave.Martin@arm.com>
References: <1500983561-5723-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170725130849.GA8358@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 12:52:41PM +0100, Dave Martin wrote:
> write_sysreg() may misparse the value argument because it is used
> without parentheses to protect it.
> 
> This patch adds the ( ) in order to avoid any surprises.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 16e44fa..822eebc 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -492,7 +492,7 @@ asm(
>   * the "%x0" template means XZR.
>   */
>  #define write_sysreg(v, r) do {					\
> -	u64 __val = (u64)v;					\
> +	u64 __val = (u64)(v);					\
>  	asm volatile("msr " __stringify(r) ", %x0"		\
>  		     : : "rZ" (__val));				\
>  } while (0)

Looks sensible.

It looks like write_sysreg_s() will need the same fixup; could you do
that too?

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
