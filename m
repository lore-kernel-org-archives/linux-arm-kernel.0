From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Feb 2018 16:29:12 +0000
Subject: [PATCH 1/8] clk: Add clk_bulk_alloc functions
In-Reply-To: <1519055046-2399-2-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
 <CGME20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c@eucas1p1.samsung.com>
 <1519055046-2399-2-git-send-email-m.purski@samsung.com>
Message-ID: <b67b5043-f5e5-826a-f0b8-f7cf722c61e6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

On 19/02/18 15:43, Maciej Purski wrote:
> When a driver is going to use clk_bulk_get() function, it has to
> initialize an array of clk_bulk_data, by filling its id fields.
> 
> Add a new function to the core, which dynamically allocates
> clk_bulk_data array and fills its id fields. Add clk_bulk_free()
> function, which frees the array allocated by clk_bulk_alloc() function.
> Add a managed version of clk_bulk_alloc().

Seeing how every subsequent patch ends up with the roughly this same stanza:

	x = devm_clk_bulk_alloc(dev, num, names);
	if (IS_ERR(x)
		return PTR_ERR(x);
	ret = devm_clk_bulk_get(dev, x, num);

I wonder if it might be better to simply implement:

	int devm_clk_bulk_alloc_get(dev, &x, num, names)

that does the whole lot in one go, and let drivers that want to do more 
fiddly things continue to open-code the allocation.

But perhaps that's an abstraction too far... I'm not all that familiar 
with the lie of the land here.

> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>   drivers/clk/clk-bulk.c   | 16 ++++++++++++
>   drivers/clk/clk-devres.c | 37 +++++++++++++++++++++++++---
>   include/linux/clk.h      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 113 insertions(+), 4 deletions(-)
> 

[...]
> @@ -598,6 +645,23 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>   
>   #else /* !CONFIG_HAVE_CLK */
>   
> +static inline struct clk_bulk_data *clk_bulk_alloc(int num_clks,
> +						   const char **clk_ids)
> +{
> +	return NULL;

Either way, is it intentional not returning an ERR_PTR() value in this 
case? Since NULL will pass an IS_ERR() check, it seems a bit fragile for 
an allocation call to apparently succeed when the whole API is 
configured out (and I believe introducing new uses of IS_ERR_OR_NULL() 
is in general strongly discouraged.)

Robin.

> +}
> +
> +static inline struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev,
> +							int num_clks,
> +							const char **clk_ids)
> +{
> +	return NULL;
> +}
> +
> +static inline void clk_bulk_free(struct clk_bulk_data *clks)
> +{
> +}
> +
>   static inline struct clk *clk_get(struct device *dev, const char *id)
>   {
>   	return NULL;
> 
