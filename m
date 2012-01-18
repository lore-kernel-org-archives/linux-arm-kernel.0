From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jan 2012 15:14:30 +0800
Subject: [PATCH v2] ARM: mx28: Clear CLKGATE bit prior to changing DIV
 field
In-Reply-To: <1326823131-27447-1-git-send-email-fabio.estevam@freescale.com>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <1326823131-27447-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120118071428.GA1741@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 03:58:51PM -0200, Fabio Estevam wrote:
> MX28 Reference Manual states the following about the CLKGATE bit of register HW_CLKCTRL_SAIF0:
> 
This is stated for not only SAIF but also other clocks with a divider.

> "The DIV field can change ONLY when this clock gate bit field is low."
> 
I'm afraid that the change of DIV field does not necessarily mean there
is a desired frequency output on the clock.  I remember I have done a
testing to see that I can update the DIV field of one clock with
clearing its gate bit but keeping its parent clock gated.  But obviously
you won't get a frequency output on the clock in this case.

So translating the above statement to what I have seen, I would say
the rate of one clock can only be changed when the clock is enabled.
To clk api client drivers, that means clk_enable() has been called
on the clock to have the clock itself and its parent clock enabled.

> So clear this bit prior to writing to the DIV field as required.
> 
I would say clk_enable() prior to clk_set_rate() is required.

> This also fixes the following error during mxs-sgtl5000 probe.
> 
> [    0.660000] saif0_clk_set_rate: divider writing timeout                     
> [    0.670000] mxs-sgtl5000: probe of mxs-sgtl5000.0 failed with error -110    
> [    0.670000] ALSA device list:                                               
> [    0.680000]   No soundcards found.  
> 
> Audio is functional after this change.
> 
This is an known issue.  Some people prefer to fix it in the mxs clock
code while I incline to say the client driver should be fixed for this.

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Clear CLKGATE  and DIV fields at the same time
> 
>  arch/arm/mach-mxs/clock-mx28.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..0bcfd97 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -475,7 +475,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  		return -EINVAL;						\
>  									\
>  	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> -	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
> +	reg &= ~(BM_CLKCTRL_##rs##_CLKGATE | BM_CLKCTRL_##rs##_DIV);	\
>  	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
>  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  									\
So you end up with leaving the gate bit of the clock changed by
clk_set_rate() call.  I'm not sure that is desirable.

Regards,
Shawn
