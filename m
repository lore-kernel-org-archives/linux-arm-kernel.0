From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jun 2015 16:28:00 -0500
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <871thq54c7.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
 <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home>
 <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
 <871thq54c7.fsf@belgarion.home>
Message-ID: <CAL_JsqJnj+JLFoUmE6COqhr83_H0n1=Bdk_wYnMZEzsZRu=aew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 5, 2015 at 2:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>>> I'm rather in a mood for a more aggressive approach :
>>>
>>>  - you fire an incremental patch to patch the 10 defconfigs on PXA architecture
>>>    (pxa27x and pxa3xx)
>>
>> Here's the breakdown of configs which enable SA1100 RTC only. Only the
>> last 6 need to change by my count:
>>
>> pxa25x
>> arch/arm/configs/h5000_defconfig
>> arch/arm/configs/xcep_defconfig
>> arch/arm/configs/viper_defconfig
>>
>> pxa255/270
>> arch/arm/configs/cm_x2xx_defconfig
>>
>> pxa270
>> arch/arm/configs/em_x270_defconfig
>> arch/arm/configs/magician_defconfig
>> arch/arm/configs/palmz72_defconfig
>> arch/arm/configs/pcm027_defconfig
>> arch/arm/configs/trizeps4_defconfig
> And arch/arm/configs/jornada720_defconfig I counted wrongly as it's sa1100.
> So I agree with your list of last 6 defconfigs.
>
>>>  - in this patch, you replace 's/CONFIG_RTC_DRV_SA1100/CONFIG_RTC_DRV_PXA/'
>>>  - you send this patch to the maintainers and me
>>>  - you explain in the commit message that from a userland perspective, nothing
>>>    changes, except that the RTC IP will change, and any dependency on a
>>
>> The IP does not change here. rtc0 is still going to be the SA1100 RTC
>> being registered first. The only change will be the addition of rtc1.
> For boards which were only using rtc-pxa.c (as mioa701 for example), they relied
> on the fact that rtc0 == pxa_rtc. Their time is stored in PXA IP. Therefore,
> each of their hwclock will end up on sa1100-rtc instead of pxa-rtc.
>
> So for these boards, ie. for all boards where only rtc-pxa.c was used, the IP
> addressed changes from a casual userspace perspective.

Okay, so this is the case where the time will be wrong.

I could remove the select of the sa1100-rtc and do an empty function
for sa1100_rtc_init. This would preserve current behavior.

>
>>>    bootloader fidling with RTC should be considered as a source of regression.
>>
>> I'm not sure that I follow.
> Let's talk about how a double boot windows + linux box works.
> The bootloader ensures that :
>  - sa1100-rtc holds the number of seconds since the OS start (think jiffies)
>  - pxa-rtc holds the wall clock time
>
> Upon each reboot, sa1100-rtc is checked to see how much time has passed. If an
> "oustanding number" is detected, for example 10 years, the firmware resets the
> data partition.
>
> Now think what will happen when this change will be commited, upon the first
> reboot after the linux kernel has change sa1100-rtc time.

That would be bad. But on these platforms, the kernel has been using
both RTCs right? Presumably on platforms only using 1 of the RTCs, the
bootloader does not touch the RTCs.

Rob

>
>>>    Moreover the first reboot will have the wrong date, until it is set.
>> Only for rtc1, right?
> Yes, right, unless the bootloader logic is ... over-engineered.
>
> All of this to say maintainers should be forwarned at least. After that, up to
> them to react.
>
> Cheers.
>
> --
> Robert
