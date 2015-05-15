From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 15 May 2015 09:33:18 +0800
Subject: [PATCH 03/18] ARM: imx: Add an array of timer IP block versions
In-Reply-To: <1430405073-13106-4-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-4-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150515013318.GB10411@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:44:18AM -0500, Shenwei Wang wrote:
> Added an array to record the relationship between the
> compatible string and the version of timer IP block.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  arch/arm/mach-imx/time.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index 5df3c53..f44c2aa 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -372,6 +372,23 @@ void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
>  	_mxc_timer_init(irq, clk_per, clk_ipg);
>  }
>  
> +struct imx_timer_ip_combo {
> +	const char      *compat;
> +	int             version;
> +};
> +
> +static const struct imx_timer_ip_combo imx_timer_tables[] = {
> +	{"fsl,imx1-gpt",        IMX_TIMER_V0},
> +	{"fsl,imx25-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx25-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx50-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx51-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx53-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx6q-gpt",       IMX_TIMER_V2},
> +	{"fsl,imx6sl-gpt",      IMX_TIMER_V3},
> +	{"fsl,imx6sx-gpt",      IMX_TIMER_V3},
> +};
> +

I do not like this and the for-loop in mxc_timer_init_dt() to find
version number per compatible string.  I'd rather to have different init
function for different compatible string.

CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", imx25_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx50_timer, "fsl,imx50-gpt", imx25_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx51_timer, "fsl,imx51-gpt", imx25_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx53_timer, "fsl,imx53-gpt", imx25_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-gpt", imx25_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx6sl_timer, "fsl,imx6sl-gpt", imx6sl_timer_init_dt);
CLOCKSOURCE_OF_DECLARE(mx6sx_timer, "fsl,imx6sx-gpt", imx6sl_timer_init_dt);

Do not take that <soc>_timer_init_dt is a timer init function for <soc>,
but this an init time for <soc> type of timer.  In this case, we can
read it from above CLOCKSOURCE_OF_DECLAREs that imx25/50/51/53/6q are
all using imx25 type of gpt, and imx6sx is using the imx6sl type.

Shawn


>  static void __init mxc_timer_init_dt(struct device_node *np)
>  {
>  	struct clk *clk_per, *clk_ipg;
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
