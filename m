From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 17 Dec 2013 08:40:30 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <2459303.277Jr8aotM@amdc1032>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <2459303.277Jr8aotM@amdc1032>
Message-ID: <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On Mon, Dec 16, 2013 at 6:18 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Monday, December 16, 2013 05:31:10 PM Abhilash Kesavan wrote:
>> Add PMU configuration table for various low power modes - AFTR/LPA/SLEEP.
>> Also, add core s2r support for Exynos5420.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> This patch depends on "ARM: EXYNOS5: Add PMU settings for exynos5420"
>> http://www.spinics.net/lists/linux-samsung-soc/msg24902.html
>
> [...]
>
>> @@ -253,10 +316,20 @@ static int exynos_pm_suspend(void)
>>
>>       /* Setting SEQ_OPTION register */
>>
>> -     tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> -     __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     if (soc_is_exynos5420()) {
>> +             cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
>> +             if (!cluster_id)
>> +                     __raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>> +             else
>> +                     __raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>> +     } else if (soc_is_exynos5250()) {
>
> Adding a check here for EXYNOS5250 doesn't look correct
> (the old code behavior for older EXYNOYS SoCs should be
> preserved).

Yes, will fix this in the next version.

>
>> +             tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> +             __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     }
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>

Thanks,
Abhilash
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
