From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 May 2018 23:11:14 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
Message-ID: <CAMuHMdU7b86fWAFaK6LQ0gHukJebc4fegUetHPCvu7ujdjSfRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 2:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
>>> <bgolaszewski@baylibre.com> wrote:
>>>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> My patch tries to address exactly the use cases we're facing - for
>>>> example by providing means to probe devices twice (early and late) and
>>>> to check the state we're at in order for users to be able to just do
>>>> the critical initialization early on and then continue with regular
>>>> stuff later.
>>>
>>> Maybe the problem is reusing the name and some of the code from
>>> an existing functionality that we've been trying to get rid of.
>>>
>>
>> I'm not reusing the name - in fact I set the prefix to earlydev_
>> exactly in order to not confuse anyone. I'm also not reusing any code
>> in the second series.
>
> Ok.
>
>>> If what you want to do is completely different from the existing
>>> early_platform implementation, how about starting by moving that
>>> out of drivers/base/platform.c into something under arch/sh/
>>> and renaming it to something with an sh_ prefix.
>>>
>>
>> Yes, this is a good idea, but what about the sh-specific drivers that
>> rely on it? Is including headers from arch/ in driver code still an
>> accepted practice?
>
> I think it's fine here, since we're just move it out of the way and
> there are only very few drivers using it:
>
> drivers/clocksource/sh_cmt.c:early_platform_init("earlytimer",
> &sh_cmt_device_driver);
> drivers/clocksource/sh_mtu2.c:early_platform_init("earlytimer",
> &sh_mtu2_device_driver);
> drivers/clocksource/sh_tmu.c:early_platform_init("earlytimer",
> &sh_tmu_device_driver);
> drivers/clocksource/timer-ti-dm.c:early_platform_init("earlytimer",
> &omap_dm_timer_driver);
> drivers/tty/serial/sh-sci.c:early_platform_init_buffer("earlyprintk",
> &sci_driver,
>
> For timer-ti-dm, it seems like a leftover from old times that can
> be removed. The other four are shared between arch/sh and
> arch/arm/mach-shmobile and already have some #ifdef
> to handle those two cases.

Sh-sci is also used on arm64, for R-Car Gen3 SoCs.
While the latter has CMT and TMU hardware blocks, so far we haven't enabled
support for it yet (just using the ARM arch timer is too convenient? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
