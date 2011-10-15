From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 15 Oct 2011 11:24:05 +0800
Subject: [PATCH 1/1] ARM: i.MX28: shift frac value in _CLK_SET_RATE
In-Reply-To: <1318627180-29865-1-git-send-email-matt@grid-net.com>
References: <1318627180-29865-1-git-send-email-matt@grid-net.com>
Message-ID: <20111015032405.GB29039@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 02:19:40PM -0700, Matt Burtch wrote:
> Noticed when setting SSP0 in clk_set_rate, _CLK_SET_RATE attempts to
> reset the clock divider for the SSP0 parent clock, in this case IO0FRAC.
> Bits 24-29 of HW_CLKCTRL_FRAC0 are cleared correctly, but when the new
> frac value is written the value isn't shifted up to write the correct
> bit-field.  This results in IO0FRAC being set to 0 and CPUFRAC being
> corrupted.
> 
> This should occur when writing IO1FRAC, EMIFRAC in HW_CLKCTRL_FRAC0 and
> GPMIFRAC, HSADCFRAC in HW_CLKCTRL_FRAC1.
> 
> Tested on custom i.MX28 board with SSP0 SPI driver.
> 
> Signed-off-by: Matt Burtch <matt@grid-net.com>

Maybe 'Cc: stable at kernel.org'?

> ---
>  arch/arm/mach-mxs/clock-mx28.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5dcc59d..b4ea439 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -349,7 +349,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  									\
>  		reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##fr);	\
>  		reg &= ~BM_CLKCTRL_##fr##_##fs##FRAC;			\
> -		reg |= frac;						\
> +		reg |= frac<<BP_CLKCTRL_##fr##_##fs##FRAC;		\

Add space before and after "<<"?

>  		__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##fr);	\
>  	}								\
>  									\
> -- 
Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
