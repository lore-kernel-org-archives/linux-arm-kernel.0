From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Apr 2016 22:01:19 +0200
Subject: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
In-Reply-To: <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <570FF70F.3000501@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 05:48 PM, Stefan Wahren wrote:
> After successful touchscreen registration the input device was
> never freed. So fix this issue by using devm_input_allocate_device().
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/iio/adc/mxs-lradc.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 33051b8..0576953 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1109,12 +1109,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  {
>  	struct input_dev *input;
>  	struct device *dev = lradc->dev;
> -	int ret;
>  
>  	if (!lradc->use_touchscreen)
>  		return 0;
>  
> -	input = input_allocate_device();
> +	input = devm_input_allocate_device(dev);
>  	if (!input)
>  		return -ENOMEM;
>  
> @@ -1134,11 +1133,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  
>  	lradc->ts_input = input;
>  	input_set_drvdata(input, lradc);
> -	ret = input_register_device(input);
> -	if (ret)
> -		input_free_device(lradc->ts_input);
>  
> -	return ret;
> +	return input_register_device(input);
>  }
>  
>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> 

Nice find.

Looks like at91_adc.c and exynos_adc.c suffer from the exact same issue.
The leak looks a bit more severe on exynos even, exynos_adc_ts_init()
could use a proper fail path. Do you want to send patches or shall I ?

-- 
Best regards,
Marek Vasut
