From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Oct 2013 22:05:02 +0100
Subject: [PATCH v6 0/5] clk: clock deregistration support
In-Reply-To: <52420664.2040604@gmail.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <52420664.2040604@gmail.com>
Message-ID: <13429728.zDYQ5qS5ur@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
> On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
> > This patch series implements clock deregistration in the common clock
> > framework. Comparing to v5 it only includes further corrections of NULL
> > clock handling.
> 
> [...]
> 
> >    clk: Provide not locked variant of of_clk_get_from_provider()
> >    clkdev: Fix race condition in clock lookup from device tree
> >    clk: Add common __clk_get(), __clk_put() implementations
> >    clk: Assign module owner of a clock being registered
> >    clk: Implement clk_unregister
> 
> Hi Mike, Russell,
> 
> Would you have any further comments/suggestions on this series ?
> 
> I have inspected all callers of clk_register() and all should be fine
> with regards to dereferencing dev->driver. The first argument to this
> function is either NULL or clk_register() is being called in drivers'
> probe() callback, which ensures dev->driver won't change due to holding
> dev->mutex.
> 
> The only issue I found might be at the omap3isp driver, which provides
> clock to its sub-drivers and takes reference on the sub-driver modules.
> When sub-driver calls clk_get() all modules would get locked in memory,
> due to circular reference. One solution to that could be to pass NULL
> struct device pointer, as in the below patch.
> 
> ---------8<------------------
>  From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Date: Thu, 19 Sep 2013 23:52:04 +0200
> Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>   drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
>   drivers/media/platform/omap3isp/isp.h |    1 +
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/isp.c
> b/drivers/media/platform/omap3isp/isp.c
> index df3a0ec..d7f3c98 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
>   	struct clk_init_data init;
>   	unsigned int i;
> 
> +	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i)
> +		isp->xclks[i] = ERR_PTR(-EINVAL);

I don't think you've compile-tested this :-)

> +
>   	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
>   		struct isp_xclk *xclk = &isp->xclks[i];
> -		struct clk *clk;
> 
>   		xclk->isp = isp;
>   		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
> @@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)
> 
>   		xclk->hw.init = &init;
> 
> -		clk = devm_clk_register(isp->dev, &xclk->hw);
> -		if (IS_ERR(clk))
> -			return PTR_ERR(clk);
> +		xclk->clk = clk_register(NULL, &xclk->hw);
> +		if (IS_ERR(xclk->clk))
> +			return PTR_ERR(xclk->clk);

This doesn't introduce any regression in the sense that it will trade a 
problem for another one, so I'm fine with it in the short. Could you add a 
small comment above the clk_register() call to explain why the first argument 
is NULL ?

> 
>   		if (pdata->xclks[i].con_id == NULL &&
>   		    pdata->xclks[i].dev_id == NULL)
> @@ -320,7 +322,7 @@ static int isp_xclk_init(struct isp_device *isp)
> 
>   		xclk->lookup->con_id = pdata->xclks[i].con_id;
>   		xclk->lookup->dev_id = pdata->xclks[i].dev_id;
> -		xclk->lookup->clk = clk;
> +		xclk->lookup->clk = xclk->clk;
> 
>   		clkdev_add(xclk->lookup);
>   	}
> @@ -335,6 +337,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
>   	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
>   		struct isp_xclk *xclk = &isp->xclks[i];
> 
> +		if (!IS_ERR(xclk->clk))
> +			clk_unregister(xclk->clk);
> +
>   		if (xclk->lookup)
>   			clkdev_drop(xclk->lookup);
>   	}
> diff --git a/drivers/media/platform/omap3isp/isp.h
> b/drivers/media/platform/omap3isp/isp.h
> index cd3eff4..1498f2b 100644
> --- a/drivers/media/platform/omap3isp/isp.h
> +++ b/drivers/media/platform/omap3isp/isp.h
> @@ -135,6 +135,7 @@ struct isp_xclk {
>   	struct isp_device *isp;
>   	struct clk_hw hw;
>   	struct clk_lookup *lookup;
> +	struct clk *clk;
>   	enum isp_xclk_id id;
> 
>   	spinlock_t lock;	/* Protects enabled and divider */

-- 
Regards,

Laurent Pinchart
