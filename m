From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jul 2017 15:47:13 -0700
Subject: [PATCH v2 2/5] clk: Add clk_hw_get_clk() helper API to be used
 by clk providers
In-Reply-To: <1500526099-9935-3-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-3-git-send-email-rnayak@codeaurora.org>
Message-ID: <20170727224713.GP2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Rajendra Nayak wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fc58c52..c9bbfb3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -186,6 +186,45 @@ const char *clk_hw_get_name(const struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_name);
>  
> +struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *dev_id,
> +			   const char *con_id)
> +{
> +	return __clk_create_clk(hw, dev_id, con_id);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_clk);
> +
> +void clk_hw_put_clk(struct clk *clk)
> +{
> +	__clk_free_clk(clk);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_put_clk);

Isn't this just clk_put()? Not sure why we need this API.

> +
> +static void devm_clk_hw_put(struct device *dev, void *res)
> +{
> +	clk_hw_put_clk(*(struct clk **)res);
> +}

Same comment.

> +
> +struct clk *devm_clk_hw_get_clk(struct device *dev, struct clk_hw *hw,
> +				const char *con_id)
> +{
> +	struct clk **ptr, *clk;
> +
> +	ptr = devres_alloc(devm_clk_hw_put, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk = clk_hw_get_clk(hw, dev_name(dev), con_id);
> +	if (!IS_ERR(clk)) {
> +		*ptr = clk;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_hw_get_clk);

Hm.. ok. Wasn't expecting us to need this API, but I guess it is
needed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
