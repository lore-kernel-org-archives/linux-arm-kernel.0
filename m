From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 12 Oct 2012 17:58:17 +0300
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
Message-ID: <1350053897.10584.172.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 20:01 +0530, Viresh Kumar wrote:

> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c

> @@ -1179,6 +1179,53 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }
>  
> +bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> +{
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +	static struct dw_dma *last_dw;
> +	static char *last_bus_id;
> +	int i = -1;
> +
> +	/*
> +	 * dmaengine framework calls this routine for all channels of all dma
> +	 * controller, until true is returned. If 'param' bus_id is not
> +	 * registered with a dma controller (dw), then there is no need of
> +	 * running below function for all channels of dw.
> +	 *
> +	 * This block of code does this by saving the parameters of last
> +	 * failure. If dw and param are same, i.e. trying on same dw with
> +	 * different channel, return false.
> +	 */
> +	if (last_dw) {
> +		if ((last_bus_id == param) && (last_dw == dw))
> +			return false;
> +	}
Just came to my mind.
dw can't be NULL, can't it?
Then
if (last_dw) {
...
}
is unneeded.

Please, check twice my thought because it's a Friday evening.

> @@ -1462,6 +1509,91 @@ static void dw_dma_off(struct dw_dma *dw)
>  		dw->chan[i].initialized = false;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct dw_dma_platform_data *
> +__devinit dw_dma_parse_dt(struct platform_device *pdev)
> +{
> +	struct device_node *sn, *cn, *np = pdev->dev.of_node;
> +	struct dw_dma_platform_data *pdata;
> +	struct dw_dma_slave *sd;
> +	u32 val, arr[4];
Let me weekend to think about naming. I really can't offer anything else
right now.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
