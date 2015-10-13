From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 13 Oct 2015 10:32:05 +0200
Subject: [PATCH v2 0/2] Enabling PSCI based idle on ARM 32-bit platforms
In-Reply-To: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1444648628-24790-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <561CC185.60001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lorenzo,

I would like to take this patch through my tree but it does not apply.

Mind to refresh it against linux-pm or v4.3-rc5 ?

   -- Daniel


On 10/12/2015 01:17 PM, Lorenzo Pieralisi wrote:
> This patch series is v2 of a previous posting:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/373756.html
>
> v1->v2:
>
> - Refactored patch 1 to remove cpu parameter from cpuidle_ops
>    suspend hook
> - Refactored psci_cpu_init_idle to stub out dt parsing function and
>    make it usable on both ARM/ARM64 with no additional changes
> - Updated ARM cpuidle_ops to new interfaces
> - Fixed PSCI enable method string in ARM cpuidle_ops struct
>
> PSCI firmware provides a kernel API that, through a standard interface,
> allows to manage power states transitions in a seamless manner for
> ARM and ARM64 systems.
>
> Current PSCI code that initializes CPUidle states on PSCI based
> systems lives in arch/arm64 directory but it is not ARM64 specific
> and can be shared with ARM 32-bit systems so that the generic
> ARM CPUidle driver can leverage the common PSCI interface.
>
> This patch series moves PSCI CPUidle management code to
> drivers/firmware directory so that ARM and ARM64 architecture
> can actually share the code.
>
> It is made up of two patches:
>
> Patch 1 refactors ARM 32-bit generic idle implementation to remove
> the cpu parameter from the cpuidle_ops suspend hook, in preparation
> for a common PSCI implementation for ARM/ARM64 PSCI idle.
>
> Patch 2 moves ARM64 PSCI CPUidle functions implementation to
> drivers/firmware so that it can be shared with ARM 32-bit platforms
> code. This patch also adds a PSCI entry section on ARM 32-bit systems
> so that the PSCI CPUidle back-end can be enabled when the enable-method
> corresponds to PSCI.
>
> Patches apply on top of current patch stack to enable PSCI 1.0:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/firmware/psci-1.0
>
> Tested on Juno board (ARM64), compile tested only on ARM 32-bit systems.
>
> Lorenzo Pieralisi (2):
>    ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend hook
>    ARM64: kernel: PSCI: move PSCI idle management code to
>      drivers/firmware
>
>   arch/arm/include/asm/cpuidle.h |   2 +-
>   arch/arm/kernel/cpuidle.c      |   2 +-
>   arch/arm64/kernel/psci.c       |  99 +-----------------------------
>   drivers/firmware/Makefile      |   2 +-
>   drivers/firmware/psci_cpuops.c | 133 +++++++++++++++++++++++++++++++++++++++++
>   drivers/soc/qcom/spm.c         |  10 ++--
>   include/linux/psci.h           |   3 +
>   7 files changed, 146 insertions(+), 105 deletions(-)
>   create mode 100644 drivers/firmware/psci_cpuops.c
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
