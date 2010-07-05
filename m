From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Jul 2010 10:21:23 +0200
Subject: [PATCH] mx25: set GPT clock source to PER
In-Reply-To: <40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
References: <20100704084343.GB19559@jasper.tkos.co.il>
	<40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
Message-ID: <20100705082123.GD26079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 04, 2010 at 11:47:29AM +0300, Baruch Siach wrote:
> This fixes time accounting on mx25 base systems.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/plat-mxc/time.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> index f9a1b05..0d7e0f9 100644
> --- a/arch/arm/plat-mxc/time.c
> +++ b/arch/arm/plat-mxc/time.c
> @@ -56,6 +56,7 @@
>  /* MX31, MX35, MX25, MXC91231, MX5 */
>  #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
>  #define V2_TCTL_CLK_IPG		(1 << 6)
> +#define V2_TCTL_CLK_PER		(2 << 6)
>  #define V2_TCTL_FRR		(1 << 9)
>  #define V2_IR			0x0c
>  #define V2_TSTAT		0x08
> @@ -308,7 +309,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
>  	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
>  
>  	if (timer_is_v2())
> -		tctl_val = V2_TCTL_CLK_IPG | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> +		tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
>  	else
>  		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> 

I wonder why I applied

commit faed40665d2d81b7e0e537d14ef680ab3da9f22d
Author: Baruch Siach <baruch@tkos.co.il>
Date:   Mon Jan 25 12:58:21 2010 +0200

    mx25: fix time accounting
    
    The gpt_clk rate function doesn't consider the PER divider. This causes a
    significant drift in time accounting. Fix this by introducing the correct rate
    calculation function.
    
    Signed-off-by: Baruch Siach <baruch@tkos.co.il>
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 08aaa38..c003ac4 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -119,6 +119,11 @@ static unsigned long get_rate_nfc(struct clk *clk)
 	return get_rate_per(8);
 }
 
+static unsigned long get_rate_gpt(struct clk *clk)
+{
+	return get_rate_per(5);
+}
+
 static unsigned long get_rate_otg(struct clk *clk)
 {
 	return 48000000; /* FIXME */
@@ -156,7 +161,7 @@ static void clk_cgcr_disable(struct clk *clk)
 		.secondary	= s,			\
 	}
 
-DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
 DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);

This changed the gpt clock from ipg to the peripheral clock and I
explained why this is wrong. Now of course we now must use the
peripheral clock in the timer code.

Does it work when you revert faed40665d2d81b7e0e537d14ef680ab3da9f22d?

In any case, we can't apply your patch because it would break other v2
based architectures like i.MX35.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
