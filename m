From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 3 Nov 2011 18:43:08 +0900
Subject: [PATCH] ARM: SAMSUNG: Add clk enable/disable of pwm
In-Reply-To: <019301cc9a08$17c69d50$4753d7f0$%kim@samsung.com>
References: <1319505701-9784-1-git-send-email-jy0922.shim@samsung.com>
	<012701cc99cc$300dca50$90295ef0$%kim@samsung.com>
	<4EB1FB58.9050503@samsung.com>
	<018e01cc99fc$bb4d5ec0$31e81c40$%kim@samsung.com>
	<4EB24886.8080002@samsung.com>
	<CAH9JG2XFALdd_JVSQW4rjCDCgLL9sgf_GVurVDoGJa-SwXmB5Q@mail.gmail.com>
	<CAH9JG2X9dXe2cG6qvqM6GuTuC6xc0wBYSsvba=zbbmQD7BqYXg@mail.gmail.com>
	<019301cc9a08$17c69d50$4753d7f0$%kim@samsung.com>
Message-ID: <CAH9JG2VdHqjFgVEun7J+FjgfRwnrQY=_Eh-3s8fbVBRCyJtn+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/3/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On 11/3/11, Kyungmin Park <kyungmin.park@samsung.com> wrote:
>> > On 11/3/11, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
>> >> 11/03/2011 04:46 PM, Kukjin Kim ? ?:
>> >>> Joonyoung Shim wrote:
>> >>>> 11/03/2011 10:59 AM, Kukjin Kim ? ?:
>> >>>>> Joonyoung Shim wrote:
>> >>>>>> PWM timers use pclk("timers" clk) as parent clk. If this pclk is
>> >>>>>> the
>> >>>>>> disabled state when PWM driver is probed, then it causes wrong read
>> >>>>>> and
>> >>>>>> write operation about registers of PWM.
>> >>>>>>
>> >>>>>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> >>>>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> >>>>>> ---
>> >>>>>>    arch/arm/plat-samsung/pwm.c |    7 +++++++
>> >>>>>>    1 files changed, 7 insertions(+), 0 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/arch/arm/plat-samsung/pwm.c
>> >>>>>> b/arch/arm/plat-samsung/pwm.c
>> >>>>>> index f37457c..dc1185d 100644
>> >>>>>> --- a/arch/arm/plat-samsung/pwm.c
>> >>>>>> +++ b/arch/arm/plat-samsung/pwm.c
>> >>>>>> @@ -299,6 +299,9 @@ static int s3c_pwm_probe(struct platform_device
>> >>>>>> *pdev)
>> >>>>>>    		goto err_clk_tin;
>> >>>>>>    	}
>> >>>>>>
>> >>>>>> +	clk_enable(pwm->clk);
>> >>>>>> +	clk_enable(pwm->clk_div);
>> >>>>>> +
>> >>>>>>    	local_irq_save(flags);
>> >>>>>>
>> >>>>>>    	tcon = __raw_readl(S3C2410_TCON);
>> >>>>>> @@ -326,6 +329,8 @@ static int s3c_pwm_probe(struct platform_device
>> >>>>>> *pdev)
>> >>>>>>    	return 0;
>> >>>>>>
>> >>>>>>     err_clk_tdiv:
>> >>>>>> +	clk_disable(pwm->clk_div);
>> >>>>>> +	clk_disable(pwm->clk);
>> >>>>>>    	clk_put(pwm->clk_div);
>> >>>>>>
>> >>>>>>     err_clk_tin:
>> >>>>>> @@ -340,6 +345,8 @@ static int __devexit s3c_pwm_remove(struct
>> >>>>>> platform_device *pdev)
>> >>>>>>    {
>> >>>>>>    	struct pwm_device *pwm = platform_get_drvdata(pdev);
>> >>>>>>
>> >>>>>> +	clk_disable(pwm->clk_div);
>> >>>>>> +	clk_disable(pwm->clk);
>> >>>>>>    	clk_put(pwm->clk_div);
>> >>>>>>    	clk_put(pwm->clk);
>> >>>>>>    	kfree(pwm);
>> >>>>>> --
>> >>>>>> 1.7.5.4
>> >>>>> Well, I wonder when this is needed. I think it should be enabled
>> >>>>> during
>> >>>>> kernel booting...
>> >>>> The exynos4 machine using just timer turns on "timer" clock in the
>> >>>> past,
>> >>>> but "timer" clock is disable state when boot since MCT is used. MCT
>> >>>> doesn't control "timer" clock.
>> >>>>
>> >>>> I think pwm driver should control(enable/disable) using clocks
>> >>>> regardless of their parents clock.
>> >>>>
>> >>> I mean, why that is disabled when kernel boot...
>> >>>
>> >>
>> >> Please see arch/arm/mach-exynos4/clock.c
>> >> There is "timers' clock in the clk init_clocks_off[].
>> One more, Don't assume some clocks are enabled at bootloader. user can
>> use any bootloader and any configuration.
>>
> Kyungmin,
> NO! I didn't. Just I thought your bootloader disables the clock and why it
> is needed.

As you don't unaware the power consumption. you don't care the clock gating.
You think this clock disable is meaningless but the basic idea of PM
is disable the clock and power domain and use it only enable during
use

See your team product kernel codes. why they are register the unused
clock at there and implement the clock gating and runtime pm not at
mainline.
>
> Anyway, Joonyoung,
> How about following? And it seems enough...
> --
> diff --git a/arch/arm/plat-samsung/pwm-clock.c
> b/arch/arm/plat-samsung/pwm-clock.c
> index a35ff3b..37a159b 100644
> --- a/arch/arm/plat-samsung/pwm-clock.c
> +++ b/arch/arm/plat-samsung/pwm-clock.c
> @@ -449,6 +449,8 @@ __init void s3c_pwmclk_init(void)
>  		return;
>  	}
>
> +	clk_enable(clk_timers);
> +
>  	for (clk = 0; clk < ARRAY_SIZE(clk_timer_scaler); clk++)
>  		clk_timer_scaler[clk].parent = clk_timers;
>
> --
> Or needs separate clk_enable like following?
>
> diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
> index f37457c..7a77e36 100644
> --- a/arch/arm/plat-samsung/pwm.c
> +++ b/arch/arm/plat-samsung/pwm.c
> @@ -292,6 +292,8 @@ static int s3c_pwm_probe(struct platform_device *pdev)
>  		goto err_alloc;
>  	}
>
> +	clk_enable(pwm->clk);
> +
>  	pwm->clk_div = clk_get(dev, "pwm-tdiv");
>  	if (IS_ERR(pwm->clk_div)) {
>  		dev_err(dev, "failed to get pwm tdiv clk\n");
> @@ -299,6 +301,8 @@ static int s3c_pwm_probe(struct platform_device *pdev)
>  		goto err_clk_tin;
>  	}
>
> +	clk_enable(pwm->clk_div);
> +
>  	local_irq_save(flags);
>
>  	tcon = __raw_readl(S3C2410_TCON);
> @@ -326,9 +330,11 @@ static int s3c_pwm_probe(struct platform_device *pdev)
>  	return 0;
>
>  err_clk_tdiv:
> +	clk_disable(pwm->clk_div);
>  	clk_put(pwm->clk_div);
>
>  err_clk_tin:
> +	clk_disable(pwm->clk);
>  	clk_put(pwm->clk);
>
>  err_alloc:
> --
>
> BTW, I think this is not really needed for this merge window because the
> pwm.c is used for only s3c24xx and as you know, it doesn't matter because of
> arch/arm/plat-samsung/time.c. And if required, this can be fixed during -rc.
Did you see the dev-pwm.c? and dev-backlight.c?
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
