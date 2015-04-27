From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 27 Apr 2015 13:27:10 -0700
Subject: [PATCH 0/3] Introduce SET_NOIRQ_SYSTEM_SLEEP_PM_OPS and use it
In-Reply-To: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Message-ID: <553E9B9E.4080401@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/27/2015 11:24 AM, grygorii.strashko at linaro.org wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> While working on suspend-to-disk functionality on TI dra7-evm (DRA7xx SoC)
> i've found that the most common problem I have to dial with is absence
> of corresponding PM callbacks in drivers and, in particular, noirq callbacks.
> So, I've fixed one driver first
> commit 6248015d6867 "ARM: omap-device: add missed callback for suspend-to-disk"
> but then found another one which need to be fixed too (omap_l3_noc.c).
> At this moment I decided to make my life easier and added new macro
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS using the same approach as for the existing
> SET_SYSTEM_SLEEP_PM_OPS macro.
>
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS: defined for CONFIG_PM_SLEEP and
> assigns ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
> function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
> ->restore_noirq.
>
> Further two patches reuse this newly introduced macro.
>
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
>      point ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
>      function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
>      ->restore_noirq.
>
[...]

>
> Grygorii Strashko (3):
>    PM / Sleep: Add macro to define common noirq system PM callbacks
>    bus: omap_l3_noc: add missed callbacks for suspend-to-disk
>    ARM: omap-device: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
>
>   arch/arm/mach-omap2/omap_device.c |  7 ++-----
>   drivers/bus/omap_l3_noc.c         |  4 ++--
>   include/linux/pm.h                | 12 ++++++++++++
>   3 files changed, 16 insertions(+), 7 deletions(-)
>
Looks fine to me.....
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
