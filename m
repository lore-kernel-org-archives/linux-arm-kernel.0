From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Sep 2012 22:25:05 +0800
Subject: [PATCH v2 1/4] [RFC] clk: new locking scheme for reentrancy
In-Reply-To: <1345074214-17531-2-git-send-email-mturquette@linaro.org>
References: <1345074214-17531-1-git-send-email-mturquette@linaro.org>
 <1345074214-17531-2-git-send-email-mturquette@linaro.org>
Message-ID: <20120904142502.GL2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 04:43:31PM -0700, Mike Turquette wrote:
> +void __clk_unprepare(struct clk *clk, struct clk *top)
> +{
>  	if (clk->ops->unprepare)
>  		clk->ops->unprepare(clk->hw);
>  
> -	__clk_unprepare(clk->parent);
> +	if (clk != top)
> +		__clk_unprepare(clk->parent, top);
> +}

The __clk_unprepare does not match the __clk_prepare below in terms of
if we should call clk->ops->prepare/unprepare on top clock.

I have to change __clk_unprepare to something like the below to get
the series work on imx6q.

 void __clk_unprepare(struct clk *clk, struct clk *top)
 {
+       if (clk == top)
+               return;
+
        if (clk->ops->unprepare)
                clk->ops->unprepare(clk->hw);

-       if (clk != top)
-               __clk_unprepare(clk->parent, top);
+       __clk_unprepare(clk->parent, top);
 }

> +int __clk_prepare(struct clk *clk, struct clk *top)
> +{
> +	int ret = 0;
> +
> +	if (clk != top) {
> +		ret = __clk_prepare(clk->parent, top);
>  		if (ret)
>  			return ret;
>  
>  		if (clk->ops->prepare) {
>  			ret = clk->ops->prepare(clk->hw);
>  			if (ret) {
> -				__clk_unprepare(clk->parent);
> +				/* this is safe since clk != top */
> +				__clk_unprepare(clk->parent, top);
>  				return ret;
>  			}
>  		}
>  	}
>  
> -	clk->prepare_count++;
> -
>  	return 0;
>  }

-- 
Regards,
Shawn
