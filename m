From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 07 Jan 2012 15:40:53 +0530
Subject: [PATCH v2 0/2] ARM: Exynos: Adapt to generic power domain
Message-ID: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Added a OF wrapper around __pm_genpd_add_device as suggested by Rafael.
- Added cpu_relax and usleep_range during waits for power domain to be
  enabled/disabled.
- Added static registrations of devices to power domains for non-dt
  platforms.

The power domains available on Exynos4 are made controllable using the generic
power domain infrastructure. The Samsung specific power domain control code
for Exynos4 is removed. Support for both DT and non-DT Exynos platforms is
added.

The first patch adds device tree support for generic power domain. A device
node is added to the generic power domain strucure that represents a power
domain node in the device tree. Other device nodes in the device tree can
include a property with a phandle of the power domain node which will enable
that device to be associated with a power domain.

The second patch registers available power domains to generic power domain
framework with support for both dt and non-dt platforms. The Samsung specific
power domain control support is removed.

The patchset is based on the following tree
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

with all patches merged from
http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

Thomas Abraham (2):
  PM / Domains: Add OF support
  ARM: Exynos: Hook up power domains to generic power domain infrastructure

 arch/arm/mach-exynos/Kconfig               |   10 +--
 arch/arm/mach-exynos/Makefile              |    2 +-
 arch/arm/mach-exynos/dev-pd.c              |  139 ---------------------
 arch/arm/mach-exynos/mach-nuri.c           |   11 --
 arch/arm/mach-exynos/mach-origen.c         |   14 --
 arch/arm/mach-exynos/mach-smdkv310.c       |   12 --
 arch/arm/mach-exynos/mach-universal_c210.c |   17 ---
 arch/arm/mach-exynos/pm_domains.c          |  183 ++++++++++++++++++++++++++++
 drivers/base/power/domain.c                |   32 +++++
 include/linux/pm_domain.h                  |   12 ++
 10 files changed, 229 insertions(+), 203 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/dev-pd.c
 create mode 100644 arch/arm/mach-exynos/pm_domains.c
