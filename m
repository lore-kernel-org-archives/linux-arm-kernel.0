From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2016 09:14:56 +0000
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <8737icayac.wl%kuninori.morimoto.gx@renesas.com>
References: <8737icayac.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161128091456.GR14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 06:56:52AM +0000, Kuninori Morimoto wrote:
> Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
> This patch adds it. This is based on devm_clk_get()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Please put this in drivers/clk/clk-devres.c, where you'll find that
we have devm_clk_release() which is identical to your
devm_of_clk_release().  It'll also not need the dummy definition of
devm_of_clk_get().

Thanks.

> ---
> v1 -> v2
> 
>  - update git log
> 
>  drivers/clk/clkdev.c | 26 ++++++++++++++++++++++++++
>  include/linux/clk.h  |  7 +++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 89cc700..93a613b 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -55,6 +55,32 @@ struct clk *of_clk_get(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL(of_clk_get);
>  
> +static void devm_of_clk_release(struct device *dev, void *res)
> +{
> +	clk_put(*(struct clk **)res);
> +}
> +
> +struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index)
> +{
> +	struct clk **ptr, *clk;
> +
> +	ptr = devres_alloc(devm_of_clk_release, sizeof(*ptr), GFP_KERNEL);
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
> +
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>  					const char *dev_id,
>  					const char *name)
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index a89ba4e..33cd540 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -502,6 +502,8 @@ struct of_phandle_args;
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
> +struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
> @@ -509,6 +511,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
>  	return ERR_PTR(-ENOENT);
>  }
> +static inline struct clk *devm_of_clk_get(struct device *dev,
> +			    struct device_node *np, int index)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>  					     const char *name)
>  {
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
