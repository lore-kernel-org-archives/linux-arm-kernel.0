From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 27 Jun 2012 14:10:00 +0900
Subject: [PATCH] ARM: EXYNOS: Remove the L2 cache latency setting for
 EXYNOS5
In-Reply-To: <006d01cd53f7$6877ed90$3967c8b0$%kim@samsung.com>
References: <038301cd4f47$8202b420$86081c60$%kim@samsung.com>
 <CAPLVkLsgi3ST622ZhRusJz5OHV6MJYP7SNkj2Mh-QPos1AWyhQ@mail.gmail.com>
 <006d01cd53f7$6877ed90$3967c8b0$%kim@samsung.com>
Message-ID: <4FEA95A8.3080505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/27/2012 08:57 AM, Boojin Kim wrote:
> Joonyoung Shim wrote:
>
>> I don't understand this. Do you mean that BL1 codes do it?
>> I also wonder how enable L2 cache at the exynos5.
> Yes, the latency configuration of L2 cache is located on IROM or BL1 code.

How does kernel know it? Also, IROM and BL1 is blackbox to me

> It can remove the overhead about cache reset and cache flush.
> And, Kernel enables L2 cache.

I cannot find codes to enable L2 cache for exynos5 in the kernel.
Please let me know it.

Thanks.

> Thanks.
>>> no longer need that in the kernel. It helps to reduce
>>> booting time (no need cache disable and cache enable).
>>>
>>> Signed-off-by: Boojin Kim<boojin.kim@samsung.com>
>>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>>> ---
>>> ?rch/arm/mach-exynos/common.c |   25 -------------------------
>>>   1 files changed, 0 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
>>> index 742edd3..0ec1a91 100644
>>> --- a/arch/arm/mach-exynos/common.c
>>> +++ b/arch/arm/mach-exynos/common.c
>>> @@ -712,31 +712,6 @@ static int __init exynos4_l2x0_cache_init(void)
>>> ?arly_initcall(exynos4_l2x0_cache_init);
>>>   #endif
>>>
>>> -static int __init exynos5_l2_cache_init(void)
>>> -{
>>> -       unsigned int val;
>>> -
>>> -       if (!soc_is_exynos5250())
>>> -               return 0;
>>> -
>>> -       asm volatile("mrc p15, 0, %0, c1, c0, 0\n"
>>> -                    "bic %0, %0, #(1<<  2)\n"  /* cache disable */
>>> -                    "mcr p15, 0, %0, c1, c0, 0\n"
>>> -                    "mrc p15, 1, %0, c9, c0, 2\n"
>>> -                    : "=r"(val));
>>> -
>>> -       val |= (1<<  9) | (1<<  5) | (2<<  6) | (2<<  0);
>>> -
>>> -       asm volatile("mcr p15, 1, %0, c9, c0, 2\n" : : "r"(val));
>>> -       asm volatile("mrc p15, 0, %0, c1, c0, 0\n"
>>> -                    "orr %0, %0, #(1<<  2)\n"  /* cache enable */
>>> -                    "mcr p15, 0, %0, c1, c0, 0\n"
>>> -                    : : "r"(val));
>>> -
>>> -       return 0;
>>> -}
>>> -early_initcall(exynos5_l2_cache_init);
>>> -
>>> ?tatic int __init exynos_init(void)
>>>   {
>>>        ?rintk(KERN_INFO "EXYNOS: Initializing architecture\n");
>>> --
>>> 1.7.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>> --
>> - Joonyoung Shim
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/66ca79fe/attachment-0001.html>
