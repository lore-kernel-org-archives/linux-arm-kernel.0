From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jan 2010 08:57:33 +0100
Subject: [PATCH 2/2] mx25: properly initialize clocks, fix time accounting
In-Reply-To: <d05c786d8d87c1bb35e3f13d4fc9b8f4ddf18b3b.1264085584.git.baruch@tkos.co.il>
References: <cover.1264085584.git.baruch@tkos.co.il>
	<d05c786d8d87c1bb35e3f13d4fc9b8f4ddf18b3b.1264085584.git.baruch@tkos.co.il>
Message-ID: <20100122075733.GS7200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, Jan 21, 2010 at 05:00:23PM +0200, Baruch Siach wrote:
> For some odd reason the GPT module has run the timer counter at 100MHz, while
> the rate reported by the gpt_clk has been 133MHz. This caused a significant
> drift in time accounting.
> 
> This patch disables all unnecessary clock in mx25_clocks_init() to make a clean
> start, the same as is being done for the rest of the i.MX chips.
> 
> To preserve the uart and fec functionality, this patch temporarily enables the
> respective clocks in mx25_clocks_init(). The real fix for this is to use the
> .secondary field of the mxc clk struct, and enable these clocks from there.

Then lets implement it the real way, it's not too hard. The following
two patches should do it. It's compile tested only, can you test them on
hardware please? The patches do not include your timer rate fixup and
clock disabling fix.

> 
> This patch was tested on i.MX25 PDK.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-mx25/clock.c |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> index a4ba334..b1aadd5 100644
> --- a/arch/arm/mach-mx25/clock.c
> +++ b/arch/arm/mach-mx25/clock.c
> @@ -119,6 +119,11 @@ static unsigned long get_rate_nfc(struct clk *clk)
>  	return get_rate_per(8);
>  }
>  
> +static unsigned long get_rate_gpt(struct clk *clk)
> +{
> +	return get_rate_per(5);
> +}
> +
>  static unsigned long get_rate_otg(struct clk *clk)
>  {
>  	return 48000000; /* FIXME */
> @@ -155,7 +160,7 @@ static void clk_cgcr_disable(struct clk *clk)
>  		.disable	= clk_cgcr_disable,	\
>  	}
>  
> -DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL);
> +DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL);
>  DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL);
>  DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL);
>  DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL);
> @@ -215,6 +220,26 @@ int __init mx25_clocks_init(void)
>  	for (i = 0; i < ARRAY_SIZE(lookups); i++)
>  		clkdev_add(&lookups[i]);
>  
> +	/* Turn off all clocks except the ones we need to survive, namely:
> +	 * EMI, GPIO1-3 (CCM_CGCR1[18:16]), GPT1, IOMUXC (CCM_CGCR1[27]), IIM,
> +	 * SCC
> +	 */
> +	__raw_writel((1 << 19), CRM_BASE + CCM_CGCR0);
> +	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
> +	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);

Disabling the unused clocks here is a good thing. Can you add this for
the early debug case:

#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
	clk_enable(&uart1_clk);
#endif

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
