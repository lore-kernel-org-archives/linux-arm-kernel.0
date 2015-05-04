From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 4 May 2015 16:16:10 +0800
Subject: [PATCH RFC v1 3/5] clk: remove unneeded __clk_enable and
 __clk_disable
In-Reply-To: <20150430220548.GA31047@codeaurora.org>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-4-git-send-email-aisheng.dong@freescale.com>
 <55427DDE.4090907@codeaurora.org> <20150430220548.GA31047@codeaurora.org>
Message-ID: <20150504081609.GB4082@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 03:05:48PM -0700, Stephen Boyd wrote:
> On 04/30, Stephen Boyd wrote:
> > On 04/15/15 07:26, Dong Aisheng wrote:
> > > The only thing __clk_enable/__clk_disable does is NULL pointer checking
> > > of clk except calling clk_core_{enable|disable} which is already handled
> > > by clk_core_{enable|disable}.
> > > So remove this unneeded function.
> > >
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> > > ---
> > 
> > No. You can call clk_enable() and clk_disable() with NULL and it should
> > be a no-op. With this change it would cause a NULL pointer exception.
> > 
> 
> Here's the proper patch. I'll leave you as author.
> 

Got your point.
Thanks for the change.

Regards
Dong Aisheng

> ---8<---
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0227ac3d5b1a..e45255226ffa 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1023,14 +1023,6 @@ static void clk_core_disable(struct clk_core *core)
>  	clk_core_disable(core->parent);
>  }
>  
> -static void __clk_disable(struct clk *clk)
> -{
> -	if (!clk)
> -		return;
> -
> -	clk_core_disable(clk->core);
> -}
> -
>  /**
>   * clk_disable - gate a clock
>   * @clk: the clk being gated
> @@ -1051,7 +1043,7 @@ void clk_disable(struct clk *clk)
>  		return;
>  
>  	flags = clk_enable_lock();
> -	__clk_disable(clk);
> +	clk_core_disable(clk->core);
>  	clk_enable_unlock(flags);
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
> @@ -1089,14 +1081,6 @@ static int clk_core_enable(struct clk_core *core)
>  	return 0;
>  }
>  
> -static int __clk_enable(struct clk *clk)
> -{
> -	if (!clk)
> -		return 0;
> -
> -	return clk_core_enable(clk->core);
> -}
> -
>  /**
>   * clk_enable - ungate a clock
>   * @clk: the clk being ungated
> @@ -1115,8 +1099,11 @@ int clk_enable(struct clk *clk)
>  	unsigned long flags;
>  	int ret;
>  
> +	if (!clk)
> +		return 0;
> +
>  	flags = clk_enable_lock();
> -	ret = __clk_enable(clk);
> +	ret = clk_core_enable(clk->core);
>  	clk_enable_unlock(flags);
>  
>  	return ret;
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
