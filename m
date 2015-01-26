From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Jan 2015 18:33:43 +0000
Subject: [PATCH v3 0/1] arm64: kernel: ARM64_CPU_SUSPEND clean-up
Message-ID: <1422297224-27834-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 => v3

- Fixed defconfig compilation issue by moving the cpu_suspend
  interface to arch/arm64/kernel/cpuidle.c
- Added cover letter description/reason for the clean-up
- Rebased against 3.19-rc6

v2:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311468.html

v1 => v2

- Rebased on top of
  commit e5e62d475274 ("arm64: psci: Fix build breakage without PM_SLEEP")

The arm64 config option ARM64_CPU_SUSPEND was introduced so that code
required to save/restore CPU context could be selectively compiled in
the kernel.

Since ARM64_CPU_SUSPEND selected code is needed only if CONFIG_SUSPEND or
CONFIG_CPU_IDLE are selected in turn, and the CPU_PM config option already
represents those config cases, this patch removes the ARM64_CPU_SUSPEND config
option and reshuffles the code so that it is compiled by the kernel subsystem
only when it is needed.

On arm64 systems, the current arch API used by the CPUidle driver is:

cpu_suspend(index)

where index corresponds to the idle state index that should be entered
upon cpu_suspend() call. Since the cpu_suspend() function is the CPUidle
interface to arch code, it should be compiled in only if CPU_IDLE is
enabled, so the respective code is moved to the CPUidle specific compilation
unit. Since the ARM64_CPU_SUSPEND is removed, and it was used to selectively
compile CPU operations like cpu_suspend() (which in turn represents the
glue code used by the cpu_suspend() interface), the preprocessor macros
should be changed and updated to the current usage, which means that
the cpu_suspend CPU operation is compiled in only if CPU_IDLE is enabled
in the kernel.

A subsequent patch series will rename the cpu_suspend function, the
cpu_suspend CPU operations hook and the functions implementing save/restore
code so that the naming scheme would become more coherent and the CPUidle
arch interfaces for arm and arm64 kernel could follow the same naming
scheme, when it is settled in stone.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>

Lorenzo Pieralisi (1):
  arm64: kernel: remove ARM64_CPU_SUSPEND config option

 arch/arm64/Kconfig                |  3 ---
 arch/arm64/include/asm/cpu_ops.h  |  8 ++++----
 arch/arm64/include/asm/cpuidle.h  |  6 ++++++
 arch/arm64/include/asm/suspend.h  |  2 --
 arch/arm64/kernel/Makefile        |  2 +-
 arch/arm64/kernel/asm-offsets.c   |  2 +-
 arch/arm64/kernel/cpuidle.c       | 20 ++++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c |  2 +-
 arch/arm64/kernel/psci.c          |  2 --
 arch/arm64/kernel/suspend.c       | 21 ---------------------
 arch/arm64/mm/proc.S              |  2 +-
 drivers/cpuidle/Kconfig.arm64     |  1 -
 drivers/cpuidle/cpuidle-arm64.c   |  1 -
 13 files changed, 34 insertions(+), 38 deletions(-)

-- 
2.2.1
