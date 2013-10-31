From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 31 Oct 2013 12:00:53 -0700
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
In-Reply-To: <CAOesGMj2hVOc_NV6UfJpx7399puasY_zgpHDmPj0pd1VC_Ou6A@mail.gmail.com>
References: <1383238174-14650-1-git-send-email-olof@lixom.net>
 <CAOMZO5C4+K+RfHOpex7EwLObPV4Uy8YmjdVx2HPv36ZGAKeSZA@mail.gmail.com>
 <CAOesGMgU6qJMpXi5DGe7=XbObiWh8icNFRhZv_9ot+KZMNcTnw@mail.gmail.com>
 <CAOMZO5BsMuN3bZuK+06X6ukAEmRyZDpvoKXdhatNiG61x_GZsA@mail.gmail.com>
 <CAOesGMj2hVOc_NV6UfJpx7399puasY_zgpHDmPj0pd1VC_Ou6A@mail.gmail.com>
Message-ID: <CAPtuhTgmgionMHoG0g5ntnODAwnubWBnjuuxH3RBP236Jh_jBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 11:54 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Oct 31, 2013 at 11:47 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Thu, Oct 31, 2013 at 3:07 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Thu, Oct 31, 2013 at 10:05 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>>> Hi Olof,
>>>>
>>>> On Thu, Oct 31, 2013 at 2:49 PM, Olof Johansson <olof@lixom.net> wrote:
>>>>> Fixes a panic at boot on many platforms. For example, on imx (wandboard),
>>>>> I get:
>>>>
>>>> With this patch applied console messages appears on 20131031, but it
>>>> seems we still have other issues:
>>>
>>>
>>> Yeah, there's lots of badness in last night's -next. :(
>>
>> If I apply this change:
>>
>> --- a/drivers/clk/clkdev.c
>> +++ b/drivers/clk/clkdev.c
>> @@ -44,7 +44,7 @@ struct clk *of_clk_get(struct device_node *np, int index)
>>         of_clk_lock();
>>         clk = __of_clk_get_from_provider(&clkspec);
>>
>> -       if (!IS_ERR(clk) && !__clk_get(clk))
>> +       if (IS_ERR(clk) && !__clk_get(clk))
>>                 clk = ERR_PTR(-ENOENT);
>
> That doesn't look right, it'll call __clk_get() with an error code as the clock.
>
> Mike, seems like reverting back the clock tree to a known good state
> (same as yesterday) and re-target 3.14 for the latest changes is a
> suitable course of action at this time in the release cycle.

I think removal of the MSM series and clock deregistration stuff is
prudent. The Tegra pull request (with updated fixes) and EFM32 driver
should be OK.

I'll cull out the questionable bits and force update.

Regards,
Mike

>
>
> -Olof
