From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 14:40:34 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
Message-ID: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
>> <bgolaszewski@baylibre.com> wrote:
>>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>> My patch tries to address exactly the use cases we're facing - for
>>> example by providing means to probe devices twice (early and late) and
>>> to check the state we're at in order for users to be able to just do
>>> the critical initialization early on and then continue with regular
>>> stuff later.
>>
>> Maybe the problem is reusing the name and some of the code from
>> an existing functionality that we've been trying to get rid of.
>>
>
> I'm not reusing the name - in fact I set the prefix to earlydev_
> exactly in order to not confuse anyone. I'm also not reusing any code
> in the second series.

Ok.

>> If what you want to do is completely different from the existing
>> early_platform implementation, how about starting by moving that
>> out of drivers/base/platform.c into something under arch/sh/
>> and renaming it to something with an sh_ prefix.
>>
>
> Yes, this is a good idea, but what about the sh-specific drivers that
> rely on it? Is including headers from arch/ in driver code still an
> accepted practice?

I think it's fine here, since we're just move it out of the way and
there are only very few drivers using it:

drivers/clocksource/sh_cmt.c:early_platform_init("earlytimer",
&sh_cmt_device_driver);
drivers/clocksource/sh_mtu2.c:early_platform_init("earlytimer",
&sh_mtu2_device_driver);
drivers/clocksource/sh_tmu.c:early_platform_init("earlytimer",
&sh_tmu_device_driver);
drivers/clocksource/timer-ti-dm.c:early_platform_init("earlytimer",
&omap_dm_timer_driver);
drivers/tty/serial/sh-sci.c:early_platform_init_buffer("earlyprintk",
&sci_driver,

For timer-ti-dm, it seems like a leftover from old times that can
be removed. The other four are shared between arch/sh and
arch/arm/mach-shmobile and already have some #ifdef
to handle those two cases.

>> Let's just leave the non-DT part out of it by making it sh specific.
>> Then we can come up with improvements to the current
>> platform_device handling for DT based platforms that you can
>> use on DT-based davinci to replace what currently happens on
>> board-file based davinci systems, without mixing up those
>> two code paths too much in the base driver support.
>
> I don't see why we wouldn't want to unify these two cases. The best
> solution to me seems having only one entry point into the driver code
> - the probe() function stored in platform_driver - whether we're
> probing it from DT, platform data, ACPI or early boot code.

I'd rather keep those separate and would prefer not to have
that many different ways of getting there instead. DT and
board files can already share most of the code through the
use of platform_device, especially when you start using
device properties instead of platform_data, and the other
two are rare corner cases and ideally left that way.

The early boot code is always special and instead of making
it easier to use, we should focus on using it as little as
possible: every line of code that we call before even
initializing timers and consoles means it gets harder to
debug when something goes wrong.

      Arnd
