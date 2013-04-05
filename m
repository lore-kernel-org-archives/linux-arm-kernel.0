From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:42 -0600
Subject: [GIT PULL 4/8] ARM: tegra: core SoC support development
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes major development on the core Tegra SoC support code
in the mach-tegra directory:

* SMP support for Tegra114.
* Exposes SoC chip ID and revision through standard sysfs files.
* System-level suspend/resume for Tegra20/30. At present, this only
  supports "LP2" mode (CPU power-down), but provides the basis to
  implement "LP0"/"LP1" (various levels of core/chip power-down) in the
  hopefully near future.
* A minor cleanup of a duplicate include, which was introduced in this
  branch.

This branch is based on the previous cleanup pull request.

----------------------------------------------------------------

The following changes since commit 7e56474456221541aab7b2fe415ff400d7c9910a:

  ARM: tegra: replace the CPU power on function with PMC call

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-soc

for you to fetch changes up to 38be85de698ef3f2755ee0eabf520530757860aa:

  ARM: tegra: pm: remove duplicated include from pm.c

----------------------------------------------------------------

Danny Huang (2):
      ARM: tegra: expose chip ID and revision
      ARM: tegra: add speedo-based process id for Tegra114

Joseph Lo (8):
      ARM: tegra: bring up secondary CPU for Tegra114
      ARM: tegra: add clock source of PMC to device trees
      ARM: tegra: moving the CPU power timer function to PMC driver
      gpio: tegra: add gpio wakeup source handling
      ARM: tegra: irq: add wake up handling
      ARM: dt: tegra: add bindings of power management configurations for PMC
      ARM: tegra: pm: add platform suspend support
      ARM: tegra: cpuidle: remove redundant parameters for powered-down mode

Wei Yongjun (1):
      ARM: tegra: pm: remove duplicated include from pm.c

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt   |   67 +++++++-
 arch/arm/Kconfig                                |    1 +
 arch/arm/boot/dts/tegra114-dalmore.dts          |   13 ++
 arch/arm/boot/dts/tegra114-pluto.dts            |   13 ++
 arch/arm/boot/dts/tegra114.dtsi                 |    2 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |   13 ++
 arch/arm/boot/dts/tegra20-harmony.dts           |   13 ++
 arch/arm/boot/dts/tegra20-paz00.dts             |   13 ++
 arch/arm/boot/dts/tegra20-seaboard.dts          |   13 ++
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |   13 ++
 arch/arm/boot/dts/tegra20-trimslice.dts         |   13 ++
 arch/arm/boot/dts/tegra20-ventana.dts           |   13 ++
 arch/arm/boot/dts/tegra20-whistler.dts          |   13 ++
 arch/arm/boot/dts/tegra20.dtsi                  |    2 +
 arch/arm/boot/dts/tegra30-beaver.dts            |   13 ++
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   13 ++
 arch/arm/boot/dts/tegra30.dtsi                  |    2 +
 arch/arm/mach-tegra/Makefile                    |    1 +
 arch/arm/mach-tegra/common.c                    |    5 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c           |    6 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c           |    6 +-
 arch/arm/mach-tegra/fuse.c                      |    4 +
 arch/arm/mach-tegra/fuse.h                      |    7 +
 arch/arm/mach-tegra/irq.c                       |   96 ++++++++++-
 arch/arm/mach-tegra/irq.h                       |    6 +
 arch/arm/mach-tegra/platsmp.c                   |    8 +
 arch/arm/mach-tegra/pm.c                        |  131 ++++++++------
 arch/arm/mach-tegra/pm.h                        |   17 +-
 arch/arm/mach-tegra/pmc.c                       |  162 ++++++++++++++++++
 arch/arm/mach-tegra/pmc.h                       |   14 ++
 arch/arm/mach-tegra/tegra.c                     |   29 +++-
 arch/arm/mach-tegra/tegra114_speedo.c           |  104 +++++++++++
 drivers/gpio/gpio-tegra.c                       |   21 ++-
 33 files changed, 780 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra114_speedo.c
