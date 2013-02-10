From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 10 Feb 2013 13:19:01 +0100
Subject: [PATCH v2 1/2] i2c-core: dt: Pick i2c bus number from i2c alias
 if present
In-Reply-To: <1358189602-24180-2-git-send-email-dianders@chromium.org>
References: <1357927027-4857-2-git-send-email-dianders@chromium.org>
 <1358189602-24180-1-git-send-email-dianders@chromium.org>
 <1358189602-24180-2-git-send-email-dianders@chromium.org>
Message-ID: <20130210121901.GA15546@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Mon, Jan 14, 2013 at 10:53:21AM -0800, Doug Anderson wrote:
> This allows you to get the equivalent functionality of
> i2c_add_numbered_adapter() with all data in the device tree and no
> special case code in your driver.  This is a common device tree
> technique.
> 
> For quick reference, the FDT syntax for using an alias to provide an
> ID looks like:
>   aliases {
>     i2c0 = &i2c_0;
>     i2c1 = &i2c_1;
>   };
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
> Changes in v2: None
> 
>  drivers/i2c/i2c-core.c |  105 +++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 77 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e388590..a60ed6d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -921,13 +921,81 @@ out_list:
>  }
>  
>  /**
> + * i2c_get_number_from_dt - get the adapter number based on dt alias
> + * @adap: the adapter to look at
> + *
> + * Check whether there's an alias in the FDT that gives an ID for this i2c
> + * device.  Use an alias like "i2c<nr>", like:
> + *   aliases {
> + *     i2c0 = &i2c_0;
> + *     i2c1 = &i2c_1;
> + *   };
> + *
> + * Returns the ID if found.  If no alias is found returns -1.
> + */
> +static int i2c_get_number_from_dt(struct i2c_adapter *adap)

i2c_get_id_from_dt()?

> +{
> +	struct device *dev = &adap->dev;
> +	int id;
> +
> +	if (!dev->of_node)
> +		return -1;

-ESOMETHING?

> +
> +	id = of_alias_get_id(dev->of_node, "i2c");
> +	if (id < 0)
> +		return -1;
> +	return id;

Simply 'return of_alias_get_id(...)'? Even more, since this function
boils down to calling of_alias_get_id only and is only used once, I'd
think we can implement that directly and drop this function. That
shouldn't hurt readability.

> +}
> +
> +/**
> + * _i2c_add_numbered_adapter - i2c_add_numbered_adapter where nr is never -1
> + * @adap: the adapter to register (with adap->nr initialized)
> + * Context: can sleep
> + *
> + * See i2c_add_numbered_adapter() for details.
> + */
> +static int _i2c_add_numbered_adapter(struct i2c_adapter *adap)

All other internal functions are prefixed with '__'.

> +{
> +	int	id;
> +	int	status;
> +
> +	/* Handled by wrappers */
> +	BUG_ON(adap->nr == -1);

Is that a reason to halt the kernel? WARN and bailing out would do IMO.

> +
> +	if (adap->nr & ~MAX_IDR_MASK)
> +		return -EINVAL;

Note the idr-cleanup series from Tejun Heo. Given that his series is
scheduled for v3.9, I'd like to have your patches on top of his.

Thanks,

   Wolfram
