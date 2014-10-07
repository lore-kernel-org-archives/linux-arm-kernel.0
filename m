From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 07 Oct 2014 10:53:30 +0900
Subject: [PATCH v9 0/2] ARM: Exynos: Convert PMU implementation into a
 platform driver
In-Reply-To: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
References: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <009f01cfe1d1$7eb21c10$7c165430$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> This patch series, modifies Exynos Power Management Unit (PMU) related code
> for converting it into a platform_driver. This is also preparation for moving
> PMU related code out of machine folder into a either "drivers/mfd", or
> "drivers/power" or some other suitable place so that ARM64 based SoC can
> utilize common piece of code.
> 
> These patches are created on top of Kukjin Kim's for-next.
> 
> Vikas Sajjan have tested these patches on Exynos5420 based Peach board for
> system boot and S2R.
> 
> This patch series depends on following patch series:
> [1]: mfd: syscon: Decouple syscon interface from syscon devices.
>      https://lkml.org/lkml/2014/9/30/156
> 
> Patch v8 and discussion can be found here:
> http://www.spinics.net/lists/arm-kernel/msg366831.html
> 
> Change since v8:
>  - Changed __raw_readl/writel into readl/writel_relaxed as suggested by Arnd.
> 
> Change since v7:
>  - Removing registration of syscon provider. As it will be handled now by
>    syscon patch [1].
>  - Rebased on top of latest kgene/for-next.
> 
> Change since v6:
>  - Removed NULL check for pmu_data in pmu.c.
>  - Moved pmu_raw_readl and pmu_raw_writel inline helper function
>    into common.h.
> 
> Change Since v5:
>  - Squashed patch "Move "mach/map.h" inclusion from regs-pmu.h to platsmp.c"
>    into patch "Refactored code for using PMU address via DT".
>  - Addressed review comments from Tomasz Figa.
>  - Using init_irq machine function to initialize PMU mapping instead
>    of init_time.
>  - Rebased on latest Kukjin Kim's for-next branch.
> 
> Changes Since v4:
>  - Splitted patch series in two parts. Part 1 has code cleanup under mach-exynos
>    and posted as separate patch [2]. Current patchset is part 2 which modified
>    exynos pmu implementation for making it platform driver.
>  - Removed dependency over early_syscon API.
>  - Removed usage of regmap read/write APIs.
>  - Modified probe function to register exynos pmu as syscon provider using
>    Tomasz Figa's syscon patch [1].
>  - Address various other review comments from Tomasz Figa.
>  - Removed signed-off-by of Young-Gun Jang <yg1004.jang@samsung.com>,
>    as this id is no more valid. Taking ownership of all his patches.
> 
> Changes Since v3:
>  - Optimized exynos_pmu_probe function by removing exynos_pmu_data_init
>    as suggested by Vikas Sajjan.
>  - Modified syscon_early_regmap_lookup_by_phandle and
>    syscon_regmap_lookup_by_phandle function call to pass property as NULL.
> 
> Changes Since v2:
>  - Rebased on top of Daniel Lezcano's Exynos cpuidle refactor patches.
>  - Removed early mapping of PMU base address from exynos.c and removed
>    "get_exynos_pmuaddr" function. Instead of this added code in platsmp.c
>    to get PMU base address using of_iomap as suggested by Tomasz Figa.
>  - Converted PMU implementation into platform_driver by using static
>    platform_device method.
> 
> Changes Since v1:
>  - Rebased on latest for-next of Kukjin Kim's tree.
>  - Updated patch: Add support for mapping PMU base address via DT
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
>  - Updated patch: Refactored code for PMU register mapping via DT
> 	- Modified to use regmap_read/write when using regmap handle.
>  - Added patch: Add device tree based initialization support for PMU.
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
> 
> Pankaj Dubey (2):
>   ARM: EXYNOS: Add platform driver support for Exynos PMU
>   ARM: EXYNOS: Move PMU specific definitions from common.h
> 
>  arch/arm/mach-exynos/Kconfig      |    1 +
>  arch/arm/mach-exynos/common.h     |   17 ----
>  arch/arm/mach-exynos/exynos-pmu.h |   24 +++++
>  arch/arm/mach-exynos/pm.c         |    1 +
>  arch/arm/mach-exynos/pmu.c        |  191 ++++++++++++++++++++++++++++---------
>  arch/arm/mach-exynos/suspend.c    |    1 +
>  6 files changed, 175 insertions(+), 60 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
> 
> --
> 1.7.9.5

Hi Pankaj,

Thanks for your addressing and looks good to me.

I'll queue this series after -rc1 release.

- Kukjin
