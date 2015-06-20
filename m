From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 20 Jun 2015 02:43:54 +0200
Subject: [rtc-linux] [PATCH-v2] rtc: 88pm80x: add device tree support
In-Reply-To: <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434567488-6477-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150620004354.GY27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/06/2015 at 00:28:06 +0530, Vaibhav Hiremath wrote :
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (pdata == NULL)
> -		dev_warn(&pdev->dev, "No platform data!\n");
> +	if (!pdata && !node) {
> +		dev_err(&pdev->dev,
> +			"pm80x-rtc requires platform data or of_node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pdata) {
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

I had troubles to follow the rtc_wakeup initialization cleanup but it
seems OK. However, I'm wondering why you are adding DT support as this
will always be probed from the MFD driver which pass the platform_data
and avoids that allocation.

> +		if (!pdata) {
> +			dev_err(&pdev->dev, "failed to allocate memory\n");
> +			return -ENOMEM;
> +		}
> +	}
>  
>  	info =
>  	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
> @@ -327,11 +336,8 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
>  	regmap_update_bits(info->map, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
>  			   PM800_RTC1_USE_XO);
>  
> -	if (pm80x_pdata) {
> -		pdata = pm80x_pdata->rtc;
> -		if (pdata)
> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
> -	}
> +	/* remeber whether this power up is caused by PMIC RTC or not */
remember -^


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
