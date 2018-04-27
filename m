From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 16:48:00 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
 <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
Message-ID: <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 4:05 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2018-04-27 14:40 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:

>> For timer-ti-dm, it seems like a leftover from old times that can
>> be removed. The other four are shared between arch/sh and
>> arch/arm/mach-shmobile and already have some #ifdef
>> to handle those two cases.
>>
>
> I'm also seeing that we also call early_platform_cleanup() from
> platform_bus_init(). Any ideas for this one?

My first idea would be to call it immediately after registering all
devices and drivers. It looks like it's only needed to make all
devm_ allocations persistent by removing them from the list,
so we have to call early_platform_cleanup() before getting
to the real platform code, but it could be done much earlier
if we want to, at least after both setup_arch() and sh_late_time_init()
are complete.

>> I'd rather keep those separate and would prefer not to have
>> that many different ways of getting there instead. DT and
>> board files can already share most of the code through the
>> use of platform_device, especially when you start using
>> device properties instead of platform_data, and the other
>> two are rare corner cases and ideally left that way.
>>
>> The early boot code is always special and instead of making
>> it easier to use, we should focus on using it as little as
>> possible: every line of code that we call before even
>> initializing timers and consoles means it gets harder to
>> debug when something goes wrong.
>>
>
> I'm afraid I don't quite understand your reasoning. I fully agree that
> devices that need to be initialized that early are a rare corner case.
> We should limit any such uses to the absolute minimum. But when we do
> need to go this way, we should do it right. Having a unified mechanism
> for early devices will allow maintainers to enforce good practices
> (using resources for register mapping, devres, reusing driver code for
> reading/writing to registers). Having initialization code in machine
> code will make everybody use different APIs and duplicate solutions. I
> normally assume that code consolidation is always good.
>
> If we add a way for DT-based platform devices to be probed early - it
> would be based on platform device/driver structures anyway. Why would
> we even want to not convert the board code into a simple call to
> early_platform_device_register() if we'll already offer this API for
> device tree?

I think we first need to define what we really want to achieve here.
It sounds like you still want to recreate a lot of what early_platform
devices do, but it seems more important to me to add the missing
functionality to the OF_DECLARE infrastructure. The most
important pieces that seem to be missing are solved by finding
a way to provide a platform_device pointer with the following
properties:

- allow being passed into dev_print()
- allow using the pointer as a token for devres unwinding
- access to device_private data that remains persistent
  until real a platform_driver gets loaded

That can probably be done as an extension to the current
infrastructure.

However, I'd be very cautious about the resource portion:
filling the platform resources (registers, irqs, ...) the way
we do for regular devices is much harder and can introduce
additional (or circular) dependencies on other devices.
OTOH, not using those resources means you have a hard
time passing information from board files.

          Arnd
