From: sjoshi.open@gmail.com (sunil joshi)
Date: Fri, 20 Dec 2013 15:56:38 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <2459303.277Jr8aotM@amdc1032>
 <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
Message-ID: <CANruHrS1D8d_y43xa-2OGduTvAGWfdeY1REVzZ6YJHjhzLg+hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,
I saw another patch in chrome tree ..by Andrew Bresticker
which may be relevant here ..

Just wondering if you missed adding this ? or this is not needed ?
You did not face any issue in getting core to suspend ?

------------------------------------------------------------------------------------------
commit 95402d816b9f1a05ce633f7ff64b4c939c142482
Author: Andrew Bresticker <abrestic@chromium.org>
Date:   Mon Jul 15 13:14:36 2013 -0700

    arm: exynos: disable all interrupts on Exynos5420 before suspend

    Disable all interrupts from the GIC before entering suspend on
    Exynos5420 as is done on Exynos5250.  If interrupts are enabled, we
    may receive an interrupt after entering WFI but before the PMU has
    suspended the system, causing suspend to fail.

    BUG=chrome-os-partner:20523
    TEST=Run suspend_stress_test on Pit and observe that entering suspend
    no longer occasionally fails with the "Failed to suspend the system"
    error in exynos_cpu_suspend().

    Change-Id: Ia2d963191f4e5485beb295b28f128f2ce256f987
    Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
    Reviewed-on: https://gerrit.chromium.org/gerrit/61948
    Reviewed-by: Simon Glass <sjg@chromium.org>

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 537051d..9fdb8bc 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -126,7 +126,7 @@ static int exynos_cpu_suspend(unsigned long arg)
         * Disable all interrupts.  eints will still be active during
         * suspend so its ok to mask everything here
         */
-       if (soc_is_exynos5250())
+       if (soc_is_exynos5250() || soc_is_exynos5420())
                __raw_writel(0x0, S5P_VA_GIC_DIST + GIC_DIST_CTRL);

On Tue, Dec 17, 2013 at 8:40 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Bartlomiej,
>
> On Mon, Dec 16, 2013 at 6:18 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> Hi,
>>
>> On Monday, December 16, 2013 05:31:10 PM Abhilash Kesavan wrote:
>>> Add PMU configuration table for various low power modes - AFTR/LPA/SLEEP.
>>> Also, add core s2r support for Exynos5420.
>>>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> ---
>>> This patch depends on "ARM: EXYNOS5: Add PMU settings for exynos5420"
>>> http://www.spinics.net/lists/linux-samsung-soc/msg24902.html
>>
>> [...]
>>
>>> @@ -253,10 +316,20 @@ static int exynos_pm_suspend(void)
>>>
>>>       /* Setting SEQ_OPTION register */
>>>
>>> -     tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>>> -     __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>>> +     if (soc_is_exynos5420()) {
>>> +             cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
>>> +             if (!cluster_id)
>>> +                     __raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
>>> +                                  S5P_CENTRAL_SEQ_OPTION);
>>> +             else
>>> +                     __raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
>>> +                                  S5P_CENTRAL_SEQ_OPTION);
>>> +     } else if (soc_is_exynos5250()) {
>>
>> Adding a check here for EXYNOS5250 doesn't look correct
>> (the old code behavior for older EXYNOYS SoCs should be
>> preserved).
>
> Yes, will fix this in the next version.
>
>>
>>> +             tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>>> +             __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>>> +     }
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>
> Thanks,
> Abhilash
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
