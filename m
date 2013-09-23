From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 23 Sep 2013 17:30:18 +0200
Subject: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
In-Reply-To: <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
Message-ID: <21056.24202.312851.105281@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Juergen Beisert writes:
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index a08c173..00b61ac 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -35,6 +35,7 @@
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/clk.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -134,6 +135,8 @@ struct mxs_lradc {
>  	void __iomem		*base;
>  	int			irq[13];
>  
> +	struct clk		*clk;
> +
>  	uint32_t		*buffer;
>  	struct iio_trigger	*trig;
>  
> @@ -928,6 +931,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);
>  
> +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> +	clk_prepare_enable(lradc->clk);
> +
Wouldn't it make sense to enable the clock only when the device is
opened to save power while not actually in use?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
