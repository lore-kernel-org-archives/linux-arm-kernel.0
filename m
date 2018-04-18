From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 18 Apr 2018 10:50:29 +0200
Subject: [PATCH v6 6/7] remoteproc/davinci: use the reset framework
In-Reply-To: <20180417173038.25510-7-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-7-brgl@bgdev.pl>
Message-ID: <1524041429.3528.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-17 at 19:30 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch to using the reset framework instead of handcoded reset routines
> we used so far.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[...]
> @@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(dsp_clk);
>  	}
>  
> +	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(dsp_reset)) {
> +		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
> +			dev_err(dev, "unable to get reset control: %ld\n",
> +				PTR_ERR(dsp_reset));
> +
> +		return PTR_ERR(dsp_reset);
> +	}
> +
>  	if (dev->of_node) {
>  		ret = of_reserved_mem_device_init(dev);
>  		if (ret) {
[...]
> @@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>  	 * held in reset at the time it is called.

Given this requirement, devm_reset_control_get_exclusive above is the
correct choice.

>  	 */
> -	ret = davinci_clk_reset_assert(drproc->dsp_clk);
> +	ret = reset_control_assert(dsp_reset);

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
