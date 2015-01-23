From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 23 Jan 2015 17:44:48 +0100
Subject: [PATCH v4 18/18] iommu: exynos: add callback for initializing
 devices from device tree
In-Reply-To: <54C273AF.1010404@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
 <1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
 <CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
 <54C2415A.3020508@samsung.com>
 <CABxcv=nX22+1VcA038yyLJz7dUN-tk9-kWTpSB-FeyLxVeRmZA@mail.gmail.com>
 <54C273AF.1010404@samsung.com>
Message-ID: <CABxcv==S97O84zRwFi6SZy75cvZEVRrFHHY-CvmYfQ+SEX0mTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On Fri, Jan 23, 2015 at 5:15 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>>
>>> To check if this is caused by io page fault, please temporarily add the
>>> following hack:
>>> --->8---
>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>> index 7864797609b3..5e70cf7eb31b 100644
>>> --- a/arch/arm/mm/dma-mapping.c
>>> +++ b/arch/arm/mm/dma-mapping.c
>>> @@ -2011,6 +2011,9 @@ static bool arm_setup_iommu_dma_ops(struct device
>>> *dev, u64 dma_base, u64 size,
>>>           return false;
>>>       }
>>>
>>> +    iommu_map(mapping->domain, 0x40000000, 0x40000000, 0x80000000,
>>> +          IOMMU_READ | IOMMU_WRITE);
>>> +
>>>       if (arm_iommu_attach_device(dev, mapping)) {
>>
>> The kernel still hangs but the boot does indeed go further. Here is my
>> boot log [0] although I couldn't find an evident cause.
>
>
> Frankly, this freeze looks really strange, because there is no error message
> or any other failure indicator.
>
> Thanks for testing the above hack. It confirmed that the previous boot

You are welcome

> failure
> was caused by display left enabled in bootloader. Such configuration is not
> yet
> supported, although I will do my best so find how to add support for it. For
> the

Great, thanks a lot.

> time being - please don't enable IOMMU support on Exynos5420 Peach Pit. It
> shouldn't be a big issue, because IOMMU support was already non-functional
> all the time on Exynos platform.
>

Agreed but keep in mind that CONFIG_EXYNOS_IOMMU is currently enabled
in arch/arm/configs/exynos_defconfig so you should include in your
series a patch to disable that config option to prevent the boot hang.
Or at least add a of_machine_is_compatible("google,peach") check
although I don't know if there are other Exynos machines that have the
same issue.

Best regards,
Javier
