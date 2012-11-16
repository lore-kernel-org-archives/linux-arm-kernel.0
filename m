From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 12:43:57 -0700
Subject: [GIT PULL 5/6] ARM: tegra: single-zImage preparation work
In-Reply-To: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
References: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353095038-20031-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various cleanups and enhancements are made to core Tegra code towards the
aim of including Tegra in a multi-platform ARM kernel:

RTC, timer, and TWD are configured via device tree.

SPARSE_IRQ is enabled.

Tegra's debug_ll options are simplified, and the macros brought into
line with other multi-platform implementations, and moved to the new
common location.

Two headers still need to be eliminated in order to include Tegra in a
multi-platform kernel/ <mach/{clk,powergate}.h>. A new common API needs
to be invented to replace parts of clk.h. powergate.h might be replaced
by regulators; this needs more investigation.

This pull request is based on tegra-for-3.8-dt, followed by a merge of
arm-soc's devel/debug_ll_init branch.

----------------------------------------------------------------

The following changes since commit 9a2ab3f1fa01a146a395197153af0ae586e6a682:

  Merge remote-tracking branch 'korg_arm-soc/devel/debug_ll_init' into for-3.8/single-zimage

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.8-single-zimage

for you to fetch changes up to 460678035247a9f72a4401dfeb6513ee495bf975:

  ARM: tegra: move debug-macro.S to include/debug

----------------------------------------------------------------

Stephen Warren (11):
      ARM: tegra: define DT bindings for and instantiate timer
      ARM: tegra: define DT bindings for and instantiate RTC
      ARM: tegra: add TWD to device tree
      ARM: timer: fix checkpatch warnings
      ARM: tegra: enhance timer.c to get IRQ info from device tree
      ARM: tegra: enhance timer.c to get IO address from device tree
      ARM: tegra: select SPARSE_IRQ
      ARM: tegra: simplify DEBUG_LL UART selection options
      ARM: tegra: decouple uncompress.h and debug-macro.S
      ARM: tegra: don't include iomap.h from debug-macro.S
      ARM: tegra: move debug-macro.S to include/debug

 .../bindings/rtc/nvidia,tegra20-rtc.txt         |   19 ++
 .../bindings/timer/nvidia,tegra20-timer.txt     |   21 ++
 .../bindings/timer/nvidia,tegra30-timer.txt     |   23 ++
 arch/arm/Kconfig                                |    1 +
 arch/arm/Kconfig.debug                          |   38 +++
 arch/arm/boot/dts/tegra20.dtsi                  |   21 ++
 arch/arm/boot/dts/tegra30.dtsi                  |   23 ++
 arch/arm/include/debug/tegra.S                  |  223 ++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                     |   51 ----
 arch/arm/mach-tegra/common.c                    |    9 +-
 arch/arm/mach-tegra/include/mach/debug-macro.S  |  100 --------
 arch/arm/mach-tegra/include/mach/irqs.h         |  182 --------------
 arch/arm/mach-tegra/include/mach/uncompress.h   |   65 +----
 arch/arm/mach-tegra/io.c                        |    1 +
 arch/arm/mach-tegra/iomap.h                     |   14 --
 arch/arm/mach-tegra/irammap.h                   |    9 -
 arch/arm/mach-tegra/pcie.c                      |    3 +
 arch/arm/mach-tegra/timer.c                     |   78 ++++--
 18 files changed, 435 insertions(+), 446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
 create mode 100644 arch/arm/include/debug/tegra.S
 delete mode 100644 arch/arm/mach-tegra/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-tegra/include/mach/irqs.h
