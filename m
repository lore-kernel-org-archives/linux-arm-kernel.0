From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 8 Sep 2015 15:32:32 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable USB Video Class support
In-Reply-To: <55EEDECA.4040407@samsung.com>
References: <1441662323-15468-1-git-send-email-javier@osg.samsung.com>
 <55EE9820.2010202@samsung.com> <55EE9F1A.9030703@osg.samsung.com>
 <55EEDECA.4040407@samsung.com>
Message-ID: <55EEE370.9040705@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/08/2015 03:12 PM, Krzysztof Kozlowski wrote:
> W dniu 08.09.2015 o 17:40, Javier Martinez Canillas pisze:
>> [adding Bartlomiej to cc]
>>
>> Hello Krzysztof,
>>
>> On 09/08/2015 10:11 AM, Krzysztof Kozlowski wrote:
>>> On 08.09.2015 06:45, Javier Martinez Canillas wrote:
>>>> The Exynos5420 Peach Pit and Exynos5800 Peach Pi boards have a built-in
>>>> Silicon Motion USB UVC WebCam. Enable support for the USB Video Class
>>>> driver and its needed media Kconfig symbols so the camera is supported.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>
>>>> ---
>>>>
>>>>  arch/arm/configs/exynos_defconfig | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>
>>> The patch itself looks good but now I wonder whether we are not putting
>>> to much stuff built-in. The exynos_defconfig does not replace the
>>> distribution distro. For a fully working board the distro should prepare
>>> it's own config.
>>>
>>
>> Agreed that exynos_defconfig is not meant to replace a distro config.
>>
>>> I understand that in this case the USB webcams are parts of device (like
>>> on all laptops)... a little bit similar as camera sensors on mobile
>>> phones. Yet on mobile phone usually the camera itself is part of SoC,
>>> only the sensor is external.
>>>
>>> Actually what we need is a kind of policy for exynos_defconfig - what
>>> should be inside as built-in and what as module?
>>>
>>
>> I had the same conversation with Bartlomiej before in [0] when I tried to
>> enable the SBS battery driver as module. I save you a click and quote him:
>>
>> "the current most popular use case for exynos_defconfig
>> (not multi_v7_defconfig) seems to be to build kernel image
>> alone and use it without any modules"
>>
>> Which seems to be true, so my understanding is that exynos_defconfig is a
>> minimal defconfig for Exynos platforms and for easy of test/use, everything
>> should be built-in while multi_v7_defconfig would be more similar to a conf
>> used by distros where most things would be built as a module when possible.
> 
> Yeah, but this actually does not entirely cover my doubts. We cannot
> enable everything built-in because boot partitions on some devices have
> limited size. So enabling everything would break that use case (use case
> of easy testing).
>

Agreed.
 
> Let me rephrase my question into:
> 1. What is worth enabling in exynos_defconfig? USB devices? I would
> argue, except they are needed to boot.

Ok, I understand your concern. The question is where we draw the line.

> So maybe enable everything which Exynos boards have hard-wired? That
> would make some sense... but we're making kernel larger.
>

In the case of this WebCam, it's not a typical USB device in the sense
that is built in the Chromebook and not something that's plugged on an
external USB port.
 
> 2. Maybe enable only what is a typical use case (including typical
> testing cases)? Then we would have to define what "typical" means. For
> example battery would be typical but camera would not.
>

There are a lot of board specific drivers that we currently enable as
built-in like hwmon sensors or iio devices that are likely only present
on a single board or a family of boards.

So then I think all those drivers should be changed as a module as well,
unless are critical for the board operation (i.e: thermal or fan drivers).

> 3. Argh, so maybe, if we agree that not everything is worth being
> enabled, that additional stuff could be build as module?
>

Yes, I don't see anything wrong to enable more stuff as a module if
that will give more build / test coverage.

The goal of kernelci is to add functional tests so besides testing
if a given kernel booted correctly, it's going to test if for example
USB enumeration is working and has no regressions. For that use case
is interesting to have support for the built-in USB devices like this
camera (either as built-in or as a module).
 
> 
>> Other SoC specific deconfig do it differently, OMAP for example does the
>> opposite and tries to build as much stuff as possible as a module.
> 
> I don't argue about switching from "y" to "m". That's not the case.
> Rather I am thinking where/when we should stop enabling stuff?
>

Yes, sorry for misunderstanding what you meant before.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
