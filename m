From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 05 Aug 2014 16:03:12 +0200
Subject: [PATCH v5 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards
 with secure firmware enabled
In-Reply-To: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <53E0E420.8060207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 03:34 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> This patch series adds support for AFTR idle mode on boards with
> secure firmware enabled and allows EXYNOS cpuidle driver usage on
> Exynos4x12 SoCs.
>
> It has been tested on Trats2 board (using Exynos4412 SoC with secure
> firmware enabled) on which AFTR mode reduces power consumption by ~12%
> when EXYNOS cpuidle driver is enabled (in both cases the default
> exynos_defconfig config is used and CPU1-3 are offlined).

As a sidenote:

On my odroid-U2:
  * 4 cpus online -> 130 mA
  * 3 cpus online -> 164 mA
  * 2 cpus online -> 160 mA
  * 1 cpu online  -> 157 mA

So were are consuming more when there are unplugged cpu ... any ideas ?

Thanks !

   -- Daniel

> Depends on:
> - next-20140804 branch of linux-next kernel tree
> - [PATCH v5][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35262.html)
> - [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34282.html)
>
> Changes since v4:
> - rebased on top of next-20140804 +
>    [PATCH v5][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35262.html)
>    [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34282.html)
> - call exynos_save_cp15() only on A9 type core (this is needed for the future
>    Exynos3250 SoC support)
>
> Changes since v3:
> - rebased on top of next-20140804 +
>    [PATCH v4][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35192.html)
>    [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34282.html)
> - (re-)added patch fixing S5P_CENTRAL_SEQ_OPTION register setup
>
> Changes since v2:
> - rebased on top of next-20140708 +
>    [PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html)
>    [with rejects fixed]
>    [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on Exynos4210 and 5250
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32808.html)
>    [PATCH 0/2] Firmware-assisted suspend/resume of Exynos SoCs
>    (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32991.html)
>    [with rejects fixed in patch #2]
> - addressed review comments from Tomasz Figa and Daniel Lezcano
>
> Changes since v1:
> - synced against next-20140602
> - added missing Acked-by-s
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (5):
>    ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
>    ARM: EXYNOS: add AFTR mode support to firmware do_idle method
>    ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
>    ARM: EXYNOS: PM: fix register setup for AFTR mode code
>    ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs
>
>   arch/arm/include/asm/firmware.h |  2 +-
>   arch/arm/mach-exynos/common.h   |  5 ++++
>   arch/arm/mach-exynos/exynos.c   |  4 ++-
>   arch/arm/mach-exynos/firmware.c | 34 ++++++++++++++++-------
>   arch/arm/mach-exynos/pm.c       | 60 ++++++++++++++++++++++++-----------------
>   5 files changed, 70 insertions(+), 35 deletions(-)
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
