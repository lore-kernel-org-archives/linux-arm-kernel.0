From: robherring2@gmail.com (Rob Herring)
Date: Tue, 1 Apr 2014 21:37:49 -0500
Subject: [PATCH] ARM: errata: workaround Cortex-A9 errata 761320 and 794072
In-Reply-To: <d687ddaf7b6e4eeca23b44bfdf26a55b@BLUPR03MB358.namprd03.prod.outlook.com>
References: <1396298072-13254-1-git-send-email-nitin.garg@freescale.com>
 <1396298072-13254-2-git-send-email-nitin.garg@freescale.com>
 <CAL_JsqK--G_7nO_UQ6jyomA1Sq6GUKtXVZpBF0dXjYA2iE047w@mail.gmail.com>
 <d687ddaf7b6e4eeca23b44bfdf26a55b@BLUPR03MB358.namprd03.prod.outlook.com>
Message-ID: <CAL_JsqLNMrRV0JXYSsJ-8J2aPpY+RaRxeD24jPNqs2qPkFj=GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 8:18 PM, Nitin Garg <nitin.garg@freescale.com> wrote:
> Hi Rob,

Please follow mailing list rules and don't top post.

> Thanks for reply. In that case, I wonder why there is already code which access the diagnostic register. Pls see:
> arch/arm/mm/proc-v7.S: __v7_setup
> CONFIG_ARM_ERRATA_742230
> CONFIG_ARM_ERRATA_742231
> CONFIG_ARM_ERRATA_743622
> CONFIG_ARM_ERRATA_751472

Perhaps you should look at this commit:

commit 62e4d357aae0c7438c537bdb1c86909d7cac2663
Author: Rob Herring <rob.herring@calxeda.com>
Date:   Fri Dec 21 22:42:40 2012 +0100

    ARM: 7609/1: disable errata work-arounds which access secure registers

    In order to support secure and non-secure platforms in multi-platform
    kernels, errata work-arounds that access secure only registers need to
    be disabled. Make all the errata options that fit in this category
    depend on !CONFIG_ARCH_MULTIPLATFORM.

    This will effectively remove the errata options as platforms are
    converted over to multi-platform.

    Signed-off-by: Rob Herring <rob.herring@calxeda.com>
    Acked-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


And one hint, the solution for you is not adding "depends on
!CONFIG_ARCH_MULTIPLATFORM". Adding that for something new will not
get accepted.

Once exynos is converted to multi-platform, we may be able to actually
remove all these A9 errata as there may not be any more non
multi-platform A9 or A15 based platforms.

Rob

>
> Regards,
> Nitin Garg
>
>
> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: Tuesday, April 01, 2014 8:12 PM
> To: Garg Nitin-B37173
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: errata: workaround Cortex-A9 errata 761320 and 794072
>
> On Mon, Mar 31, 2014 at 3:34 PM, Nitin Garg <nitin.garg@freescale.com> wrote:
>> Add workaround for Cortex-A9 errata 761320 ([present on r0, r1, r2,
>> r3) and 794072 (present on all revisions). These are Category B,
>> present on SMP systems.
>
> These work-arounds don't work on non-secure systems which don't have access to the diagnostic register. There is no architectural way to determine secure vs. non-secure mode. It's been discussed before and decided that these types of work-arounds must go into the bootloader or firmware.
>
> Rob
>
>>
>> Signed-off-by: Nitin Garg <nitin.garg@freescale.com>
>> ---
>>  arch/arm/Kconfig          |   23 +++++++++++++++++++++++
>>  arch/arm/mach-imx/Kconfig |    2 ++
>>  arch/arm/mm/proc-v7.S     |   11 +++++++++++
>>  3 files changed, 36 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
>> a48712e..f8464ff 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1301,6 +1301,29 @@ config ARM_ERRATA_751472
>>           operation is received by a CPU before the ICIALLUIS has completed,
>>           potentially leading to corrupted entries in the cache or TLB.
>>
>> +config ARM_ERRATA_794072
>> +       bool "ARM errata: A short loop including a DMB instruction might cause a denial of service"
>> +       depends on CPU_V7 && SMP
>> +       help
>> +          This option enables the workaround for the 794072 Cortex-A9
>> +          (all revisions). A processor which continuously executes a short
>> +          loop containing a DMB instruction might prevent a CP15 operation
>> +          broadcast by another processor making further progress, causing
>> +          a denial of service. This erratum can be worked around by setting
>> +          bit[4] of the undocumented Diagnostic Control Register to 1.
>> +
>> +config ARM_ERRATA_761320
>> +       bool "Full cache line writes to the same memory region from at least two processors might deadlock processor"
>> +       depends on CPU_V7 && SMP
>> +       help
>> +         This option enables the workaround for the 761320 Cortex-A9 (r0..r3).
>> +         Under very rare circumstances, full cache line writes
>> +         from (at least) 2 processors on cache lines in hazard with
>> +         other requests may cause arbitration issues in the SCU,
>> +         leading to processor deadlock. This erratum can be
>> +         worked around by setting bit[21] of the undocumented
>> +         Diagnostic Control Register to 1.
>> +
>>  config PL310_ERRATA_753970
>>         bool "PL310 errata: cache sync operation may be faulty"
>>         depends on CACHE_PL310
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index 5740296d..19690c2 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -794,6 +794,8 @@ config SOC_IMX6
>>  config SOC_IMX6Q
>>         bool "i.MX6 Quad/DualLite support"
>>         select ARM_ERRATA_764369 if SMP
>> +       select ARM_ERRATA_794072 if SMP
>> +       select ARM_ERRATA_761320 if SMP
>>         select HAVE_ARM_SCU if SMP
>>         select HAVE_ARM_TWD if SMP
>>         select MIGHT_HAVE_PCI
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S index
>> 195731d..b5e5386 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -337,6 +337,17 @@ __v7_setup:
>>         mcrlt   p15, 0, r10, c15, c0, 1         @ write diagnostic register
>>  1:
>>  #endif
>> +#ifdef CONFIG_ARM_ERRATA_794072
>> +       mrc     p15, 0, r10, c15, c0, 1         @ read diagnostic register
>> +       orr     r10, r10, #1 << 4               @ set bit #4
>> +       mcr     p15, 0, r10, c15, c0, 1         @ write diagnostic register
>> +#endif
>> +#ifdef CONFIG_ARM_ERRATA_761320
>> +       cmp     r6, #0x40                       @ present prior to r4p0
>> +       mrclt   p15, 0, r10, c15, c0, 1         @ read diagnostic register
>> +       orrlt   r10, r10, #1 << 21              @ set bit #21
>> +       mcrlt   p15, 0, r10, c15, c0, 1         @ write diagnostic register
>> +#endif
>>
>>         /* Cortex-A15 Errata */
>>  3:     ldr     r10, =0x00000c0f                @ Cortex-A15 primary part number
>> --
>> 1.7.4.1
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
