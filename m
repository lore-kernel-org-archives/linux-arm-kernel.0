From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 21 Oct 2014 13:26:09 +0200
Subject: [GIT PULL 2/3] 1st Round of Samsung PM updates for v3.19
In-Reply-To: <54453033.6050004@samsung.com>
References: <54453033.6050004@samsung.com>
Message-ID: <8519968.z1P556eej9@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, October 21, 2014 12:54:27 AM Kukjin Kim wrote:
> Hi,
> 
> Same, I've just rebased for Samsung PM updates for v3.19.
> Please pull.

Unfortunately this pull request has the same issue that caused Arnd to
refuse the pull for v3.18:

  https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37320.html

You can find the fix for the issue at the bottom of this mail.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks,
> Kukjin
> 
> ---
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>    Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/samsung-pm
> 
> for you to fetch changes up to b588aaec6d0d846c88bfa2ba95e76147386a4cd6:
> 
>    ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250 
> (2014-10-21 00:06:36 +0900)
> 
> ----------------------------------------------------------------
> Samsung PM updates for v3.19
> 
> - Refactor the pm code to use DT based lookup instead of
>    using "soc_is_exynosxxxx"
> 
> - Firmware supporting suspend and resume to excute of low
>    level operations to enter and leave power mode for exynos
>    : introduce suspend() and resume() firmware operations
> 
> - Fix AFTR mode on boards with secure firmware enabled and
>    allows exynos cpuidle driver usage on exynos4x12 SoCs
> 
> - Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y
> 
> - SWRESET is needed to boot secondary CPU on exynos3250
> 
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (6):
>        ARM: EXYNOS: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
>        ARM: firmware: add AFTR mode support to firmware do_idle method
>        ARM: EXYNOS: add secure firmware support to AFTR mode code
>        ARM: EXYNOS: fix register setup for AFTR mode code
>        ARM: EXYNOS: allow driver usage on Exynos4x12 SoCs
>        ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y
> 
> Krzysztof Kozlowski (1):
>        ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250
> 
> Tomasz Figa (2):
>        ARM: firmware: Introduce suspend and resume operations
>        ARM: EXYNOS: Add support for firmware-assisted suspend/resume
> 
> Vikas Sajjan (2):
>        ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 
> to pmu.c
>        ARM: EXYNOS: Refactor the pm code to use DT based lookup
> 
>   Documentation/arm/firmware.txt         |  28 +--
>   arch/arm/include/asm/firmware.h        |  10 +-
>   arch/arm/mach-exynos/Kconfig           |   5 +
>   arch/arm/mach-exynos/Makefile          |   6 +-
>   arch/arm/mach-exynos/common.h          |  13 ++
>   arch/arm/mach-exynos/exynos.c          |   5 +-
>   arch/arm/mach-exynos/firmware.c        |  65 +++++-
>   arch/arm/mach-exynos/platsmp.c         |  23 +++
>   arch/arm/mach-exynos/pm.c              | 310 ++++------------------------
>   arch/arm/mach-exynos/pmu.c             |   1 +
>   arch/arm/mach-exynos/regs-pmu.h        |   3 +
>   arch/arm/mach-exynos/sleep.S           |  28 +++
>   arch/arm/mach-exynos/smc.h             |   4 +
>   arch/arm/mach-exynos/suspend.c         | 356 
> +++++++++++++++++++++++++++++++++
>   arch/arm/mach-tegra/cpuidle-tegra114.c |   2 +-
>   arch/arm/plat-samsung/Makefile         |   1 +
>   16 files changed, 559 insertions(+), 301 deletions(-)
>   create mode 100644 arch/arm/mach-exynos/suspend.c

From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: EXYNOS: Fix build with ARM_CPU_SUSPEND=n

"ARM: EXYNOS: Add support for firmware-assisted suspend/resume" patch
added to arch/arm/mach-exynos/firmware.c new references to functions
from arch/arm/mach-exynos/sleep.S causing the new CONFIG_PM_SLEEP=n
build breakages.  Then "ARM: EXYNOS: Fix build with PM_SLEEP=n and
ARM_EXYNOS_CPUIDLE=y" patch tried to fix the CONFIG_PM_SLEEP=n issues
by always building sleep.S which caused the CONFIG_ARM_CPU_SUSPEND=n
build breakage.  Fix it by building arch/arm/mach-exynos/sleep.o only
for CONFIG_EXYNOS_CPU_SUSPEND=y and adding appropriate IS_ENABLED()
checks to arch/arm/mach-exynos/firmware.c.

From: Arnd Bergmann <arnd@arndb.de>
[b.zolnierkie: fixed ->resume check and added patch description]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Makefile   |    4 ++--
 arch/arm/mach-exynos/firmware.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: b/arch/arm/mach-exynos/Makefile
===================================================================
--- a/arch/arm/mach-exynos/Makefile	2014-10-07 18:27:43.023737860 +0200
+++ b/arch/arm/mach-exynos/Makefile	2014-10-21 13:14:32.827064742 +0200
@@ -9,9 +9,9 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) +=
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o sleep.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
 
-obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o
+obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 
Index: b/arch/arm/mach-exynos/firmware.c
===================================================================
--- a/arch/arm/mach-exynos/firmware.c	2014-10-07 18:27:43.023737860 +0200
+++ b/arch/arm/mach-exynos/firmware.c	2014-10-21 13:14:32.827064742 +0200
@@ -129,11 +129,11 @@ static int exynos_resume(void)
 }
 
 static const struct firmware_ops exynos_firmware_ops = {
-	.do_idle		= exynos_do_idle,
+	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_do_idle : NULL,
 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
 	.cpu_boot		= exynos_cpu_boot,
-	.suspend		= exynos_suspend,
-	.resume			= exynos_resume,
+	.suspend		= IS_ENABLED(CONFIG_PM_SLEEP) ? exynos_suspend : NULL,
+	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
 };
 
 void __init exynos_firmware_init(void)
