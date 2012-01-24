From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:27 -0600
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
Message-ID: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a new common cpuidle interface to consolidate code
commonly duplicated by various platforms.  A patch was then made for each
platform that could immediately take advantage of this code.  The platform
specific changes are not required by the common code and are only made for
consoldation.

Maintainers and cpuidle idle developers of these platforms, please check to make
sure that you agree with the changes.  Besides just code consolidation, a
default "WFI" state is now used with default parameters that different from your
original paramenters. The assumption is that if you have a WFI only idle state,
the parameters in the new default WFI are more realistic as a true WFI only
hardware state incurs minimal latency(<1us) or power penalty to enter and exit.
If your platform actually performs other platform specific functionality upon
entering WFI and the default parameters do not accurately reflect the 
exit_latency and target_residency given in the common default state, please
say so.  Also, the default state uses a common name and description value
which may differ from the previous platform specific values you used.

Lastly, a imx5 cpuidle implementation is added which uses the common cpuidle
interface.

Based on 3.3-rc1

Tested on i.MX51 Babbage Board

v2 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199

Changes since v2:
* Made various code organization and style changes as suggested in v1 review.
* Removed at91 use of common code.  A separate effort is underway to clean
at91 code and the author has offered to convert to common interface as part
of those changes (if this common interface is accepted in time).
* Made platform cpuidle_driver objects __initdata and dynamically added one
persistent instance of this object in common code.
* Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed after
being enabled during clock initialization.
* Re-organized patches.

v1 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791

Changes since v1:
* Common interface moved to drivers/cpuidle and made non arch-specific.
* Made various fixes and suggested additions to the common cpuidle
code from v1 review.
* Added callback for filling in driver_data field as needed.
* Modified the various platforms with these changes.

Robert Lee (7):
  cpuidle: Add common init interface and idle functionality
  ARM: exynos: Modify to use new common cpuidle code.
  ARM: shmobile: Modify to use new common cpuidle code.
  ARM: kirkwood: Modify to use new common cpuidle code.
  ARM: davinci: Modify to use new common cpuidle code.
  ARM: imx: Init imx5 gpc_dvfs clock for global use
  ARM: imx: Add imx5 cpuidle implementation

 arch/arm/mach-davinci/cpuidle.c     |  135 ++++++++-----------------------
 arch/arm/mach-exynos/cpuidle.c      |   73 ++---------------
 arch/arm/mach-kirkwood/cpuidle.c    |   89 +++++---------------
 arch/arm/mach-mx5/Makefile          |    3 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +
 arch/arm/mach-mx5/cpuidle.c         |   64 +++++++++++++++
 arch/arm/mach-mx5/pm-imx5.c         |   24 +-----
 arch/arm/mach-shmobile/cpuidle.c    |   51 ++----------
 drivers/cpuidle/Makefile            |    2 +-
 drivers/cpuidle/common.c            |  152 +++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h             |   24 ++++++
 11 files changed, 319 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpuidle.c
 create mode 100644 drivers/cpuidle/common.c
