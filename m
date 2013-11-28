From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 16:43:29 +0900
Subject: [PATCH] ARM: shmobile: mackerel: clk_round_rate() can return a
 zero to indicate an error
In-Reply-To: <alpine.DEB.2.02.1311261647550.11450@tamien>
References: <alpine.DEB.2.02.1311261647550.11450@tamien>
Message-ID: <20131128074329.GG24146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:49:38PM -0800, Paul Walmsley wrote:
> 
> Treat both negative and zero return values from clk_round_rate() as
> errors.  This is needed since subsequent patches will convert
> clk_round_rate()'s return value to be an unsigned type, rather than a
> signed type, since some clock sources can generate rates higher than
> (2^31)-1 Hz.
> 
> Eventually, when calling clk_round_rate(), only a return value of zero
> will be considered a error.  All other values will be considered valid
> rates.  The comparison against values less than 0 is kept to preserve
> the correct behavior in the meantime.
> 
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
> Applies on v3.13-rc1.  See also:
> 
>     http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2
> 
>  arch/arm/mach-shmobile/board-mackerel.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Paul,

I have queued this up.

> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index af06753eb809..d90d2f11071b 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -548,9 +548,9 @@ static void __init hdmi_init_pm_clock(void)
>  		 clk_get_rate(&sh7372_pllc2_clk));
> 
>  	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
> -	if (rate < 0) {
> +	if (rate <= 0) {
>  		pr_err("Cannot get suitable rate: %ld\n", rate);
> -		ret = rate;
> +		ret = -EINVAL;
>  		goto out;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
