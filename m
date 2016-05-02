From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 3 May 2016 00:56:31 +0900
Subject: [PATCH v2,
 RESEND] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <20160104083629.15239.29413@quark.deferred.io>
References: <1451298058-28910-1-git-send-email-yamada.masahiro@socionext.com>
 <20151231013511.21505.59601@quark.deferred.io>
 <CAK7LNARHuogHfsSyXVkkoakOq61xfhYJOa08cC7tvvn1kdPRoQ@mail.gmail.com>
 <20160104083629.15239.29413@quark.deferred.io>
Message-ID: <CAK7LNASf918a3gp2oFc=Y-=TiOpgWrg0cQikdK7nn35DVZ=VSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

I am back after long pause.

2016-01-04 17:36 GMT+09:00 Michael Turquette <mturquette@baylibre.com>:
> Quoting Masahiro Yamada (2016-01-01 17:26:05)
>> Hi Michael,
>>
>>
>> 2015-12-31 10:35 GMT+09:00 Michael Turquette <mturquette@baylibre.com>:
>> > Hello Yamada-san,
>> >
>> > Quoting Masahiro Yamada (2015-12-28 02:20:58)
>> >> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
>> >> new file mode 100644
>> >> index 0000000..7606f27
>> >> --- /dev/null
>> >> +++ b/drivers/clk/uniphier/Kconfig
>> >> @@ -0,0 +1,35 @@
>> >> +menuconfig CLK_UNIPHIER
>> >> +       bool "Clock drivers for UniPhier SoCs"
>> >> +       depends on ARCH_UNIPHIER
>> >
>> > Might want to make the above line:
>> >
>> >         depends on ARCH_UNIPHIER || COMPILE_TEST
>> >
>> >> +       depends on OF
>> >> +       default y
>> >> +       help
>> >> +         Supports clock drivers for UniPhier SoCs.
>> >
>> > Why menuconfig? Can we make this a non-visible config option selected by
>> > the UniPhier platform?
>>
>> Yes, I can do that if you like.
>
> Thanks, and the other questions I asked in my previous reply are
> relevant here: can you make these into platform_drivers and compile them
> as loadable modules? That would be ideal.


I noticed a conflict between two of your requests.

If I have CLK_UNIPHIER selected by ARCH_UNIPHIER,
it is impossible to add "depends on COMPILE_TEST".


I see some drivers that have "depends on ARCH_<SOC> || COMPILE_TEST"
as follows:


config COMMON_CLK_HI6220
        bool "Hi6220 Clock Driver"
        depends on ARCH_HISI || COMPILE_TEST

config COMMON_CLK_QCOM
        tristate "Support for Qualcomm's clock controllers"
        depends on OF
        depends on ARCH_QCOM || COMPILE_TEST


I think the style above works fine with COMPILE_TEST.


But, if we make it a non-visible config option selected by ARCH,
how can COMPILE_TEST select it?


config COMMON_CLK_HI6220
        bool
        prompt "Hi6220 Clock Driver" if COMPILE_TEST

should work, but looks a bit tricky.   Hmm...






>> >
>> > Where can I find the DT binding description and DTS for this clock
>> > controller?
>
> Any update on the above question? I wasn't able to find the DT binding
> description anywhere.


OK, will add a binding document in the next version.



>>
>> So, I implemented uniphier_clk_update_parent_name()
>> to convert the clock-names into the parent clock name.
>> In this case, this function takes "input" and converts it into "for-bar123".
>>
>>
>> Is there any good idea to solve this problem?
>
> Well, using the clock-output-names DT property in conjunction with
> of_clk_get_parent_name() solves this for you in a common way. However I
> would like to get rid of clock-output-names in the future. In general
> I'm working slowy to reduce the reliance on clock string names, but it
> is a long-term side project.


I do not intend to add clock-output-names in my device trees.

of_clk_get_parent_name() tries best to take the parent name via
of_clk_get_from_provider() if clock-output-names is missing.
I wanted to use this feature.



> How bad is it for you to hard-code the string names in your driver? Are
> the foo, bar and baz clock providers all on the same chip?

No problem, but not 100% happy.

If we allow to hardcode the parent name strings,
"clock-names" and "clocks" properties are useless in clock-cascading.

Like IRQ controllers can be cascaded by "interrupts" chain,
I want to describe the hierarchy of clock-providers
without hard-coding the detail of parent.



-- 
Best Regards
Masahiro Yamada
