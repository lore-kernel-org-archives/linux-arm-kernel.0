From: david@lechnology.com (David Lechner)
Date: Mon, 12 Feb 2018 14:51:57 -0600
Subject: [PATCH] clk: don't call __of_clk_get_by_name() unnecessarily from
 clk_get()
In-Reply-To: <20180212142439.15885-1-brgl@bgdev.pl>
References: <20180212142439.15885-1-brgl@bgdev.pl>
Message-ID: <36b4b8a0-0254-c6fa-c84f-ceab20c326ad@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 08:24 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The way this function is implemented caused some confusion when
> converting the TI DaVinci platform to using the common clock framework.
> 
> Current kernel supports booting DaVinci boards both in device tree as
> well as legacy, board-file mode. In the latter, we always end up
> calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
> returns -ENOENT.
> 
> It was not obvious at first glance how clk_get(dev, NULL) will work in
> board-file mode since we always call __of_clk_get_by_name(). Let's make
> it clearer by checking if of_node is NULL and skipping right to
> clk_get_sys().
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clk/clkdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 7513411140b6..f394e8964909 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -199,7 +199,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>   	const char *dev_id = dev ? dev_name(dev) : NULL;
>   	struct clk *clk;
>   
> -	if (dev) {
> +	if (dev && dev->of_node) {
>   		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
>   		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
>   			return clk;
> 

Shouldn't you be sending this to the linux-clk mailing list and cc'ing
the clock maintainers?

FWIW, it seems pretty clear to me that if we are using a board file
then we should expect clk_get_sys() to be called because there is
no device tree.
