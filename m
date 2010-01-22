From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 22 Jan 2010 08:50:41 +0200
Subject: [PATCH 2/2] mx25: properly initialize clocks, fix time accounting
In-Reply-To: <d05c786d8d87c1bb35e3f13d4fc9b8f4ddf18b3b.1264085584.git.baruch@tkos.co.il>
References: <cover.1264085584.git.baruch@tkos.co.il>
	<d05c786d8d87c1bb35e3f13d4fc9b8f4ddf18b3b.1264085584.git.baruch@tkos.co.il>
Message-ID: <20100122065041.GB29296@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jan 21, 2010 at 05:00:23PM +0200, Baruch Siach wrote:
> For some odd reason the GPT module has run the timer counter at 100MHz, while
> the rate reported by the gpt_clk has been 133MHz. This caused a significant
> drift in time accounting.

I probably miscalculated the drift. The real rate of gpt_clk was, apparently, 
66.5MHz, so get_rate_gpt() is all that's needed to fix time accounting drift.  
I'll test and resend this patch next week, and then go on to fix the clock 
initialization of the mx25.

baruch

> This patch disables all unnecessary clock in mx25_clocks_init() to make a clean
> start, the same as is being done for the rest of the i.MX chips.
> 
> To preserve the uart and fec functionality, this patch temporarily enables the
> respective clocks in mx25_clocks_init(). The real fix for this is to use the
> .secondary field of the mxc clk struct, and enable these clocks from there.
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
> +
> +	/* Enable FEC IPG
> +	 * FIXME: implement secondary clock
> +	 */
> +	__raw_writel(__raw_readl(CRM_BASE + CCM_CGCR1) | (1 << 15),
> +			CRM_BASE + CCM_CGCR1);
> +
> +	/* Enable uart PER
> +	 * FIXME: implement secondary clock
> +	 */
> +	__raw_writel(__raw_readl(CRM_BASE + CCM_CGCR0) | (1 << 15),
> +			CRM_BASE + CCM_CGCR0);
> +
>  	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
>  
>  	return 0;
> -- 
> 1.6.5
> 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
