From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Mar 2012 10:52:11 +0800
Subject: [PATCH 1/1] ARM iMX28: incorrect frac/div calculation
In-Reply-To: <1332457501-8153-1-git-send-email-matt@grid-net.com>
References: <1332457501-8153-1-git-send-email-matt@grid-net.com>
Message-ID: <20120323025208.GG2213@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 04:05:01PM -0700, Matt Burtch wrote:
> The frac and div values in _CLK_SET_RATE are calculated incorrectly
> for some clock rates ie. CPU clk of 454.73MHz, 392.72MHz, 261.81Mhz,
> etc.
> 
> Now the frac and div values which result in the closest actual clock
> rate to that requested is selected.

My understanding on clk_set_rate is we need to set the clk to a rate
closest to the requested one but never exceeding it.  Does your change
ensure that?

Regards,
Shawn

> Also there are no limitations
> on what frac values can be used, as long as they fall in the valid
> (18 < frac < 35) range.
> 
> Tested on custom iMX28 board.
> 
> Signed-off-by: Matt Burtch <matt@grid-net.com>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..a058b99 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -354,19 +354,15 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  		}							\
>  		for (d = 1; d <= div_max; d++) {			\
>  			f = parent_rate * 18 / d / rate;		\
> -			if ((parent_rate * 18 / d) % rate)		\
> -				f++;					\
>  			if (f < 18 || f > 35)				\
>  				continue;				\
>  									\
>  			calc_rate = parent_rate * 18 / f / d;		\
> -			if (calc_rate > rate)				\
> -				continue;				\
>  									\
> -			if (rate - calc_rate < diff) {			\
> +			if (abs(rate - calc_rate) < diff) {		\
>  				frac = f;				\
>  				div = d;				\
> -				diff = rate - calc_rate;		\
> +				diff = abs(rate - calc_rate);		\
>  			}						\
>  									\
>  			if (diff == 0)					\
> -- 
> 1.7.5.4
> 
