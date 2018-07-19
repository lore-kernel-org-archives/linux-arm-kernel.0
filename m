From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 19 Jul 2018 18:37:54 +0200
Subject: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
In-Reply-To: <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
Message-ID: <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -1310,7 +1308,6 @@ static int xadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	int irq = platform_get_irq(pdev, 0);
>  
>  	iio_device_unregister(indio_dev);
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> @@ -1318,7 +1315,6 @@ static int xadc_remove(struct platform_device *pdev)
>  		iio_trigger_free(xadc->convst_trigger);
>  		iio_triggered_buffer_cleanup(indio_dev);
>  	}
> -	free_irq(irq, indio_dev);

This opens up a race condition. The IRQ needs to be freed before any of
these other things below the free_irq() are executed.

>  	clk_disable_unprepare(xadc->clk);
>  	cancel_delayed_work(&xadc->zynq_unmask_work);
>  	kfree(xadc->data);
> 
