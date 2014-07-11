From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 11 Jul 2014 11:45:32 +0530
Subject: [PATCH v6 0/4] Adds PMU and S2R support for exynos5420
In-Reply-To: <1404737763-21783-1-git-send-email-vikas.sajjan@samsung.com>
References: <1404737763-21783-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAHfPSqAUnNR7R48hv-=8xq=iGp1m+9P_=BT5Ak1U-RuzGXteTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

On 7 July 2014 18:25, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Rebased on
> 1] Kukjin Kim's tree, for-next branch
> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
> 2] Pankaj Dubey's v6 PMU patchset
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33660.html
>
> changes since v5:
>         - Refactored pm.c to use DT based lookup as suggested by Tomasz Figa.
>
> changes since v4:
>         - Adressed comments from Tomasz figa and rebased on Pankaj Dubey's v5 PMU patchset
>
> changes since v3:
> Addressed the following comments from Pankaj Dubey, Bartlomiej Zolnierkiewicz,
> Tomasz Figa and Alim Akhtar:
>         - Moved EXYNOS5420_USE_STANDBY_WFI_ALL define to regs-pmu.h.
>         - Merged exynos5420_set_core_flag function into powerdown_conf.
>         - Removed XXTI_DURATION3 register setting.
>         - Updated the commit message and ordered the clock registers in clock
>           patch.
>         - Removed the code for SYS_DISP1_BLK_CFG handling.
>         - Modified SoC checks to A9 specific checks in PM code.
>         - Updated some comments in the code and added macros for register offsets.
>         - Fixed code which was changing pad retention code for older SoCs.
>
> changes since v2:
>         - Addressed comments from Tomasz figa
>         - rebased on Pankaj's V3 patchset https://lkml.org/lkml/2014/5/2/612
>         - dropped patch "ARM: dts: Add node for GPIO keys on SMDK5420",
>           will be sent separately.
>
> changes since v1:
>         - Addressed comments from Tomasz figa.
>         - restructured/consolidated as per Tomasz figa's PM consolidations for exynos
>
> Tested on Kukjin Kim's tree, for-next branch +
>         1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
>         2] http://www.spinics.net/lists/linux-samsung-soc/msg32923.html
>         3] https://www.mail-archive.com/linux-mmc at vger.kernel.org/msg26210.html (for eMMC S2R fail issue)
>
> on Exynos5420 based chromebook (peach-pit board) and Exynos5250 based chromebook (snow board).
>
> PS : Not tested on exynos4 based boards.
>
> Tested-by for exynos4 would be appreciated.
>
> Below procedures were followed to test S2R:
> Procedure A:
>         1. make multi_v7_defconfig
>         2  enable MCPM for 5420
>         3. enable S3C RTC
>         4. pass "no_console_suspend" in bootargs
>         5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
> Procedure B:
>         1. make exynos_defconfig
>         2  enable MCPM for 5420
>         3  enable CONFIG_PL330_DMA
>         4. enable CONFIG_PM_RUNTIME
>         5. pass "no_console_suspend" in bootargs
>         6. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state

Could test with the given description on Exynos5420 based Peach PIT.
S2R on Exynos5250 based Snow works fine too.

With http://www.spinics.net/lists/linux-samsung-soc/msg33999.html
S2R on Exynos5800 based Peach PI works fine.

Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

>
> Abhilash Kesavan (2):
>   arm: exynos5: Add PMU support for 5420
>   arm: exynos5: Add Suspend-to-RAM support for 5420
>
> Vikas Sajjan (2):
>   ARM: EXYNOS: Refactor the code to use DT based lookup
>   clk: samsung: exynos5420: Setup clocks before system suspend
>
>  arch/arm/mach-exynos/pm.c            |  376 ++++++++++++++++++++++++++++++----
>  arch/arm/mach-exynos/pmu.c           |  288 ++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h      |  230 +++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos5420.c |   29 +++
>  4 files changed, 880 insertions(+), 43 deletions(-)
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
