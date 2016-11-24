From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 24 Nov 2016 10:12:15 +0000
Subject: [RFC PATCH 2/5] dmaengine: allow sun6i-dma for more SoCs
In-Reply-To: <CAGb2v65G7=9ah+sEet=z5vss60kL5ZLSkNsAcGpwu8V6AWdEGA@mail.gmail.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
 <1479950235-26821-3-git-send-email-andre.przywara@arm.com>
 <CAGb2v67M8DrPaf8GzSPEjekgV6cLcXXzO3tVUc9kjUDcM3BE_w@mail.gmail.com>
 <34b5e50f-a091-9bd8-7a74-96e538a7351d@arm.com>
 <CAGb2v65G7=9ah+sEet=z5vss60kL5ZLSkNsAcGpwu8V6AWdEGA@mail.gmail.com>
Message-ID: <15f511fd-ba0b-9b10-1650-d24e2d9e467e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/11/16 09:30, Chen-Yu Tsai wrote:
> On Thu, Nov 24, 2016 at 5:16 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> Hi,
>>
>> On 24/11/16 04:16, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Thu, Nov 24, 2016 at 9:17 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>>>> The sun6i DMA driver is used in the Allwinner A64 and H5 SoC, which
>>>> have arm64 capable cores. Add the generic sunxi config symbol to allow
>>>> the driver to be selected by arm64 Kconfigs, which don't feature
>>>> SoC specific MACH_xxxx configs.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>  drivers/dma/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>> index af63a6b..003c284 100644
>>>> --- a/drivers/dma/Kconfig
>>>> +++ b/drivers/dma/Kconfig
>>>> @@ -157,7 +157,7 @@ config DMA_SUN4I
>>>>
>>>>  config DMA_SUN6I
>>>>         tristate "Allwinner A31 SoCs DMA support"
>>>> -       depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
>>>> +       depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST || ARCH_SUNXI
>>>
>>> AFAIK ARCH_SUNXI encompasses/supersedes MACH_SUN*I.
>>> (And I don't have to add MACH_SUN9I later :) )
>>
>> Sure, admittedly it was just a quick hack to get things going.
>> Actually I don't know why we had a *depend* on those MACH_s before. I
>> think technically it does not depend on a certain SoC (having the
>> COMPILE_TEST in there hints on that). So what about:
> 
> It was really because this DMA engine only comes with the later
> SoCs. We have dma-sun4i for the older one. But yes, there's no
> reason why you can't build it for the earlier SoC. It just doesn't
> get used.
> 
>>
>>         depends on ARCH_SUNXI || COMPILE_TEST
>>
>> and maybe:
>>
>>         default y if MACH_SUN6I || MACH_SUN8I
>>
>> Though I see that both multi_v7_defconfig and sunxi_defconfig explicitly
>> set this, so this wouldn't be needed?
> 
> I guess it's just nice to get stuff out of defconfig?
> Why not go all the way and just have
> 
>         default y if ARCH_SUNXI

Well, I am all for it, but I had the impression that there is a lot of
opposition against this approach. Apparently people still want to save
some bytes by building a kernel tailored to one particular SoC.
So I didn't dare to come up with this one.
But it should work to use "# DMA_SUN6I is not selected" in a particular
.config or defconfig to deselect it, right?

Waiting for Maxime's opinion here.

(And also need to check whether the DMA really works on ARM64.
Surprisingly the code compiled cleanly, but I am wondering whether it
properly deals with 32-bit limitation of this controller. I just needed
it because the H3 DT references DMA for SPI and UART).

Cheers,
Andre.
