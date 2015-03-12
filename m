From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 12 Mar 2015 09:02:24 +0000
Subject: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting the
 PWM
In-Reply-To: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150312090224.GC3314@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Feb 2015, Nicolas Ferre wrote:

> When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
> flag is not handled properly. It can lead to the PWM not being found.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 3a145a643e0d..6897f1c1bc73 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -274,6 +274,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
> +		ret = PTR_ERR(pb->pwm);
> +		if (ret == -EPROBE_DEFER)
> +			goto err_alloc;
> +
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy = true;
>  		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
