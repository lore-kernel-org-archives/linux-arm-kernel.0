From: psawargaonkar@apm.com (Pranavkumar Sawargaonkar)
Date: Thu, 12 Mar 2015 09:22:02 +0530
Subject: [PATCH] arm64: dts: Fix GIC reg sizes for APM X-Gene
In-Reply-To: <550086B9.4010001@arm.com>
References: <1422342206-4750-1-git-send-email-psawargaonkar@apm.com>
 <550056FD.8060804@arm.com>
 <CAL85gmCuB4LfNp+6B8cL9+emFqWPM6W9gevTzibyaAzL+7jVdg@mail.gmail.com>
 <55007BE3.30300@arm.com>
 <CAL85gmDVfop1_roHyLTRzFY3BahzTWs7nwbpmZD7emFKcFHyLg@mail.gmail.com>
 <550086B9.4010001@arm.com>
Message-ID: <CANFfpkQ1QyWEGwwQx1g1By=uXvctJjF8AOO+uA5CFUgO4v9DFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Mar 11, 2015 at 11:47 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/03/15 17:57, Feng Kan wrote:
>> On Wed, Mar 11, 2015 at 10:31 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 11/03/15 17:19, Feng Kan wrote:
>>>> On Wed, Mar 11, 2015 at 7:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>> On 27/01/15 07:03, Pranavkumar Sawargaonkar wrote:
>>>>>> In APM X-Gene, GIC register space is 64K aligned while the sizes mentioned
>>>>>> in the dt are 4K aligned. This breaks KVM when kernel is built with 64K page
>>>>>> size due to size alignment checking in vgic driver for VCPU Control and
>>>>>> VCPU register.
>>>>>>
>>>>>> This patch corrects the sizes to be inline with the hardware spec.
>>>>>
>>>>> This patch may be correct, but it is useless. The firmware on my APM
>>>>> system (some version of u-boot) repaints the DT at boot time, negating
>>>>> the effect of this patch.
>>>> We have updated u-boot to reflect this change. I can supply you with a updated
>>>> image if you wish.
>>>
>>> That would be useful, thanks.
>>>
>>> But more importantly, why bother upstreaming your DT into the kernel
>>> tree if your firmware is going to overwrite whatever we provide?
>> We did tried to submit a version upstream but was rejected.
>>
>>>
>>> Either the firmware let the user provide its own DT (and doesn't touch
>>> it other than to change the CPU enable method, insert a /memreserve/ or
>>> similar things), or the firmware always provide its own DT, and doesn't
>>> let the user provide its own. Corrupting the user DT is a disaster, as
>>> we just found.
>> Yes, the intent of the change is listed in the link below. It is not a
>> justification by any means,
>> just the effects of things appearing in layers.
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288574.html
>
> Yeah. This is as wrong as it can possibly be. Oh well...

Yes there is an issue with u-boot patching the dt for end user who
wants his DT to be used, for this we can (in fact we should) provide
an option in u-boot (may be setting some environment variable) which
will make sure end user's DT does not get modified (apart from
standard things like patching mac-addresses) by u-boot.

Another point I want to reopen here is the how to handle 64K GIC page
size pointed out in this thread, what would be the best way to tackle
this (adding a new DT string or any other way) ?


Thanks,
Pranav

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
