From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Apr 2015 16:22:13 +0200
Subject: [GIT PULL v2 1/2] ARM: tegra: Core code changes for v4.1-rc1
In-Reply-To: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428675733-23523-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.1-soc-20150410

for you to fetch changes up to 50ce434c2399586a71a868795401b59e04486824:

  memory: tegra: Explicitly mark defines unsigned (2015-04-03 00:01:09 +0200)

This is essentially the same as the earlier pull requests, except that
it contains fixes for the linux-next build errors reported by Mark
Brown.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core code changes for v4.1-rc1

The biggest chunk of these changes is Mikko and Tomeu's external memory
controller driver. It allows the frequency of the external memory to be
changed and also puts the initial pieces into place to enable automatic
scaling of the EMC frequency.

There are also a couple of improvements such as the move to a restart
handler to make it easier for boards to override restart behaviour in a
board-specific way. There are also some preparatory patches to enable
Tegra to run in big-endian mode.

Finally there's a fix for a regression that was introduced in v3.17,
causing suspend/resume to break.

----------------------------------------------------------------
Bob Mottram (1):
      gpio: tegra: Maintain endianness

David Riley (1):
      soc/tegra: pmc: move to using a restart handler

Dmitry Osipenko (1):
      ARM: tegra20: Store CPU "resettable" status in IRAM

Mikko Perttunen (7):
      soc/tegra: fuse: Add RAM code reader helper
      of: Add Tegra124 EMC bindings
      memory: tegra: Add API needed by the EMC driver
      memory: tegra: Add EMC (external memory controller) driver
      memory: tegra: Add debugfs entry for getting and setting the EMC rate
      clk: tegra124: Remove old emc clock
      clk: tegra: Add EMC clock driver

Nicholas Mc Guire (1):
      soc/tegra: Watch wait_for_completion_timeout() return type

Thierry Reding (3):
      memory: tegra: Add SWGROUP names
      clk: tegra: EMC clock driver depends on EMC driver
      memory: tegra: Explicitly mark defines unsigned

Tomeu Vizoso (8):
      of: Document long-ram-code property in nvidia,tegra20-apbmisc
      of: Document timings subnode of nvidia,tegra-mc
      memory: tegra: Disable ARBITRATION_EMEM interrupt
      of: document new emc-timings subnode in nvidia,tegra124-car
      of: document external-memory-controller property in tegra124-car
      clk: Expose clk_hw_reparent() to providers
      clk: tegra: Set the EMC clock as the parent of the MC clock
      clk: tegra: Have EMC clock implement determine_rate()

 .../bindings/clock/nvidia,tegra124-car.txt         |   44 +-
 .../memory-controllers/nvidia,tegra-mc.txt         |   84 +-
 .../bindings/memory-controllers/tegra-emc.txt      |  374 +++++++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    2 +
 arch/arm/mach-tegra/cpuidle-tegra20.c              |    5 +-
 arch/arm/mach-tegra/reset-handler.S                |   10 +-
 arch/arm/mach-tegra/reset.h                        |    4 +
 arch/arm/mach-tegra/sleep-tegra20.S                |   37 +-
 arch/arm/mach-tegra/sleep.h                        |    4 +
 arch/arm/mach-tegra/tegra.c                        |    1 -
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/clk.c                                  |    8 +
 drivers/clk/tegra/Kconfig                          |    3 +
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-emc.c                        |  539 ++++++++++
 drivers/clk/tegra/clk-tegra124.c                   |   18 +-
 drivers/clk/tegra/clk.h                            |   12 +
 drivers/gpio/gpio-tegra.c                          |    4 +-
 drivers/memory/tegra/Kconfig                       |   10 +
 drivers/memory/tegra/Makefile                      |    2 +
 drivers/memory/tegra/mc.c                          |  140 ++-
 drivers/memory/tegra/tegra114.c                    |   32 +-
 drivers/memory/tegra/tegra124-emc.c                | 1137 ++++++++++++++++++++
 drivers/memory/tegra/tegra124.c                    |   90 +-
 drivers/memory/tegra/tegra30.c                     |   32 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c              |    6 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   21 +
 drivers/soc/tegra/pmc.c                            |   23 +-
 include/linux/clk-provider.h                       |    1 +
 include/soc/tegra/emc.h                            |   19 +
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/mc.h                             |   15 +-
 include/soc/tegra/pmc.h                            |    2 -
 33 files changed, 2572 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 drivers/clk/tegra/Kconfig
 create mode 100644 drivers/clk/tegra/clk-emc.c
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 include/soc/tegra/emc.h
