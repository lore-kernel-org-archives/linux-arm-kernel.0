From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:13 +0200
Subject: [PATCH 00/24] PM / Domains: Generic OF-based support and cleanups
Message-ID: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parts of this patchset has been posted earlier. To be able to smoothly continue
my work in re-factoring genpd I have collected patches into this patchset.

The complete patchset is available at the linux-pm_linux-next_genpd branch at:
git.linaro.org/people/ulf.hansson/linux-2.6.git
This branch is based upon Rafael's linux-pm tree's linux-next branch.

And important note. There are dependencies througout this patchset, which means
the all need to go together. I suggest we use Rafael's tree, thus I seek for
acks from the affected ARM SoC maintainers.


Tomasz Figa (3):
  base: power: Add generic OF-based power domain look-up
  drivercore: Bind/unbind power domain on probe/remove
  ARM: exynos: Move to generic power domain bindings

Ulf Hansson (21):
  PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
  PM / Domains: Remove system PM callbacks from gpd_dev_ops
  ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd config
  ARM: shmobile: Drop dev_irq_safe from R-mobile genpd config
  PM / Domains: Remove dev_irq_safe from genpd config
  PM / Domains: Remove redundant check for CONFIG_PM
  PM / Domains: Remove legacy API for adding devices through DT
  PM / Domains: Remove pm_genpd_syscore_switch() API
  PM / Domains: Remove genpd_queue_power_off_work() API
  PM / Domains: Add late_initcall to disable unused domains
  ARM: exynos: Leave disabling of unused pm domains to genpd
  ARM: s3c64xx: Leave disabling of unused pm domains to genpd
  drivers: sh: Leave disabling of unused pm domains to genpd
  PM / Domains: Remove default_stop_ok() API
  dt: bindings: ux500: Add documentation for power domains
  dt: bindings: ux500: Add header for power domains specifiers
  ARM: ux500: Initial support for power domains
  ARM: ux500: Enable Kconfig for the generic power domain
  ARM: ux500: Add DT node for ux500 power domains
  ARM: ux500: Add sdi[n] devices to VAPE power domain

 .../bindings/arm/exynos/power_domain.txt           |   12 +-
 .../devicetree/bindings/arm/ux500/power_domain.txt |   35 ++
 .../devicetree/bindings/power/power_domain.txt     |   51 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   11 +
 arch/arm/mach-exynos/exynos.c                      |    1 -
 arch/arm/mach-exynos/pm_domains.c                  |   81 +--
 arch/arm/mach-s3c64xx/common.c                     |    5 -
 arch/arm/mach-s3c64xx/common.h                     |    7 -
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    1 -
 arch/arm/mach-s3c64xx/mach-real6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 -
 arch/arm/mach-s3c64xx/pm.c                         |    7 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |    1 -
 arch/arm/mach-shmobile/pm-rmobile.c                |    1 -
 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/Makefile                       |    1 +
 arch/arm/mach-ux500/pm.c                           |    4 +
 arch/arm/mach-ux500/pm_domains.c                   |   77 +++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +
 drivers/base/dd.c                                  |    9 +-
 drivers/base/power/domain.c                        |  638 ++++++++++----------
 drivers/base/power/domain_governor.c               |    7 +-
 drivers/sh/pm_runtime.c                            |   11 -
 include/dt-bindings/arm/ux500_pm_domains.h         |   15 +
 include/linux/pm_domain.h                          |  107 ++--
 kernel/power/Kconfig                               |    4 +
 33 files changed, 593 insertions(+), 520 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt
 create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

-- 
1.7.9.5
