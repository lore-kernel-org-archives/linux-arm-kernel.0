From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 2 Oct 2014 18:59:59 +0200
Subject: [PATCH v8 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybhtzubG8PoynhM14DWa8EaPj9ZVvNAbL_rysWGfAn94VA@mail.gmail.com>
References: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
 <CABxcv=kEVma+Ho6PPy+4t+zYH67sAWbbvJvrviPop-MBqktbjw@mail.gmail.com>
 <CAGm_ybhD0N0r5gj=xAp+ERPq7CjO2d6bDLcPHAoZk1_8+t2Fvw@mail.gmail.com>
 <CABxcv==aA1Ogi_gQfYXxCg2ApFWQdXJLnqne2K=18nx6Oq_jCw@mail.gmail.com>
 <CAGm_ybhtzubG8PoynhM14DWa8EaPj9ZVvNAbL_rysWGfAn94VA@mail.gmail.com>
Message-ID: <CABxcv=mqUwSKX6ZH+gAzYDsm17JWPmLOro7t28Z58ViHFcyTBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

On Thu, Oct 2, 2014 at 4:24 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Hi Javier,
>
> On Wed, Oct 1, 2014 at 7:20 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>> Hello Vikas,
>>
>> On Wed, Oct 1, 2014 at 12:23 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>>>
>>> My git log looks like below on top of Kukjin's for-next branch,
>>>
>>> d861ddd clk: exynos: Add CLK_IGNORE_UNUSED to aclk200_disp1 and aclk300_disp1
>>> adc14dc POSTED: ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420
>>> d61fc43 ARM: exynos5: Add Suspend-to-RAM support for 5420
>>> 3d1d7bd ARM: exynos5: Add PMU support for 5420
>>> a8887b3 mfd: syscon: Decouple syscon interface from platform devices
>>> 072e2bc ARM: EXYNOS: Move PMU specific definitions from common.h
>>> ec2f950 ARM: EXYNOS: Add platform driver support for Exynos PMU
>>>
>>
>> I tested Kukjin's for-next branch (HEAD in commit a84aaa7) + the
>> patches you mentioned and the system enters in suspend mode but the
>> RTC alarm IRQ does not make it resume. Is the branch you are using to
>> test public so I can give it a try?
>>
>
> Not yet, but as I mentioned, I have only above mentioned 7 patches
> atop kukjin's for-next.
> only difference is the patch " ARM: EXYNOS: Use MCPM call-backs to
> support S2R on Exynos5420"
> which I had rebased myself.
>

Yeah, I still don't know why is behaving differently.

> I am out of office till 7th October, once I am back, I can send you
> all those 7 patches, config file and S2R log.
>

Ok, thanks a lot.

>>> recently I noticed that, without the CLK_IGNORE_UNUSED flag for
>>> aclk200_disp1 and aclk300_disp1 CLK,  the system is NOT suspending,
>>> which was NOT the case when i had posted my previous revisions.
>>>
>>
>> I tried both with and without your patch that adds the
>> CLK_IGNORE_UNUSED to aclk200_disp1 and aclk300_disp1 and in both cases
>> it behaves the same, the system seems to go into suspend mode but
>> never resumes:
>
> Can you confirm that the system has really suspended, I mean can you
> measure VDD_EGL or VDD_KFC and check or by any other method you know
> of.
>

I'll see how I can measure but it seems the system is suspended
correctly and the problem is on resuming (more on that below).

>>
>> # echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>> [  105.376596] PM: Syncing filesystems ... done.
>> [  105.383207] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [  105.388681] Freezing remaining freezable tasks ... (elapsed 0.001
>> seconds) done.
>> [  105.488589] wake enabled for irq 281
>> [  105.491609] wake enabled for irq 280
>> [  105.498102] wake enabled for irq 284
>> [  105.554736] PM: suspend of devices complete after 155.406 msecs
>> [  105.562572] PM: late suspend of devices complete after 3.361 msecs
>> [  105.570389] PM: noirq suspend of devices complete after 3.102 msecs
>> [  105.575185] Disabling non-boot CPUs ...
>> [  105.579706] IRQ153 no longer affine to CPU1
>> [  105.580008] CPU1: shutdown
>> [  105.587230] IRQ154 no longer affine to CPU2
>> [  105.587472] CPU2: shutdown
>> [  105.594953] IRQ155 no longer affine to CPU3
>> [  105.595190] CPU3: shutdown
>> [  105.602464] IRQ160 no longer affine to CPU4
>> [  105.602979] CPU4: shutdown
>> [  105.609996] IRQ161 no longer affine to CPU5
>> [  105.610424] CPU5: shutdown
>> [  105.617116] IRQ162 no longer affine to CPU6
>> [  105.617557] CPU6: shutdown
>> [  105.625163] IRQ163 no longer affine to CPU7
>> [  105.625596] CPU7: shutdown
>>
>> I'm testing on a Exynos5420 Peach Pit using exynos_defconfig and
>> disabling CONFIG_BL_SWITCHER as you suggested. My bootargs is:
>>
>
> I too tested on 5420 based peach-pit board with exynos_defconfig +
> disabled CONFIG_BL_SWITCHER.
>
> It did suspend and resume gracefully.
>

I did further testing by enabling some PM debug options
(CONFIG_PM_DEBUG and  CONFIG_PM_ADVANCED_DEBUG) and tested different
suspend modes (freezer, devices, processors and core).

With the three first modes, s2r worked correctly but when trying the
core mode the non-boot CPUs failed to come online again. I tested that
this works on other Exynos SoCs (5250 and 4412):

# grep -c processor /proc/cpuinfo
8
# echo core > /sys/power/pm_test
# echo mem > /sys/power/state
...
Enabling non-boot CPUs ...
CPU1: failed to come online
Error taking CPU1 up: -5
CPU2: failed to come online
Error taking CPU2 up: -5
CPU3: failed to come online
Error taking CPU3 up: -5
CPU4: failed to come online
Error taking CPU4 up: -5
CPU5: failed to come online
Error taking CPU5 up: -5
CPU6: failed to come online
Error taking CPU6 up: -5
CPU7: failed to come online
Error taking CPU7 up: -5
...
# grep -c processor /proc/cpuinfo
1

The -5 (-EIO) error is because even though the call to
exynos_boot_secondary() succeeds in _cpu_up() [0],
secondary_start_kernel() [1] is never called so the CPU is not marked
as online nor the cpu_running completion handler is waked up. So
waiting for it in _cpu_up() times out and cpu_online(cpu) is false.

I still didn't figure out why the secondary CPUs are not jumping into
their expected entry point so any hints are welcomed.

>> console=ttySAC3,115200 debug earlyprintk root=/dev/mmcblk1p2 rootwait
>> rw no_console_suspend
>>
>
> looks fine.
>
>> And I'm booting using a chained nv-uboot with built version:
>>
>> U-Boot 2013.04-gb98ed09 (Mar 07 2014 - 12:25:37) for Peach
>>
>
> I shall update my U-Boot build version, once I am back at office.
>
>

Maybe that is the difference in our setups...

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c#L91
[1]: http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c#L330
