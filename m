From: linuxzsc@gmail.com (Richard Zhao)
Date: Sun, 24 Apr 2011 17:45:57 +0800
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110424094557.GA2310@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
On Wed, Apr 20, 2011 at 04:07:37PM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> only compile tested so far.
> 
> Best regards
> Uwe
> 
>  drivers/clk/clk.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h |    8 ++++++++
>  2 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 264c809..7627815 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -14,10 +14,23 @@
>  int clk_prepare(struct clk *clk)
>  {
>  	int ret = 0;
> +	struct clk *parent = ERR_PTR(-ENOSYS);
>  
>  	if (!clk)
>  		return 0;
>  
> +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {
> +		parent = clk_get_parent(clk);
> +
> +		if (!IS_ERR(parent)) {
> +			ret = clk_prepare(parent);
> +			if (ret)
> +				return ret;
> +		} else if (PTR_ERR(parent) != -ENOSYS)
> +			/* -ENOSYS means no parent and is OK */
> +			return PTR_ERR(parent);
> +	}
Is this supposed to be in prepare_lock? If prepare_count > 1, we need do nothing.
Other parent operations need to be in lock protect too.

Thanks
Richard
> +
>  	mutex_lock(&clk->prepare_lock);
>  	if (clk->prepare_count == 0 && clk->ops->prepare)
>  		ret = clk->ops->prepare(clk);
> @@ -26,6 +39,9 @@ int clk_prepare(struct clk *clk)
>  		clk->prepare_count++;
>  	mutex_unlock(&clk->prepare_lock);
>  
> +	if (ret && !IS_ERR(parent))
> +		clk_unprepare(parent);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_prepare);
> @@ -45,6 +61,12 @@ void clk_unprepare(struct clk *clk)
>  	}
>  
>  	mutex_unlock(&clk->prepare_lock);
> +
> +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {
> +		struct clk *parent = clk_get_parent(clk);
> +		if (!IS_ERR(parent))
> +			clk_unprepare(parent);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(clk_unprepare);
>  
> @@ -52,10 +74,22 @@ int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +	struct clk *parent = ERR_PTR(-ENOSYS);
>  
>  	if (!clk)
>  		return 0;
>  
> +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {
> +		parent = clk_get_parent(clk);
> +		if (!IS_ERR(parent)) {
> +			ret = clk_enable(parent);
> +			if (ret)
> +				return ret;
> +		} else if (PTR_ERR(parent) != -ENOSYS)
> +			/* -ENOSYS means no parent and is OK */
> +			return PTR_ERR(parent);
> +	}
> +
>  	WARN_ON(clk->prepare_count == 0);
>  
>  	spin_lock_irqsave(&clk->enable_lock, flags);
> @@ -66,6 +100,9 @@ int clk_enable(struct clk *clk)
>  		clk->enable_count++;
>  	spin_unlock_irqrestore(&clk->enable_lock, flags);
>  
> +	if (ret && !IS_ERR(parent))
> +		clk_disable(parent);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
> @@ -85,6 +122,12 @@ void clk_disable(struct clk *clk)
>  		clk->ops->disable(clk);
>  
>  	spin_unlock_irqrestore(&clk->enable_lock, flags);
> +
> +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {
> +		struct clk *parent = clk_get_parent(clk);
> +		if (!IS_ERR(parent))
> +			clk_disable(parent);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
>  
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index d2f0db0..125e525 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -62,6 +62,11 @@ struct clk {
>  	.prepare_lock	= __MUTEX_INITIALIZER(name.prepare_lock),	\
>  }
>  
> +/* bit definitions for struct clk_ops.flags */
> +#define CLK_OPS_GENERIC_PARENT	1	/* automatically handle parent in
> +					   enable, disable, prepare and
> +					   unprepare functions */
> +
>  /**
>   * struct clk_ops -  Callback operations for clocks; these are to be provided
>   * by the clock implementation, and will be called by drivers through the clk_*
> @@ -91,6 +96,8 @@ struct clk {
>   * @put:	Called by the core clock code when a devices driver releases a
>   *		clock via clk_put(). Optional.
>   *
> + * @flags:	see above for possible values.
> + *
>   * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
>   * implementations to split any work between atomic (enable) and sleepable
>   * (prepare) contexts.  If a clock requires sleeping code to be turned on, this
> @@ -119,6 +126,7 @@ struct clk_ops {
>  	int		(*set_rate)(struct clk *, unsigned long);
>  	int		(*set_parent)(struct clk *, struct clk *);
>  	struct clk *	(*get_parent)(struct clk *);
> +	unsigned int	flags;
>  };
>  
>  /**
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
