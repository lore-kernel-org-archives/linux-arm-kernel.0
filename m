From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 21 Feb 2017 12:55:39 +0100
Subject: [PATCH v2] iio: adc: xilinx: Fix error handling
In-Reply-To: <20170221063400.2984-1-christophe.jaillet@wanadoo.fr>
References: <20170221063400.2984-1-christophe.jaillet@wanadoo.fr>
Message-ID: <2c05b3bd-b5b4-e322-5d92-cd1c65d84ff5@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2017 07:34 AM, Christophe JAILLET wrote:
> Reorder error handling labels in order to match the way resources have
> been allocated.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> v2: update goto label if 'xadc->ops->setup()' fails
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0a6beb3d99cb..515b91963db5 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1206,11 +1206,11 @@ static int xadc_probe(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(xadc->clk);
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, irq);
>  	if (ret)
> -		goto err_free_samplerate_trigger;
> +		goto err_clk_disable_unprepare;
>  
>  	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
>  			dev_name(&pdev->dev), indio_dev);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
> @@ -1268,6 +1268,8 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  err_free_irq:
>  	free_irq(irq, indio_dev);
> +err_clk_disable_unprepare:
> +	clk_disable_unprepare(xadc->clk);
>  err_free_samplerate_trigger:
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>  		iio_trigger_free(xadc->samplerate_trigger);
> @@ -1277,8 +1279,6 @@ static int xadc_probe(struct platform_device *pdev)
>  err_triggered_buffer_cleanup:
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>  		iio_triggered_buffer_cleanup(indio_dev);
> -err_clk_disable_unprepare:
> -	clk_disable_unprepare(xadc->clk);
>  err_device_free:
>  	kfree(indio_dev->channels);
>  
> 
