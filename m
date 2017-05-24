From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 May 2017 11:20:48 +0200
Subject: [PATCH v4 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <1adb8aec-8fdf-c4d5-fd9c-29b93ef8ef43@arm.com>
References: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
 <1493029017-31382-7-git-send-email-vladimir.murzin@arm.com>
 <20170523200142.GD22219@n2100.armlinux.org.uk>
 <CAK8P3a0tbaAHerjitDBJ9gz1SCFkAwKhfzjgMHiB5ESakQs7-g@mail.gmail.com>
 <741c708e-9036-a0e1-46e1-90d82a195dff@arm.com>
 <CAK8P3a0s-SLGwhdxX+FDsmRKnYh2nWPKPvwsn_qMOk_1Wb5YMQ@mail.gmail.com>
 <1adb8aec-8fdf-c4d5-fd9c-29b93ef8ef43@arm.com>
Message-ID: <CAK8P3a0hvR4Crtw6J=r32Z_bL07Ge3UUe2o7RymLLi8A9sfgVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:08 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 24/05/17 09:36, Arnd Bergmann wrote:
>> On Wed, May 24, 2017 at 10:31 AM, Vladimir Murzin
>> <vladimir.murzin@arm.com> wrote:
>>> On 23/05/17 21:33, Arnd Bergmann wrote:
>>>> On Tue, May 23, 2017 at 10:01 PM, Russell King - ARM Linux
>>>> <linux@armlinux.org.uk> wrote:
>>>>> On Mon, Apr 24, 2017 at 11:16:56AM +0100, Vladimir Murzin wrote:
>>>>>> Now, we have dedicated non-cacheable region for consistent DMA
>>>>>> operations. However, that region can still be marked as bufferable by
>>>>>> MPU, so it'd be safer to have barriers by default.
>>>>>
>>>>> What do you actually want here?  Your patch doesn't quite make sense,
>>>>> the commit description seems to indicate that you require this option
>>>>> to be set for V7M, but the patch says otherwise.
>>>>>
>>>>>>  config ARM_DMA_MEM_BUFFERABLE
>>>>>> -     bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>>>>>> -     default y if CPU_V6 || CPU_V6K || CPU_V7
>>>>>> +     bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K || CPU_V7M) && !CPU_V7
>>>>>
>>>>> This "if" conditional conditionalises the visibility of the option,
>>>>> it doesn't conditionalise the value.
>>>>>
>>>>>> +     default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
>>>>>
>>>>> Taking both of these changes together what you end up with is an option
>>>>> presented to the user for "Use non-cacheable memory for DMA" which
>>>>> they can choose to disable.
>>>>>
>>>>> If you require this option to be set, that's incorrect - your modification
>>>>> to the default line is correct, but the first line is not.  To achieve
>>>>> that, you want the if condition to evaluate false for V7M, thereby hiding
>>>>> the option from the user.  In that case, the default value will always be
>>>>> assigned to the option.
>>>>
>>>> I had the opposite comment in the previous version ;-)
>>>> https://lkml.org/lkml/2017/4/19/185
>>>>
>>>> I think the current patch is correct, but the description could still be
>>>> clarified: On some of the beefier ARMv7-M machines (with DMA
>>>> and write buffers) we want this enabled, while those that didn't
>>>> need it until now also won't need it in the future.
>>>
>>> Ok. Do you want it go into commit message or option description or maybe both?
>>
>> I'd say both. It would also be helpful to identify specifically which platforms
>> require this, and then add a 'select ARM_DMA_MEM_BUFFERABLE' from
>> the platform, as we do from Moxart.
>>
>
> I'm a bit confused here. In case we want to control it on platform level via
> 'select ARM_DMA_MEM_BUFFERABLE' wouldn't we need to 'default n' for CPU_V7M?
> IIUC, Moxart needs to select this option because it is neither CPU_V6(K) or
> CPU_V7.

It depends: If we want to control it purely by platform, then we don't need
to patch anything here, just add the 'select' and be done with it, leaving
the default to 'n' for ARMv7-M.

If there are platforms on which you might reasonably make the option
user-visible (e.g. you only need it when you actually want to use one of
the DMA masters, but most configurations don't), then having the 'default y'
might still be appropriate, to default to the safe setting on platforms that
don't have the 'select' but letting users turn it off when they know what they
are doing.

      Arnd
