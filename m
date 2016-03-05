From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 5 Mar 2016 13:28:06 +0900
Subject: [PATCH v2] media: platform: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <56D96B44.5090307@samsung.com>
References: <1457053344-28992-1-git-send-email-k.kozlowski@samsung.com>
 <56D96B44.5090307@samsung.com>
Message-ID: <CAJKOXPf4RvRqSYy2bzZeA9TFqYZTs_E08TKcbtPn8gwH+bfpVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-04 20:02 GMT+09:00 Sylwester Nawrocki <s.nawrocki@samsung.com>:
> On 03/04/2016 02:02 AM, Krzysztof Kozlowski wrote:
>> The MFD_SYSCON depends on HAS_IOMEM so when selecting
>> it avoid unmet direct dependencies.
>
>> diff --git a/drivers/media/platform/exynos4-is/Kconfig
>> b/drivers/media/platform/exynos4-is/Kconfig
>> index 57d42c6172c5..c4317b99d257 100644
>> --- a/drivers/media/platform/exynos4-is/Kconfig
>> +++ b/drivers/media/platform/exynos4-is/Kconfig
>> @@ -17,6 +17,7 @@ config VIDEO_S5P_FIMC
>>       tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
>>       depends on I2C
>>       depends on HAS_DMA
>> +     depends on HAS_IOMEM    # For MFD_SYSCON
>>       select VIDEOBUF2_DMA_CONTIG
>>       select V4L2_MEM2MEM_DEV
>>       select MFD_SYSCON
>
> While we are already at it, shouldn't "depends on HAS_IOMEM"
> be instead added at the top level entry in this Kconfig file,
> i.e. "config VIDEO_SAMSUNG_EXYNOS4_IS" ? For things like
> devm_ioremap_resource() depending on HAS_IOMEM and used in all
> the sub-drivers, enabled by VIDEO_SAMSUNG_EXYNOS4_IS?

Indeed that would make sense... but now after some more looking at it,
even this patch is not needed. All these drivers are children of
MEDIA_SUPPORT which already depends on HAS_IOMEM.

Best regards,
Krzysztof
