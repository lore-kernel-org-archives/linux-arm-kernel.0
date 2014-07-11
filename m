From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jul 2014 10:28:26 +0200
Subject: [PATCH] i2c: efm32: correct namespacing of location property
In-Reply-To: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140711082826.GJ11056@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
> index f7eccd682de9..5c4cf94527e3 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -370,7 +370,13 @@ static int efm32_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = of_property_read_u32(np, "efm32,location", &location);
> +
> +	ret = of_property_read_u32(np, "energymicro,location", &location);
> +
> +	if (!ret)
This must be "if (ret)". I noticed during testing but obviously forgot
to fixup before sending out. Should I resend?

Best regards
Uwe
> +		/* fall back to wrongly namespaced property */
> +		ret = of_property_read_u32(np, "efm32,location", &location);
> +
>  	if (!ret) {
>  		dev_dbg(&pdev->dev, "using location %u\n", location);
>  	} else {

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
