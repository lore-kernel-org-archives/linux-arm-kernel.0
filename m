From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 11:20:26 -0600
Subject: [GIT PULL 2/4] ARM: tegra: core SoC enhancements for 3.12
In-Reply-To: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1376673628-5867-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes a number of enhancements to core SoC support for
Tegra devices. The major new features are:

* Adds a new CPU-power-gated cpuidle state for Tegra114.
* Adds initial system suspend support for Tegra114, initially supporting
  just CPU-power-gating during suspend.
* Adds "LP1" suspend mode support for all of Tegra20/30/114. This mode
  both gates CPU power, and places the DRAM into self-refresh mode.
* A new DT-driven PCIe driver to Tegra20/30. The driver is also moved
  from arch/arm/mach-tegra/ to drivers/pci/host/.

The PCIe driver work depends on the following tag from Thomas Petazzoni:
git://git.infradead.org/linux-mvebu.git mis-3.12.2
... which is merged into the middle of this pull request.

----------------------------------------------------------------

(If the location of the merge into this branch is problematic, just let
me know and I'll rebase everything on top of the merge)

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.12-soc

for you to fetch changes up to b4f173752a56187bd55752b0474429202f2ab1d3:

  ARM: tegra: disable LP2 cpuidle state if PCIe is enabled

----------------------------------------------------------------

Jay Agarwal (1):
      PCI: tegra: Add Tegra 30 PCIe support

Joseph Lo (21):
      ARM: tegra: enable Cortex-A15 erratum 798181
      Revert "ARM: tegra: add cpu_disable for hotplug"
      ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM entry
      ARM: tegra114: add low level support for CPU idle powered-down mode
      ARM: tegra114: cpuidle: add powered-down state
      ARM: tegra: do v7_invalidate_l1 only when CPU is Cortex-A9
      ARM: tegra: add a flag for tegra_disable_clean_inv_dcache to do LoUIS or ALL
      ARM: tegra: set up the correct L2 data RAM latency for Cortex-A15
      ARM: tegra: add low level code for Tegra114 cluster power down
      ARM: tegra: shut off the CPU rail when the last CPU in suspend
      ARM: tegra: hook tegra_tear_down_cpu function
      ARM: tegra: flowctrl: add support for cpu_suspend_enter/exit
      clk: tegra: add suspend/resume function for tegra_cpu_car_ops
      ARM: tegra: remove the limitation that Tegra114 can't support suspend
      ARM: tegra: add common resume handling code for LP1 resuming
      ARM: tegra: config the polarity of the request of sys clock
      clk: tegra114: add LP1 suspend/resume support
      ARM: tegra: add common LP1 suspend support
      ARM: tegra: add LP1 suspend support for Tegra30
      ARM: tegra: add LP1 suspend support for Tegra20
      ARM: tegra: add LP1 suspend support for Tegra114

Stephen Warren (4):
      ARM: tegra: unify Tegra's Kconfig a bit more
      Merge tag 'msi-3.12-2' into for-3.12/soc
      PCI: tegra: set up PADS_REFCLK_CFG1
      ARM: tegra: disable LP2 cpuidle state if PCIe is enabled

Thierry Reding (3):
      PCI: tegra: Move PCIe driver to drivers/pci/host
      MAINTAINERS: Add myself as Tegra PCIe maintainer

(and the following from the dependency branch)

Thierry Reding (3):
      PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (5):
      PCI: use weak functions for MSI arch-specific functions
      PCI: remove ARCH_SUPPORTS_MSI kconfig option
      of: pci: add registry of MSI chips
      ARM: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
      PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms

 .../bindings/pci/nvidia,tegra20-pcie.txt        |  163 ++
 MAINTAINERS                                     |    7 +
 arch/arm/Kconfig                                |    1 -
 arch/arm/include/asm/mach/pci.h                 |    4 +
 arch/arm/kernel/bios32.c                        |   16 +
 arch/arm/mach-tegra/Kconfig                     |   29 +-
 arch/arm/mach-tegra/Makefile                    |    6 +-
 arch/arm/mach-tegra/board-harmony-pcie.c        |   89 -
 arch/arm/mach-tegra/board.h                     |    8 -
 arch/arm/mach-tegra/common.h                    |    1 -
 arch/arm/mach-tegra/cpuidle-tegra114.c          |   51 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   12 +
 arch/arm/mach-tegra/cpuidle.c                   |   10 +
 arch/arm/mach-tegra/cpuidle.h                   |    1 +
 arch/arm/mach-tegra/flowctrl.c                  |    2 +
 arch/arm/mach-tegra/flowctrl.h                  |    9 +
 arch/arm/mach-tegra/headsmp.S                   |    3 +-
 arch/arm/mach-tegra/hotplug.c                   |   13 +-
 arch/arm/mach-tegra/iomap.h                     |   11 +-
 arch/arm/mach-tegra/irq.c                       |   40 +
 arch/arm/mach-tegra/pcie.c                      |  886 ---------
 arch/arm/mach-tegra/platsmp.c                   |    1 -
 arch/arm/mach-tegra/pm-tegra20.c                |   34 +
 arch/arm/mach-tegra/pm-tegra30.c                |   34 +
 arch/arm/mach-tegra/pm.c                        |  148 +-
 arch/arm/mach-tegra/pm.h                        |   12 +
 arch/arm/mach-tegra/pmc.c                       |   53 +-
 arch/arm/mach-tegra/pmc.h                       |    3 +
 arch/arm/mach-tegra/reset-handler.S             |   21 +-
 arch/arm/mach-tegra/reset.c                     |    2 +
 arch/arm/mach-tegra/reset.h                     |    4 +
 arch/arm/mach-tegra/sleep-tegra20.S             |  297 +++
 arch/arm/mach-tegra/sleep-tegra30.S             |  616 ++++++-
 arch/arm/mach-tegra/sleep.S                     |   37 +-
 arch/arm/mach-tegra/sleep.h                     |   14 +-
 arch/arm/mach-tegra/tegra.c                     |   24 -
 arch/ia64/Kconfig                               |    1 -
 arch/mips/Kconfig                               |    2 -
 arch/mips/include/asm/pci.h                     |    5 -
 arch/powerpc/Kconfig                            |    1 -
 arch/powerpc/include/asm/pci.h                  |    5 -
 arch/s390/Kconfig                               |    1 -
 arch/s390/include/asm/pci.h                     |    4 -
 arch/sparc/Kconfig                              |    1 -
 arch/tile/Kconfig                               |    1 -
 arch/x86/Kconfig                                |    1 -
 arch/x86/include/asm/pci.h                      |   30 -
 arch/x86/kernel/x86_init.c                      |   24 +
 drivers/clk/tegra/clk-tegra114.c                |   38 +
 drivers/of/of_pci.c                             |   45 +
 drivers/pci/Kconfig                             |    4 -
 drivers/pci/host/Kconfig                        |    4 +
 drivers/pci/host/Makefile                       |    1 +
 drivers/pci/host/pci-tegra.c                    | 1702 ++++++++++++++++++
 drivers/pci/msi.c                               |   85 +-
 drivers/pci/probe.c                             |    1 +
 include/linux/msi.h                             |   21 +-
 include/linux/of_pci.h                          |   12 +
 include/linux/pci.h                             |    1 +
 include/linux/tegra-cpuidle.h                   |   19 +
 60 files changed, 3521 insertions(+), 1150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 delete mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
 delete mode 100644 arch/arm/mach-tegra/pcie.c
 create mode 100644 arch/arm/mach-tegra/pm-tegra20.c
 create mode 100644 arch/arm/mach-tegra/pm-tegra30.c
 create mode 100644 drivers/pci/host/pci-tegra.c
 create mode 100644 include/linux/tegra-cpuidle.h
