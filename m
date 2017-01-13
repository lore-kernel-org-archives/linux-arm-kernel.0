From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 13 Jan 2017 15:12:57 +0100
Subject: [PATCH v4 0/4] DMA Engine: switch PL330 driver to non-irq-safe
 runtime PM
In-Reply-To: <CAPDyKFqDGs6OkG-NKiY9Xd3hHEJOJB1YJ2O0_3Tojrzv_xR-yw@mail.gmail.com>
References: <CGME20170113072651eucas1p2b7487d97894de93daab24adb6745087c@eucas1p2.samsung.com>
 <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFqDGs6OkG-NKiY9Xd3hHEJOJB1YJ2O0_3Tojrzv_xR-yw@mail.gmail.com>
Message-ID: <60596eee-12a9-58f3-387e-145a5bc28aaa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 2017-01-13 14:59, Ulf Hansson wrote:
> On 13 January 2017 at 08:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> This patchset changes the way the runtime PM is implemented in the PL330 DMA
>> engine driver. The main goal of such change is to add support for the audio
>> power domain to Exynos5 SoCs (5250, 542x, 5433, probably others) and let
>> it to be properly turned off, when no audio is being used. Switching to
>> non-irq-safe runtime PM is required to properly let power domain to be
>> turned off (irq-safe runtime PM keeps power domain turned on all the time)
>> and to integrate with clock controller's runtime PM (this cannot be
>> workarounded any other way, PL330 uses clocks from the controller, which
>> belongs to the same power domain).
>>
>> For more details of the proposed change to the PL330 driver see patch #4.
>>
>> Audio power domain on Exynos5 SoCs contains following hardware modules:
>> 1. clock controller
>> 2. pin controller
>> 3. PL330 DMA controller
>> 4. I2S audio controller
>>
>> Patches for adding or fixing runtime PM for each of the above devices is
>> handled separately.
>>
>> Runtime PM patches for clock controllers is possible and has been proposed
>> in the following thread (pending review): "[PATCH v4 0/4] Add runtime PM
>> support for clocks (on Exynos SoC example)",
>> http://www.spinics.net/lists/arm-kernel/msg550747.html
>>
>> Runtime PM support for Exynos pin controller has been posted in the
>> following thread: "[PATCH 0/9] Runtime PM for Exynos pin controller driver",
>> http://www.spinics.net/lists/arm-kernel/msg550161.html
>>
>> Exynos I2S driver supports runtime PM, but some fixes were needed for it
>> and they are already queued to linux-next.
>>
>> This patchset is based on linux-next from 13th January 2017 with "dmaengine:
>> pl330: fix double lock" patch applied.
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>
> Marek, this is great work! It's been on my TODO list forever, so I
> really appreciate your work here.
>
> I did only a brief review so far, particularly concentrating on the
> changes for device links and runtime PM. I like it!
>
> Perhaps we can get someone like Arnd/Vinod to comment in general idea
> from a DT and DMA slave channel point of view. I don't know that stuff
> good enough to give good opinion.

Arnd already said that it looks good:
http://www.spinics.net/lists/dmaengine/msg12186.html

> A couple of things that crosses my mind so far:
> 1) I have planned to extend pm_runtime_force_suspend|resume() to cover
> also device links. Seems like that becomes really useful together with
> these changes.

Is is really needed? I thought that this case is already handled by device
core. It works perfectly fine for Exynos IOMMU and its client devices for
suspend/resume too, which rely on pm_runtime_force_suspend|resume().

> 2) I think there will be some corner cases during system
> suspend/resume for pl330. Not sure yet though. However, fixing 1) and
> converting the driver to use pm_runtime_force_suspend|resume() should
> probably work anyway.

Do you have any particular case in mind? Device links ensures that pl330 
will
suspended after its slave devices and waken before them. Is there anything
more needed here?

> Allow me to help out looking into 1) and 2). If not for pl330, I am
> pretty sure it will be useful for other DMA controllers that
> implements device links and runtime PM.

I'm open for suggestions.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
