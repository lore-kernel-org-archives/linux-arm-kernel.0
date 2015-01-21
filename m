From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Jan 2015 16:46:55 -0800
Subject: [PATCH v10 3/3] clk: Add rate constraints to clocks
In-Reply-To: <1421760306-6301-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1421760306-6301-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421760306-6301-4-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150121004655.GG27202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's looking fairly close. Thanks for keeping up with the review
comments.

On 01/20, Tomeu Vizoso wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e867d6a..f241e27 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2143,6 +2280,10 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
>  	else
>  		clk->owner = NULL;
>  
> +	INIT_HLIST_HEAD(&clk->clks);
> +
> +	hw->clk = __clk_create_clk(hw, NULL, NULL);
> +
>  	ret = __clk_init(dev, hw->clk);
>  	if (ret)
>  		return ERR_PTR(ret);

Don't we need to __clk_free_clk() here too?

> @@ -2151,6 +2292,19 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(__clk_register);
>  
> +static void __clk_free_clk(struct clk *clk)
> +{
> +	struct clk_core *core = clk->core;
> +
> +	clk_prepare_lock();
> +	hlist_del(&clk->child_node);
> +	clk_prepare_unlock();
> +
> +	kfree(clk);
> +
> +	clk_core_set_rate(core, core->req_rate);

Is it safe to call this during clock registration? I hope that it
will just bail out and do nothing because core->rate ==
core->req_rate. Maybe we can avoid this given my next comment
below.

> +}
> +
>  /**
>   * clk_register - allocate a new clock, register it and return an opaque cookie
>   * @dev: device that is registering this clock
> @@ -2210,12 +2364,14 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>  		}
>  	}
>  
> +	INIT_HLIST_HEAD(&clk->clks);
> +
>  	hw->clk = __clk_create_clk(hw, NULL, NULL);
>  	ret = __clk_init(dev, hw->clk);
>  	if (!ret)
>  		return hw->clk;
>  
> -	kfree(hw->clk);
> +	__clk_free_clk(hw->clk);
>  fail_parent_names_copy:
>  	while (--i >= 0)
>  		kfree(clk->parent_names[i]);
> @@ -2421,7 +2577,7 @@ void __clk_put(struct clk *clk)
>  		return;
>  
>  	clk_core_put(clk->core);
> -	kfree(clk);
> +	__clk_free_clk(clk);

This doesn't look right. First we drop the core reference here
with clk_core_put() and then we call __clk_free_clk() which will
go and call clk_core_set_rate() on the clk->core which may or may
not exist anymore. I'd think we want to do these steps:

 1. Unlink clk from clks list
 2. Recalculate rate and set if changed
 3. Drop kref on core with clk_core_put()
 4. kfree the clk

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
