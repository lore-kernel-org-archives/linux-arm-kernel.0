From: marex@denx.de (Marek Vasut)
Date: Thu, 28 Mar 2013 12:22:21 +0100
Subject: [PATCH] iio: mxs-lradc: Do hardware initialization earlier
In-Reply-To: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201303281222.21285.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

> We need to initialize hardware before registering the touchscreen. Else,
> we end up setting registers in mxs_lradc_ts_open(), getting called just
> after registering the touchscreen with input_register_device() and by
> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
> correct configuration.
> 
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 55a459b..e927e3f 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -933,6 +933,9 @@ static int mxs_lradc_probe(struct platform_device
> *pdev)
> 
>  	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
> 
> +	/* Configure the hardware. */
> +	mxs_lradc_hw_init(lradc);
> +
>  	/* Check if touchscreen is enabled in DT. */
>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",

Isn't this too early? At least lradc->use_touchscreen is configured only after 
you call mxs_lradc_hw_init() in this case, while mxs_lradc_hw_init() uses it's 
value.

I think mxs_lradc_hw_init() shall be called just before mxs_lradc_ts_register().

Best regards,
Marek Vasut
