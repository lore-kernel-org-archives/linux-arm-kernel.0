From: robh@kernel.org (Rob Herring)
Date: Wed, 3 Jun 2015 00:31:58 -0500
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <877fs5k9ps.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
 <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home>
Message-ID: <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 1:43 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Fri, May 15, 2015 at 6:13 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Rob Herring <robh@kernel.org> writes:
>>>
>>>> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
>>>> testing on PXA27x/3xx.
>>> Hi Rob,
>>>
>>> I tested on PXA27x. It works for the boards which used pxa-rtc.
>>> For the others, their defconfig become broken, because the pxa boards with
>>> sa1100-rtc do not work anymore. And of course no .config manipulation will fix
>>> this, because PXA architecture is denied the sa1100-rtc driver.
>>
>> Ah, I didn't realize there is a mixture of use.
>>
>> I could just do something like this instead of removing
>> sa1100_device_rtc registration:
>>
>> #ifndef CONFIG_RTC_DRV_PXA
>>        &sa1100_device_rtc,
>> #else
>>         &pxa_device_rtc,
>> #endif
> I ... don't like that much, especially when you consider both rtc might be
> modules for example. I rather like that patch in pxa as they are.
>
> I'm rather in a mood for a more aggressive approach :
>
>  - you fire an incremental patch to patch the 10 defconfigs on PXA architecture
>    (pxa27x and pxa3xx)

Here's the breakdown of configs which enable SA1100 RTC only. Only the
last 6 need to change by my count:

pxa25x
arch/arm/configs/h5000_defconfig
arch/arm/configs/xcep_defconfig
arch/arm/configs/viper_defconfig

pxa255/270
arch/arm/configs/cm_x2xx_defconfig

pxa270
arch/arm/configs/em_x270_defconfig
arch/arm/configs/magician_defconfig
arch/arm/configs/palmz72_defconfig
arch/arm/configs/pcm027_defconfig
arch/arm/configs/trizeps4_defconfig

>  - in this patch, you replace 's/CONFIG_RTC_DRV_SA1100/CONFIG_RTC_DRV_PXA/'
>  - you send this patch to the maintainers and me
>  - you explain in the commit message that from a userland perspective, nothing
>    changes, except that the RTC IP will change, and any dependency on a

The IP does not change here. rtc0 is still going to be the SA1100 RTC
being registered first. The only change will be the addition of rtc1.

>    bootloader fidling with RTC should be considered as a source of regression.

I'm not sure that I follow.

>    Moreover the first reboot will have the wrong date, until it is set.

Only for rtc1, right?

Rob
