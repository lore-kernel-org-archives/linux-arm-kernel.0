From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 7 May 2018 08:52:34 +0530
Subject: [PATCH -next] gpio: Fix return value check in owl_gpio_probe()
In-Reply-To: <1525657224-88189-1-git-send-email-weiyongjun1@huawei.com>
References: <1525657224-88189-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180507032233.wwi2nib5x2stpsyg@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

Thanks for the patch.

On Mon, May 07, 2018 at 01:40:24AM +0000, Wei Yongjun wrote:
> In case of error, the function of_iomap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: d3654d38809c ("gpio: Add gpio driver for Actions OWL S900 SoC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpio/gpio-owl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-owl.c b/drivers/gpio/gpio-owl.c
> index 3546362..f35e80f 100644
> --- a/drivers/gpio/gpio-owl.c
> +++ b/drivers/gpio/gpio-owl.c
> @@ -128,8 +128,8 @@ static int owl_gpio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	gpio->base = of_iomap(dev->of_node, 0);
> -	if (IS_ERR(gpio->base))
> -		return PTR_ERR(gpio->base);
> +	if (!gpio->base)
> +		return -ENOMEM;
> 

Agree with the check here. But the return value should be -ENXIO?

Regards,
Mani

>  	/*
>  	 * Get the number of gpio's for this bank. If none specified,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
