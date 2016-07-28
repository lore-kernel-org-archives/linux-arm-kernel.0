From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 28 Jul 2016 19:29:43 +0900
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1469698980.12835.18.camel@pengutronix.de>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <1469698980.12835.18.camel@pengutronix.de>
Message-ID: <CAK7LNAS82QLZg40qjnkftES_Cd5AeyTAEdw3_Tms+8W6cK3QKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,


2016-07-28 18:43 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Samstag, den 23.07.2016, 20:22 +0900 schrieb Masahiro Yamada:
>> Hi.
>>
>>
>> Now the reset subsystem provides
>> a bunch of reset_control_get variants.
>>
>> I am still wondering why we need to have _optional ones.
>>
>> As far as I see, the difference is WARN_ON(1)
>> when CONFIG_RESET_CONTROLLER is not defined.
>>
>>
>>
>> [1] When the reset is mandatory,
>> the code of the reset consumer is probably like follows:
>>
>>   rst = devm_reset_control_get(dev, NULL);
>>   if (IS_ERR(rst)) {
>>           dev_err(dev, "failed to get reset\n");
>>           return PTR_ERR(rst);
>>   }
>>
>>   ret = reset_control_deassert(rst);
>>   if (ret) {
>>           dev_err(dev, "failed to deassert reset\n");
>>           return ret;
>>   }
>>
>>    ...
>>
>>
>>
>> [2] When the reset is optional,
>>   the code should be something like follows:
>>
>>    rst = devm_reset_control_get(dev, NULL);
>>    if (ERR_PTR(rst) == -EPROBE_DEFER)
>>            return -EPROBE_DEFER;
>>
>>    /* deassert reset if it is available */
>>    if (!IS_ERR(rst)) {
>>            ret = reset_control_deassert(rst);
>>            if (ret) {
>>                   dev_err(dev, "failed to deassert reset\n");
>>                   return ret;
>>            }
>>     }
>>
>>
>>
>>
>> What I mean is, we can write a driver in either way
>> without using the _optional one.
>>
>> No need to call WARN_ON(1).
>>
>>
>> What does _optional buy us?
>
> It will complain loudly with a backtrace if a driver requests a
> non-optional reset on a kernel/platform with the reset framework
> disabled.

Right, but this situation will be solved with my suggestion.


>> One more thing.
>> WARN_ON(1) is only useful on run-time,
>> but run-time test is more expensive than compile-time test.
>>
>> If a driver really needs reset control,
>> it should not be complied without CONFIG_RESET_CONTROLLER.
>> So, the driver should have "depends on RESET_CONTROLLER" in Kconfig.
>
> If we do that, we can't compile test those drivers anymore in
> configurations without RESET_CONTROLLER enabled.
> [...]
>> I want to deprecate _optional variants in the following steps:
>>
>> [1] Add "depends on RESET_CONTROLLER" to drivers
>>     for which reset_control is mandatory.
>>
>>     We can find those driver easily by grepping
>>     the reference to non-optional reset_control_get().
>
> Since we have the stubs, the RESET_CONTROLLER dependency is only at
> runtime, not at build time.
>
> I think Arnd wanted to move this in the opposite direction and remove
> the configurable RESET_CONTROLLER symbol. Maybe we should let all
> drivers that currently request non-optional resets have:
>         depends on (ARCH_HAS_)RESET_CONTROLLER || COMPILE_TEST
> ?

No, I do not think we need to do that.

We should do
          depends on ARCH_<SOC_NAME> || COMPILE_TEST
because SOC_NAME is not a real dependency for the driver.


but,

      depends on RESET_CONTROLLER

is a genuine dependency, so it should not be OR'ed with COMPILE_TEST.




Currently, ARCH_HAS_RESET_CONTROLLER is only used to decide the default value
of RESET_CONTROLLER:


menuconfig RESET_CONTROLLER
        bool "Reset Controller Support"
        default y if ARCH_HAS_RESET_CONTROLLER
        help
          Generic Reset Controller support.



So, RESET_CONTROLLER can be enabled without any dependency,
i.e., COMPILE_TEST will be fine.



However, I think the following makes more sense:


menuconfig RESET_CONTROLLER
        bool "Reset Controller Support"
        depends on (ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST)
        default y
        help
          Generic Reset Controller support.





-- 
Best Regards
Masahiro Yamada
