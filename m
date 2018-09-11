From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 11 Sep 2018 19:32:26 +0800
Subject: [PATCH 1/3] rtc: mt6397: fix possible race condition
In-Reply-To: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com>
Message-ID: <1536665546.25102.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-09-09 at 22:38 +0200, Alexandre Belloni wrote:
> The IRQ is requested before the struct rtc is allocated and registered, but
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before requesting the IRQ.
> 
> Cc: Eddie Huang <eddie.huang@mediatek.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 385f8303bb41..e9a25ec4d434 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -332,6 +332,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rtc);
>  
> +	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
>  	ret = request_threaded_irq(rtc->irq, NULL,
>  				   mtk_rtc_irq_handler_thread,
>  				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> @@ -344,11 +348,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 1);
>  
> -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> -					   &mtk_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtc_dev)) {
> +	rtc->rtc_dev->ops = &mtk_rtc_ops;
> +
> +	ret = rtc_register_device(rtc->rtc_dev);
> +	if (ret) {
>  		dev_err(&pdev->dev, "register rtc device failed\n");
> -		ret = PTR_ERR(rtc->rtc_dev);
>  		goto out_free_irq;
>  	}
>  
> @@ -365,7 +369,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
>  {
>  	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
>  
> -	rtc_device_unregister(rtc->rtc_dev);
>  	free_irq(rtc->irq, rtc->rtc_dev);
>  	irq_dispose_mapping(rtc->irq);
>  

Thanks

Acked-by: Eddie Huang <eddie.huang@mediatek.com>
