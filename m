From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 26 Jan 2016 13:55:14 +0900
Subject: [PATCH] drm/exynos: fix building without CONFIG_PM_SLEEP
In-Reply-To: <CAJKOXPdF_MYmysaQg=W7_6WzpCA=5auO6zLbvNYmCRqg+2L05Q@mail.gmail.com>
References: <9569056.LBRz4v8fSj@wuerfel>
 <CAJKOXPdF_MYmysaQg=W7_6WzpCA=5auO6zLbvNYmCRqg+2L05Q@mail.gmail.com>
Message-ID: <56A6FC32.9000801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2016? 01? 26? 08:40? Krzysztof Kozlowski ?(?) ? ?:
> 2015-11-18 0:08 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> The runtime PM operations use the suspend/resume functions
>> even when CONFIG_PM_SLEEP is not set, but this now fails
>> for the exynos DRM driver:
>>
>> exynos_mixer.c:1289:61: error: 'exynos_mixer_resume' undeclared here (not in a function)
>>   SET_RUNTIME_PM_OPS(exynos_mixer_suspend, exynos_mixer_resume, NULL)
>>
>> This removes the #ifdef and instead marks the functions as
>> __maybe_unused, which does the right thing in all cases and
>> also looks nicer.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes:   ("drm/exynos: add pm_runtime to Mixer")
> 
> Dear Inki,
> 
> Ping? On 4.5-rc1 this is still broken. Can you apply this for fixes
> for current rc-cycle?

Got it.

Thanks,
Inki Dae

> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Best regards,
> Krzysztof
> 
> 
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
>> index 7498c6e76a53..fcaf71df77c1 100644
>> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
>> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
>> @@ -1230,8 +1230,7 @@ static int mixer_remove(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int exynos_mixer_suspend(struct device *dev)
>> +static int __maybe_unused exynos_mixer_suspend(struct device *dev)
>>  {
>>         struct mixer_context *ctx = dev_get_drvdata(dev);
>>         struct mixer_resources *res = &ctx->mixer_res;
>> @@ -1247,7 +1246,7 @@ static int exynos_mixer_suspend(struct device *dev)
>>         return 0;
>>  }
>>
>> -static int exynos_mixer_resume(struct device *dev)
>> +static int __maybe_unused exynos_mixer_resume(struct device *dev)
>>  {
>>         struct mixer_context *ctx = dev_get_drvdata(dev);
>>         struct mixer_resources *res = &ctx->mixer_res;
>> @@ -1283,7 +1282,6 @@ static int exynos_mixer_resume(struct device *dev)
>>
>>         return 0;
>>  }
>> -#endif
>>
>>  static const struct dev_pm_ops exynos_mixer_pm_ops = {
>>         SET_RUNTIME_PM_OPS(exynos_mixer_suspend, exynos_mixer_resume, NULL)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
