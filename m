From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Nov 2016 13:26:00 -0800
Subject: [PATCH v4] clkdev: add devm_of_clk_get()
In-Reply-To: <87zikjw08i.wl%kuninori.morimoto.gx@renesas.com>
References: <87zikjw08i.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161129212600.GH6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
> This patch adds it. It is implemeted in clk-devres.c to share
> devm_clk_release().

Please add an explanation of why we want this sort of API. The
example you gave for audio sound card is useful. We're not going
to remember 5 months from now why we did something, so we should
put that here instead of digging through mailing list archives.

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 8f57154..2449b25 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -53,3 +53,24 @@ void devm_clk_put(struct device *dev, struct clk *clk)
>  	WARN_ON(ret);
>  }
>  EXPORT_SYMBOL(devm_clk_put);
> +
> +struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index)

Please call this devm_get_clk_from_child() instead. Also, replace
the index argument with a string called con_id. Then call
of_clk_get_by_name() instead of of_clk_get().

> +{
> +	struct clk **ptr, *clk;
> +
> +	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk = of_clk_get(np, index);
> +	if (!IS_ERR(clk)) {
> +		*ptr = clk;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL(devm_of_clk_get);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 123c027..7f50c5f 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -17,8 +17,9 @@
>  #include <linux/notifier.h>
>  
>  struct device;
> -
>  struct clk;
> +struct device_node;
> +struct of_phandle_args;
>  
>  /**
>   * DOC: clk notifier callback types
> @@ -249,6 +250,21 @@ static inline void clk_unprepare(struct clk *clk)
>  struct clk *devm_clk_get(struct device *dev, const char *id);
>  
>  /**
> + * devm_clk_get - lookup and obtain a managed reference to a clock producer.

That doesn't even match the name of the function.

> + * @dev: device for clock "consumer"
> + * @np: pointer to clock consumer node
> + * @index: clock index
> + *
> + * This function parses the clocks, and uses them to look up the
> + * struct clk from the registered list of clock providers by using
> + * @np and @index.
> + *
> + * The clock will automatically be freed when the device is unbound
> + * from the bus.
> + */
> +struct clk *devm_of_clk_get(struct device *dev, struct device_node *np, int index);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
