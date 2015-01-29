From: varkabhadram@gmail.com (Varka Bhadram)
Date: Thu, 29 Jan 2015 19:56:40 +0530
Subject: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
In-Reply-To: <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
Message-ID: <54CA4320.4030607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> This is a driver for the imx25 ADC/TSC module. It controls the
> touchscreen conversion queue and creates a touchscreen input device.
> The driver currently only supports 4 wire touchscreens. The driver uses
> a simple conversion queue of precharge, touch detection, X measurement,
> Y measurement, precharge and another touch detection.
>
> This driver uses the regmap from the parent to setup some touch specific
> settings in the core driver and setup a idle configuration with touch
> detection.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Dmitry Torokhov <dtor@vmware.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   drivers/input/touchscreen/Kconfig         |   6 +
>   drivers/input/touchscreen/Makefile        |   1 +
>   drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++++++++++++
>   3 files changed, 594 insertions(+)
>   create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
>
(...)

> +	ret = request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_thread,
> +				   IRQF_ONESHOT, pdev->name, priv);

We can use devres API for request_thread_irq()...

> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");
> +		goto err_clk_unprepare;
> +	}
> +
> +	ret = mx25_tcq_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to init tcq\n");
> +		goto error_free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(priv->irq, priv);

This is not required if we use devres API

> +err_clk_unprepare:
> +	clk_disable_unprepare(priv->clk);
> +	return ret;
> +}
> +
> +static int mx25_tcq_remove(struct platform_device *pdev)
> +{
> +	struct mx25_tcq_priv *priv = platform_get_drvdata(pdev);
> +
> +	free_irq(priv->irq, priv);

This also..


-- 
Regards,
Varka Bhadram.
