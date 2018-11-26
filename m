From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 26 Nov 2018 16:26:37 +0100
Subject: [PATCH v3 4/6] DEV: CLK: add function to check the using clock
 name of driver.
In-Reply-To: <20181125162118.GA5358@arx-s1>
References: <20181125162118.GA5358@arx-s1>
Message-ID: <20181126152637.GB19710@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 12:21:18AM +0800, Hao Zhang wrote:
> In some situation we want to check clock whether is we want
> and after the driver been probed use to change different clock source.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/clk/clk.c            | 6 ++++++
>  include/linux/clk-provider.h | 1 +
>  2 files changed, 7 insertions(+)

This doesn't seem right. If you're going to change to to a different
clock source anyway, why would you even want to know what it was set
before that? Isn't that completely irrelevant?

But if you really need this, perhaps a combination of clk_get() and
clk_is_match() would be a better approach? Perhaps best to let Mike
and Stephen share their feelings about this kind of API.

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d31055a..3d2c2cd 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3466,6 +3466,12 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
>  	return hw == data;
>  }
>  
> +bool devm_clk_name_match(struct clk *clk, const char *string)
> +{
> +	return match_string(&clk->con_id, 1, string) == 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_name_match);

Also, there's nothing about this that would be device-managed, so the
devm_ prefix on the function name is misleading.

>  /**
>   * devm_clk_unregister - resource managed clk_unregister()
>   * @clk: clock to unregister
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 08b1aa7..5cd2eed 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -764,6 +764,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
>  int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
>  int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
>  
> +bool devm_clk_name_match(struct clk *clk, const char *string);
>  void clk_unregister(struct clk *clk);
>  void devm_clk_unregister(struct device *dev, struct clk *clk);

You use this from clock consumers, so clk-provider.h is not the right
place for it. Also, you'll want to add a dummy implementation for the
case where CONFIG_COMMON_CLK is not set.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/5b082cc3/attachment.sig>
