From: robherring2@gmail.com (Rob Herring)
Date: Sun, 15 Jul 2012 10:10:59 -0500
Subject: [PATCH] clk: fix clk_get on of_clk_get_by_name return check
In-Reply-To: <1342361384-21299-1-git-send-email-shawn.guo@linaro.org>
References: <1342361384-21299-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <5002DD83.2020808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2012 09:09 AM, Shawn Guo wrote:
> The commit 766e6a4 (clk: add DT clock binding support) plugs device
> tree clk lookup of_clk_get_by_name into clk_get, and fall on non-DT
> lookup clk_get_sys if DT lookup fails.
> 
> The return check on of_clk_get_by_name takes (clk != NULL) as a
> successful DT lookup.  But it's not the case.  For any system that
> does not define clk lookup in device tree, ERR_PTR(-ENOENT) will be
> returned, and consequently, all the client drivers calling clk_get
> in their probe functions will fail to probe with error code -ENOENT
> returned.
> 
> Fix the issue by checking of_clk_get_by_name return with !IS_ERR(clk).
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks Shawn.

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/clk/clkdev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 20649b3..69085e0 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -157,7 +157,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  
>  	if (dev) {
>  		clk = of_clk_get_by_name(dev->of_node, con_id);
> -		if (clk && __clk_get(clk))
> +		if (!IS_ERR(clk) && __clk_get(clk))
>  			return clk;
>  	}
>  
> 
