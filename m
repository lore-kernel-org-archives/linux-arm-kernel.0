From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 27 Apr 2018 13:53:16 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
Message-ID: <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>>
>> We have platforms out there which still use both board files and
>> device tree. They are still comercially supported and are not going
>> anywhere anytime soon. Some of these platforms are being actively
>> maintained and cleaned-up. An example is the DaVinci platform: David
>> has recently converted all the SoCs and boards to using the common
>> clock framework. I'm cleaning up some other parts too.
>>
>> The problem with the legacy board code is that a lot of things that
>> should be platform drivers ended up in arch/arm/mach-*. We're now
>> slowly moving this code to drivers/ but some initialization code
>> (timers, critical clocks, irqs) needs to be called early in the boot
>> sequence.
>
> Right, and that's very good work.
>
>> When you're saying that we already have all the OF_DECLARE macros, it
>> seems to me that you're forgetting that we also want to keep
>> supporting the board files. So without the early platform drivers we
>> need to use a mix of OF_DECLARE and handcrafted initialization in
>> arch/arm/mach-* since we can't call platform_device_register() that
>> early. This blocks us from completely moving the should-be-driver code
>> to drivers/, because these drivers *need* to support both cases.
>
> The OF_DECLARE_* functions were initially added as a way to
> remove board files that just consist of callbacks into early
> initialization for some subsystems. As long as you still have
> board files and you are looking for a way to reuse code between
> OF_DECLARE_* functions and board files, why not just leave
> those functions globally visible and call them from the non-DT
> board files?
>
>> The main problem with OF_DECLARE is that although we have
>> corresponding device nodes, we never actually register any real linux
>> devices. If we add to this the fact that current early platform
>> drivers implementation is broken (for reasons I mentioned in the cover
>> letter) the support gets really messy, since we can have up to three
>> entry points to the driver's code. Other issues come to mind as well:
>> if we're using OF_DECLARE we can't benefit from devm* routines.
>
> Right, the devm_* problem has come up before.
>
>> My aim is to provide a clean, robust and generic way of probing
>> certain devices early and then converting them to actual platform
>> devices when we're advanced enough into the boot sequence. If we
>> merged such a framework, we could work towards removing both the
>> previous early platform devices (in favor of the new mechanism) and
>> maybe even deprecating and replacing OF_DECLARE(), since we could
>> simply early probe the DT drivers. Personally I see OF_DECLARE as a
>> bigger hack than early devices.
>>
>> My patch tries to address exactly the use cases we're facing - for
>> example by providing means to probe devices twice (early and late) and
>> to check the state we're at in order for users to be able to just do
>> the critical initialization early on and then continue with regular
>> stuff later.
>
> Maybe the problem is reusing the name and some of the code from
> an existing functionality that we've been trying to get rid of.
>

I'm not reusing the name - in fact I set the prefix to earlydev_
exactly in order to not confuse anyone. I'm also not reusing any code
in the second series.

> If what you want to do is completely different from the existing
> early_platform implementation, how about starting by moving that
> out of drivers/base/platform.c into something under arch/sh/
> and renaming it to something with an sh_ prefix.
>

Yes, this is a good idea, but what about the sh-specific drivers that
rely on it? Is including headers from arch/ in driver code still an
accepted practice?

> Let's just leave the non-DT part out of it by making it sh specific.
> Then we can come up with improvements to the current
> platform_device handling for DT based platforms that you can
> use on DT-based davinci to replace what currently happens on
> board-file based davinci systems, without mixing up those
> two code paths too much in the base driver support.
>

I don't see why we wouldn't want to unify these two cases. The best
solution to me seems having only one entry point into the driver code
- the probe() function stored in platform_driver - whether we're
probing it from DT, platform data, ACPI or early boot code.

Best regards,
Bartosz Golaszewski
