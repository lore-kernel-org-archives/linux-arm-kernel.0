From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 09:26:37 +0200
Subject: [RFC work-in-progress 0/7] of: platform: use early platform
 routines instead of OF_DECLARE
In-Reply-To: <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
References: <20180423183814.20615-1-brgl@bgdev.pl>
 <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
Message-ID: <CAMRc=Md0vKTtYXOWAHv7mEZUqBWG7U4oF26xMwSL_u_wPZn9rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-23 23:38 GMT+02:00 David Lechner <david@lechnology.com>:
> FYI: It looks like the CC for Stephen and Arnd was messed up, so I
> fixed.
>

Thanks!

> On 04/23/2018 01:38 PM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Hi David, Sekhar,
>>
>> since platform devices are generally considered more desirable than
>> CLK_OF_DECLARE, TIMER_OF_DECLARE etc. and we need to figure out how to
>> handle the clocks that need to be initialized early in the boot
>> process on DaVinci, I thought that I could give the early_platform
>> mechanism a try.
>>
>> This API is only used on one architecture (sh) but seems to work just
>> fine on ARM. It allows to register early platform drivers and then
>> probe them early in the boot process. So far only machine code is
>> supported but with a bit of hacking I was able to probe a DT device.
>>
>> This is a very dirty and far-from-upstream proof of concept that allows
>> to probe the (so far dummy) davinci timer platform device during the
>> call to init_time (from machine_desc).
>>
>> The idea is to have a special compatible fallback string: "earlydev"
>> that similarily to "syscon" would be added to device nodes that need
>> early probing. Then we'd call the of_early_platform_populate()
>> function that would find all compatible nodes and populate them
>> long before all the "normal" nodes.
>
>
> FWIW, "earlydev" sounds like a driver implementation detail, so not
> something that should be included in the device tree. We only need
> this because Linux needs a clocksource early on, but that doesn't
> mean that all device tree users need to do the same.
>
> I'm sure it makes things easier for a proof of concept though. :-)
>

We already have "syscon" which too is more an implementation detail
than HW description. I should have probably Cc'ed Rob Herring. I'll do
it with a more polished version I should have today.

>>
>> This would allow us to make the davinci timer a normal platform device
>> and possibly also probe the psc and pll drivers earlier than we do now.
>>
>> The early platform API even allows us to check if we're being probed
>> early in probe() so we can possibly probe the driver twice if needed:
>> only doing the critical stuff first and then completing the process
>> later.
>>
>> If you think this is a good idea, I would like to continue on that
>> and eventually make it an alternative to OF_DECLARE macros.
>>
>> For a quick conversion of the davinci timer to a platform driver
>> I image we'd need to use platform data lookup that would be passed
>> to of_early_platform_populate().
>
>
> On the surface, it certainly sounds like a good idea to me. Do we have
> access to struct device of the platform device when using this early
> platform device? I remember when I was working on the clock drivers, I
> tried registering a platform device in the init_time callback but the
> kernel crashed because kobj stuff was not initialized yet. I'm guessing
> that the early platform device somehow works around this.
>

Yes, it seems we do. I was getting kobj stack dumps too when trying to
register a device using just platform_device_register() and it went
away as soon as I switched to early platform.

Best regards,
Bartosz Golaszewski
