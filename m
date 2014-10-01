From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 1 Oct 2014 15:50:24 +0200
Subject: [PATCH v8 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybhD0N0r5gj=xAp+ERPq7CjO2d6bDLcPHAoZk1_8+t2Fvw@mail.gmail.com>
References: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
 <CABxcv=kEVma+Ho6PPy+4t+zYH67sAWbbvJvrviPop-MBqktbjw@mail.gmail.com>
 <CAGm_ybhD0N0r5gj=xAp+ERPq7CjO2d6bDLcPHAoZk1_8+t2Fvw@mail.gmail.com>
Message-ID: <CABxcv==aA1Ogi_gQfYXxCg2ApFWQdXJLnqne2K=18nx6Oq_jCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

On Wed, Oct 1, 2014 at 12:23 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>
> My git log looks like below on top of Kukjin's for-next branch,
>
> d861ddd clk: exynos: Add CLK_IGNORE_UNUSED to aclk200_disp1 and aclk300_disp1
> adc14dc POSTED: ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420
> d61fc43 ARM: exynos5: Add Suspend-to-RAM support for 5420
> 3d1d7bd ARM: exynos5: Add PMU support for 5420
> a8887b3 mfd: syscon: Decouple syscon interface from platform devices
> 072e2bc ARM: EXYNOS: Move PMU specific definitions from common.h
> ec2f950 ARM: EXYNOS: Add platform driver support for Exynos PMU
>

I tested Kukjin's for-next branch (HEAD in commit a84aaa7) + the
patches you mentioned and the system enters in suspend mode but the
RTC alarm IRQ does not make it resume. Is the branch you are using to
test public so I can give it a try?

> recently I noticed that, without the CLK_IGNORE_UNUSED flag for
> aclk200_disp1 and aclk300_disp1 CLK,  the system is NOT suspending,
> which was NOT the case when i had posted my previous revisions.
>

I tried both with and without your patch that adds the
CLK_IGNORE_UNUSED to aclk200_disp1 and aclk300_disp1 and in both cases
it behaves the same, the system seems to go into suspend mode but
never resumes:

# echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
[  105.376596] PM: Syncing filesystems ... done.
[  105.383207] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  105.388681] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  105.488589] wake enabled for irq 281
[  105.491609] wake enabled for irq 280
[  105.498102] wake enabled for irq 284
[  105.554736] PM: suspend of devices complete after 155.406 msecs
[  105.562572] PM: late suspend of devices complete after 3.361 msecs
[  105.570389] PM: noirq suspend of devices complete after 3.102 msecs
[  105.575185] Disabling non-boot CPUs ...
[  105.579706] IRQ153 no longer affine to CPU1
[  105.580008] CPU1: shutdown
[  105.587230] IRQ154 no longer affine to CPU2
[  105.587472] CPU2: shutdown
[  105.594953] IRQ155 no longer affine to CPU3
[  105.595190] CPU3: shutdown
[  105.602464] IRQ160 no longer affine to CPU4
[  105.602979] CPU4: shutdown
[  105.609996] IRQ161 no longer affine to CPU5
[  105.610424] CPU5: shutdown
[  105.617116] IRQ162 no longer affine to CPU6
[  105.617557] CPU6: shutdown
[  105.625163] IRQ163 no longer affine to CPU7
[  105.625596] CPU7: shutdown

I'm testing on a Exynos5420 Peach Pit using exynos_defconfig and
disabling CONFIG_BL_SWITCHER as you suggested. My bootargs is:

console=ttySAC3,115200 debug earlyprintk root=/dev/mmcblk1p2 rootwait
rw no_console_suspend

And I'm booting using a chained nv-uboot with built version:

U-Boot 2013.04-gb98ed09 (Mar 07 2014 - 12:25:37) for Peach

I checked that the s3c2410-rtc alarm IRQ is fired correctly by looking
at /sys/class/rtc/rtc0/wakealarm and also /proc/interrupts.

Any ideas before I dig into this?

Thanks a lot and best regards,
Javier
