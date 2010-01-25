From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 25 Jan 2010 12:11:06 +0100
Subject: [PATCH 3/4] mx25: fix time accounting
In-Reply-To: <fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
References: <20100125105439.GE6724@jasper.tkos.co.il>
	<fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
Message-ID: <19293.31818.225869.565911@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Baruch Siach writes:
> The gpt_clk rate function doesn't consider the PER divider. This causes a
> significant drift in time accounting. Fix this by introducing the correct rate
> calculation function.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-mx25/clock.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
> index 08aaa38..c003ac4 100644
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
> @@ -156,7 +161,7 @@ static void clk_cgcr_disable(struct clk *clk)
>  		.secondary	= s,			\
>  	}
>  
> -DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
> +DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
>  DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
>  DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
>  DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
>
IMO all those clocks should have the appropriate parent clocks, which
would fix the problem with the GPT clock rate without the need for a
special get_rate_*() functions and woould also make sure the parent
clock is enabled when the child clock is being enabled:
|DEFINE_CLOCK(gpt1_clk1,   0, CCM_CGCR1, 19, NULL, NULL, &ipg_clk);
|DEFINE_CLOCK(gpt1_clk,    0, CCM_CGCR0,  5, NULL, &gpt1_clk1, &per_clk5);
...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
