From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 01 Aug 2010 11:42:20 +0300
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <4C55336C.7070300@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/10 07:22, Marek Vasut wrote:
> The wakealarm capability was incorrectly set after the RTC was registered, which
> resulted into the sysfs node not being created.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>   

Same problem exists on on pxa3xx/cm-x300 and I suppose
on many other pxa based systems which use rtc-pxa and not
rtc-sa1100 (in which device_init_wakeup() indeed called before
the rtc_device_register()).

This patch makes /sys/class/rtc/rtc0/wakealarm visible and thus
solves the problem for cm-x300

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  drivers/rtc/rtc-pxa.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
> index e9c6fa0..d76f187 100644
> --- a/drivers/rtc/rtc-pxa.c
> +++ b/drivers/rtc/rtc-pxa.c
> @@ -403,6 +403,8 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
>  
>  	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
>  
> +	device_init_wakeup(dev, 1);
> +
>  	pxa_rtc->rtc = rtc_device_register("pxa-rtc", &pdev->dev, &pxa_rtc_ops,
>  					   THIS_MODULE);
>  	ret = PTR_ERR(pxa_rtc->rtc);
> @@ -411,8 +413,6 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
>  		goto err_rtc_reg;
>  	}
>  
> -	device_init_wakeup(dev, 1);
> -
>  	return 0;
>  
>  err_rtc_reg:
>   

-- 
Regards,
Igor.
