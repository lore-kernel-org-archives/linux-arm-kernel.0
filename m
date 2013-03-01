From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Mar 2013 11:52:25 +0900
Subject: [PATCH v3 1/3] ARM: shmobile: sh73a0: wait for completion when
 kicking the clock
In-Reply-To: <1362054120-8600-2-git-send-email-g.liakhovetski@gmx.de>
References: <1362054120-8600-1-git-send-email-g.liakhovetski@gmx.de>
 <1362054120-8600-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130301025222.GA32306@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 01:21:58PM +0100, Guennadi Liakhovetski wrote:
> To reconfigure clocks, controlled by FRQCRA and FRQCRB, a kick bit has to
> be set and to make sure the setting has taken effect, it has to be read
> back repeatedly until it is cleared by the hardware. This patch adds the
> waiting part, that was missing until now.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch seems to be ready to be applied.

Magnus, could I get a review from you?

> ---
> 
> As noted in patch 0/3, this patch affects existing systems, but AFAICS 
> only theoretically - so far nobody is changing clock rates of any of the 
> FRQCRA and FRQCRB clocks. Still, please, handle with care.
> 
>  arch/arm/mach-shmobile/clock-sh73a0.c |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> index 71843dd..34b5c5a 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/sh_clk.h>
>  #include <linux/clkdev.h>
> +#include <asm/processor.h>
>  #include <mach/common.h>
>  
>  #define FRQCRA		IOMEM(0xe6150000)
> @@ -234,14 +235,24 @@ static struct clk *main_clks[] = {
>  	&sh73a0_extalr_clk,
>  };
>  
> -static void div4_kick(struct clk *clk)
> +static int frqcr_kick(void)
>  {
> -	unsigned long value;
> +	int i;
> +
> +	/* set KICK bit in FRQCRB to update hardware setting, check success */
> +	__raw_writel(__raw_readl(FRQCRB) | (1 << 31), FRQCRB);
> +	for (i = 1000; i; i--)
> +		if (__raw_readl(FRQCRB) & (1 << 31))
> +			cpu_relax();
> +		else
> +			return i;
> +
> +	return -ETIMEDOUT;
> +}
>  
> -	/* set KICK bit in FRQCRB to update hardware setting */
> -	value = __raw_readl(FRQCRB);
> -	value |= (1 << 31);
> -	__raw_writel(value, FRQCRB);
> +static void div4_kick(struct clk *clk)
> +{
> +	frqcr_kick();
>  }
>  
>  static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18,
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
