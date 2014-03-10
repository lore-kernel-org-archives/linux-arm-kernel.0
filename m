From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Mar 2014 01:31:56 +0100
Subject: [PATCH v2 00/12] Samsung PM consolidation part 2 (multiplatform)
In-Reply-To: <53075164.8080800@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
 <53075164.8080800@samsung.com>
Message-ID: <531D07FC.2050805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.02.2014 14:15, Tomasz Figa wrote:
> Hi Kukjin,
>
> On 06.02.2014 20:12, Tomasz Figa wrote:
>> Current Samsung PM code is heavily unprepared for multiplatform systems.
>> The design implies accessing functions and global variables defined in
>> particular mach- subdirectory from common code in plat-, which is not
>> allowed when building ARCH_MULTIPLATFORM. In addition there is a lot of
>> forced code unification, which makes common function handle any possible
>> quirks of all supported SoCs. In the end this design turned out to not
>> work too well, ending with a lot of empty functions exported from mach-,
>> just because code in common pm.c calls them. Moreover, recent trend of
>> moving lower level suspend/resume code to proper drivers, like pinctrl
>> or clk, made a lot of code there redundant, especially on DT-only
>> platforms
>> like Exynos.
>>
>> This patch series attempts to untie Exynos PM support from the legacy
>> Samsung PM core and make it multiplatform-aware, by isolating truly
>> generic parts of the latter, making them multiplatform-friendly and then
>> reimplementing Exynos PM support in a multiplatform-capable way by using
>> those generic parts. The result is that now PM initialization is started
>> from mach-exynos*-dt, which calls Exynos-specific initialization code
>> that
>> registers platform_suspend_ops, so control flow is basically reversed
>> ending with mach- code calling more generic plat- code if needed.
>>
>> This is limited to Exynos right now, but remaining SoCs could follow
>> in further series.
>>
>> Depends on Samsung PM consolidation part 1 (clocks) series:
>>   - http://thread.gmane.org/gmane.linux.kernel.samsung-soc/26816
>>
>> On Exynos4210-based Trats, Exynos4412-based Trats2 and Exynos5250-based
>> Arndale boards (except suspend/resume, which is broken because of
>> unrelated reasons):
>>
>> Tested-by: Tomasz Figa <t.figa@samsung.com>
>>
>> Changes since v1 (RFC):
>>   - fixed l2x0 resume,
>>   - fixed checkpatch complaints (about issues in existing code being
>> moved),
>>   - rebased on top of current linux-next,
>>   - slightly reordered patches to make the order more logical.
>>
>> Tomasz Figa (12):
>>    ARM: EXYNOS: Do not resume l2x0 if not enabled before suspend
>>    ARM: SAMSUNG: Add soc_is_s3c2410() helper
>>    ARM: SAMSUNG: pm: Save UART DIVSLOT register based on SoC type
>>    ARM: SAMSUNG: pm: Use debug_ll_addr() to get UART base address
>>    ARM: SAMSUNG: pm: Consolidate PM debug functions
>>    ARM: SAMSUNG: pm: Move Samsung PM debug code into separate file
>>    ARM: SAMSUNG: Move common save/restore helpers to separate file
>>    ARM: SAMSUNG: pm: Move s3c_pm_check_* prototypes to plat/pm-common.h
>>    ARM: EXYNOS: Kconfig: Fix abuse of CONFIG_PM
>>    ARM: EXYNOS: Remove PM initcalls and useless indirection
>>    ARM: EXYNOS: Stop using legacy Samsung PM code
>>    ARM: exynos: Allow wake-up using GIC interrupts
>>
>>   arch/arm/mach-exynos/Kconfig                   |  16 +--
>>   arch/arm/mach-exynos/Makefile                  |   2 +-
>>   arch/arm/mach-exynos/common.c                  |   1 +
>>   arch/arm/mach-exynos/common.h                  |  14 ++
>>   arch/arm/mach-exynos/include/mach/pm-core.h    |  75 -----------
>>   arch/arm/mach-exynos/pm.c                      | 172
>> +++++++++++++++++++------
>>   arch/arm/mach-exynos/regs-pmu.h                |   2 +
>>   arch/arm/mach-exynos/sleep.S                   |  85 ++++++++++++
>>   arch/arm/mach-s3c64xx/pm.c                     |   1 -
>>   arch/arm/mach-s5p64x0/pm.c                     |   1 -
>>   arch/arm/plat-samsung/Makefile                 |   2 +
>>   arch/arm/plat-samsung/include/plat/cpu.h       |   6 +
>>   arch/arm/plat-samsung/include/plat/pm-common.h | 110 ++++++++++++++++
>>   arch/arm/plat-samsung/include/plat/pm.h        |  80 +-----------
>>   arch/arm/plat-samsung/pm-check.c               |   2 +-
>>   arch/arm/plat-samsung/pm-common.c              |  75 +++++++++++
>>   arch/arm/plat-samsung/pm-debug.c               |  98 ++++++++++++++
>>   arch/arm/plat-samsung/pm.c                     | 146
>> ---------------------
>>   arch/arm/plat-samsung/s5p-sleep.S              |  43 -------
>>   19 files changed, 531 insertions(+), 400 deletions(-)
>>   delete mode 100644 arch/arm/mach-exynos/include/mach/pm-core.h
>>   create mode 100644 arch/arm/mach-exynos/sleep.S
>>   create mode 100644 arch/arm/plat-samsung/include/plat/pm-common.h
>>   create mode 100644 arch/arm/plat-samsung/pm-common.c
>>   create mode 100644 arch/arm/plat-samsung/pm-debug.c
>>
>
> What do you think about this series?

A subtle ping.

Best regards,
Tomasz
