From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 03 May 2014 10:52:20 +0900
Subject: [PATCH v3 00/12] ARM: Exynos: PMU cleanup and refactoring for
 using DT
In-Reply-To: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
References: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53644BD4.4060200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gentle ping.

Tomasz, Kukjin will you please have a look on this series.


Thanks,
Pankaj Dubey

On 04/30/2014 02:17 PM, Pankaj Dubey wrote:
> This patch series, does some minor cleanup of exynos machine files.
> It also modifies Exynos Power Management Unit (PMU) related code for
> converting it into a platform_driver.
> This is also preparation for moving PMU related code out of machine
> folder into a either "drivers/mfd", or "drivers/power" or some other
> suitable place so that ARM64 based SoC can utilize common piece of code.
> These patches require change in Exynos SoC dtsi files, which has been
> posted as separate patch series [2]
>
> These patches are created on top of Kukjin Kim's for-next (v3.15-rc1 tag)
> branch and on top of Daniel Lezcano's Exynos cpuidle refactor patches [3].
>
> These patches depends on following three patch series:
> [1] mfd: syscon: Support early initialization
>      https://lkml.org/lkml/2014/4/8/239
> [2] Add PMU node for Exynos SoCs
>      http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg29329.html
> [3] http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29085
>
> We have tested these patches on SMDK5250 board for System boot and
> Arndale (Exynos5250) board for System boot and PMU initialization and S2R.
>
> For testing on Arndale (Exynos5250) board:
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> Changes Since v2:
>   - Rebased on top of Daniel Lezcano's Exynos cpuidle refactor patches.
>   - Removed exynos_cpuidle_init and exynos_cpufreq_init code as suggested
>     by Tomasz Figa.
>   - Removed early mapping of PMU base address from exynos.c and removed
>     "get_exynos_pmuaddr" function. Instead of this added code in platsmp.c
>     to get PMU base address using of_iomap as suggested by Tomasz Figa.
>   - Converted PMU implementation into platform_driver by using static
>     platform_device method.
>
> Changes Since v1:
>   - Rebased on latest for-next of Kukjin Kim's tree.
>   - Added patch: "Make exynos machine_ops as static".
> 	For making more cleanup in "mach-exynos/common.h"
> 	as suggested by Tomasz Figa.
>   - Addressed comments of Tomasz Figa for cleaning "mach-exynos/common.h".
>   - Updated patch: Remove file path from comment section
> 	As suggested by Michel Simek, instead of updating file path
> 	lets remove them from each file under "mach-exynos".
> 	Even though Kukjin pointed out that there is similar patch pending from
> 	Sachin/Tushar but since I could not find I have included this here. If
> 	I have missed something please point to any existing such patch.
>   - Updated patch: Add support for mapping PMU base address via DT
> 	- Removed __initdata from declaration of "exynos_pmu_base", as it caused
> 	kernel crash as pointed out by Vikas Sajjan.
> 	- Added support for Syscon initialization and getting PMU regmap handle
> 	as suggested by Sylwester. Since current implementation of early
> 	intialization [1] has limitation that "early_syscon_init" requires
> 	DT to be unflattened and system should be able to allocate memory,
> 	we can't use regmap handles for platsmp.c file as "smp_secondary_init"
> 	will be called before DT unflattening. So I have kept both method for
> 	accessing PMU base address. platsmp.c will use ioremmaped address where
> 	as rest other files can use regmap handle.
>   - Added patch: Remove "linux/bug.h" from pmu.c.
>   - Updated patch: Refactored code for PMU register mapping via DT
> 	- Modified to use regmap_read/write when using regmap handle.
>   - Added patch: Move "mach/map.h" inclusion from regs-pmu.h to platsmp.c
>   - Added patch: Add device tree based initialization support for PMU.
> 	- Convert existing PMU implementation to be a device tree based
> 	 before moving it to "drivers/mfd" folder. As suggested by Bartlomiej.
> 	- Dropped making a platform_driver for PMU, as currently PMU binding
> 	has two compatibility strings as "samsung, exynosxxx-pmu", "syscon",
> 	once we	enable MFD_SYSCON config option, current "syscon" driver probe
> 	gets called and PMU probe never gets called. So modified PMU
> 	initialization code to scan DT and match against supported compatiblity
> 	string in driver code, and once we get matching node use that for
> 	accessing PMU regmap handle using "syscon_early_regmap_lookup_by_phandle".
> 	If there is any better solution please suggest.
>
> Pankaj Dubey (8):
>    ARM: EXYNOS: Make exynos machine_ops as static
>    ARM: EXYNOS: Move cpufreq and cpuidle device registration to
>      init_machine
>    ARM: EXYNOS: Cleanup "mach-exynos/common.h" file
>    ARM: EXYNOS: Remove file path from comment section
>    ARM: EXYNOS: Remove "linux/bug.h" from pmu.c
>    ARM: EXYNOS: Refactored code for using PMU address via DT
>    ARM: EXYNOS: Move "mach/map.h" inclusion from regs-pmu.h to platsmp.c
>    ARM: EXYNOS: Add platform driver support for Exynos PMU.
>
> Young-Gun Jang (4):
>    ARM: EXYNOS: Move SYSREG definition into sys-reg specific file.
>    ARM: EXYNOS: Remove regs-pmu.h header dependency from pm_domain
>    ARM: EXYNOS: Add support for mapping PMU base address via DT
>    ARM: EXYNOS: Move PMU specific definitions from common.h
>
>   arch/arm/mach-exynos/Kconfig                 |    2 +
>   arch/arm/mach-exynos/common.h                |   28 +-
>   arch/arm/mach-exynos/exynos-pmu.h            |   31 ++
>   arch/arm/mach-exynos/exynos.c                |   84 +++--
>   arch/arm/mach-exynos/headsmp.S               |    2 -
>   arch/arm/mach-exynos/hotplug.c               |    7 +-
>   arch/arm/mach-exynos/include/mach/map.h      |    3 -
>   arch/arm/mach-exynos/include/mach/memory.h   |    3 +-
>   arch/arm/mach-exynos/platsmp.c               |   42 ++-
>   arch/arm/mach-exynos/pm.c                    |   79 ++--
>   arch/arm/mach-exynos/pm_domains.c            |    8 +-
>   arch/arm/mach-exynos/pmu.c                   |  285 +++++++++++---
>   arch/arm/mach-exynos/regs-pmu.h              |  512 +++++++++++++-------------
>   arch/arm/mach-exynos/regs-sys.h              |   22 ++
>   arch/arm/plat-samsung/include/plat/map-s5p.h |    1 -
>   15 files changed, 680 insertions(+), 429 deletions(-)
>   create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>   create mode 100644 arch/arm/mach-exynos/regs-sys.h
>


-- 
Best Regards,
Pankaj Dubey
