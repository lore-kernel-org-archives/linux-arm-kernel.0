From: mturquette@ti.com (Mike Turquette)
Date: Thu, 14 Jun 2012 12:11:47 -0700
Subject: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1339678038-23082-5-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-5-git-send-email-rnayak@ti.com>
Message-ID: <20120614191147.GP19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120614-18:16, Rajendra Nayak wrote:
> As we move to Common clk framework use clk_prepare_enable()
> instead of clk_enable() and similarly clk_disable_unprepare()
> instead of clk_disable()
> 
> Based on initial changes from Mike turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Hi Rajendra,

This change looks good except for two questions I have below, related to
calling prepare in an interrupt context.  If those are non-issues then
please add my:

Acked-by: Mike Turquette <mturquette@linaro.org>

(or my Reviewed-by... I can never remember which one is correct)

snip

> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 5fb47a1..e5f8e48 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -471,7 +471,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  
>  	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
>  		if (oc->_clk)
> -			clk_enable(oc->_clk);
> +			clk_prepare_enable(oc->_clk);
>  
>  	dispc_disable_outputs();
>  
> @@ -498,7 +498,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  
>  	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
>  		if (oc->_clk)
> -			clk_disable(oc->_clk);
> +			clk_disable_unprepare(oc->_clk);
>  
>  	r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
>  

omap_dss_reset gets used by hwmod/omap_device, right?  Does the reset
path ever get called in an interrupt context?  If so clk_prepare might
sleep, which is bad.

snip

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..b46ae17 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -693,7 +693,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
>  	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
>  
>  	if (oh->_clk)
> -		clk_enable(oh->_clk);
> +		clk_prepare_enable(oh->_clk);
>  

The same question above applies to basically all of the hwmod function
changes below.  I don't know if runtime pm invokes these in an interrupt
context or not, but it is something to think about.

Regards,
Mike
