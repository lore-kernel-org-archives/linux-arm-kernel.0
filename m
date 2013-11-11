From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Mon, 11 Nov 2013 23:11:41 +0900
Subject: [PATCH 1/1] ARM: EXYNOS: Add default latency values for Device
 and Power Domain
In-Reply-To: <9546263.JaCWNRjo5C@flatron>
References: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org>
 <9546263.JaCWNRjo5C@flatron>
Message-ID: <CAKew6eUrtw7bTqo8tWD4JCwvCM0jRowSj=v4=dnqc5krPLpRWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +};
>> +
>>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>>  {
>>       struct exynos_pm_domain *pd;
>> @@ -83,7 +94,7 @@ static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
>>       dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
>>
>>       while (1) {
>> -             ret = pm_genpd_add_device(&pd->pd, dev);
>> +             ret = __pm_genpd_add_device(&pd->pd, dev, &dev_latencies);
>
> The double underscore prefix scares me a bit. Is this function really
> supposed to be used like this?
>

Moreover, it also seems little bit odd in the first place, to pass
dev_latencies(QoS timing parameters) when we are not using/providing
any governor for the genpd. QoS timing parameters have to be provided
to be used by governor. In our case since we are not using/providing
any governor yet, so it seems odd to provide QoS timing parameters. It
seems, here core pd code is giving unnecessary warning in our case,
since we are not providing governor(not interested in QoS). So IMO
warning should be fixed instead of just suppressing it by giving some
big values of timing parameters.


Regards,
Yadwinder

>>               if (ret != -EAGAIN)
>>                       break;
>>               cond_resched();
>> @@ -173,6 +184,8 @@ static __init int exynos4_pm_init_power_domain(void)
>>               pd->base = of_iomap(np, 0);
>>               pd->pd.power_off = exynos_pd_power_off;
>>               pd->pd.power_on = exynos_pd_power_on;
>> +             pd->pd.power_off_latency_ns = DEFAULT_PD_PWROFF_LATENCY_NS;
>> +             pd->pd.power_on_latency_ns = DEFAULT_PD_PWRON_LATENCY_NS;
>
> It might be worth to set up the latencies indeed, but wrong values can do
> more harm than good.
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
