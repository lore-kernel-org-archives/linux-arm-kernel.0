From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 15 May 2015 10:05:08 +0800
Subject: [PATCH 07/18] ARM: imx: Initialize the imx_timer structure
In-Reply-To: <1430405073-13106-8-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-8-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150515020508.GD10411@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:44:22AM -0500, Shenwei Wang wrote:
> Initialized the imx_timer struct  in the following two functions:
> mxc_timer_init
> mxc_timer_init_dt
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  arch/arm/mach-imx/time.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index 811d50a..451f761 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/slab.h>
>  
>  #include <asm/mach/time.h>
>  
> @@ -536,12 +537,29 @@ static void __init _mxc_timer_init(int irq,
>  
>  void __init mxc_timer_init(unsigned long pbase, int irq, int ver)
>  {
> +	struct imx_timer *timer;
>  	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
>  	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
>  
>  	timer_base = ioremap(pbase, SZ_4K);
>  	BUG_ON(!timer_base);
>  
> +	timer = kzalloc(sizeof(struct imx_timer), GFP_KERNEL);
> +	if (!timer)
> +		panic("Can't allocate timer struct\n");
> +
> +	timer->timer_base = timer_base;
> +	timer->version = ver;
> +	timer->evt.name = "mxc_timer1";
> +	timer->evt.rating = 200;
> +	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	timer->evt.set_mode = mxc_set_mode;
> +	timer->evt.set_next_event = v2_set_next_event;
> +	timer->act.name = "i.MX Timer Tick";
> +	timer->act.flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	timer->act.dev_id = timer;
> +	timer->act.handler = mxc_timer_interrupt;
> +
>  	_mxc_timer_init(irq, clk_per, clk_ipg);
>  }
>  
> @@ -565,11 +583,34 @@ static const struct imx_timer_ip_combo imx_timer_tables[] = {
>  static void __init mxc_timer_init_dt(struct device_node *np)
>  {
>  	struct clk *clk_per, *clk_ipg;
> -	int irq;
> +	int irq, i, ret, ver;
> +	struct imx_timer *timer;
>  
>  	if (timer_base)
>  		return;
>  
> +	for (i =  0; i < sizeof(imx_timer_tables) /
> +			sizeof(struct imx_timer_ip_combo); i++) {
> +		ret = of_device_is_compatible(np, imx_timer_tables[i].compat);
> +		if (ret) {
> +			ver = imx_timer_tables[i].version;
> +			pr_err("<%s> compatible=%s timer_version=%d\r\n",
> +				__func__, imx_timer_tables[i].compat, ver);
> +			break;
> +		}
> +	}
> +
> +	if (!ret) {
> +		pr_err("<%s> timer device node is not supported\r\n", __func__);
> +		return;
> +	}
> +
> +	timer = kzalloc(sizeof(struct imx_timer), GFP_KERNEL);
> +	if (!timer)
> +		panic("Can't allocate timer struct\n");
> +
> +	timer->timer_base = of_iomap(np, 0);
> +
>  	timer_base = of_iomap(np, 0);
>  	WARN_ON(!timer_base);
>  	irq = irq_of_parse_and_map(np, 0);
> @@ -581,8 +622,20 @@ static void __init mxc_timer_init_dt(struct device_node *np)
>  	if (IS_ERR(clk_per))
>  		clk_per = of_clk_get_by_name(np, "per");
>  
> +	timer->version = ver;
> +	timer->evt.name = np->name;

These names shouldn't be treated differently between DT and non-DT.
Also I do not see obvious benefit to allocate the structure over static
definition.  Using static one can let us keep necessary consistency
between DT and non-DT.

Shawn

> +	timer->evt.rating = 200;
> +	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	timer->evt.set_mode = mxc_set_mode;
> +	timer->evt.set_next_event = v2_set_next_event;
> +	timer->act.name = np->name;
> +	timer->act.flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	timer->act.dev_id = timer;
> +	timer->act.handler = mxc_timer_interrupt;
> +
>  	_mxc_timer_init(irq, clk_per, clk_ipg);
>  }
> +
>  CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx50_timer, "fsl,imx50-gpt", mxc_timer_init_dt);
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
