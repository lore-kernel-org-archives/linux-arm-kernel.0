From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:36 +0200
Subject: [GIT PULL 4/8] clk: tegra: Changes for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-5-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-clk

for you to fetch changes up to 36b7be6d3ea8f434f1e0723f3fb0e85c3e00ebc2:

  clk: tegra: Fix hda2codec_2x clock name for Tegra30 (2015-05-13 15:17:14 +0200)

I've based this pull request on top of the tegra-for-4.2-ramcode pull
request, so pulling only this one should be sufficient to resolve the
dependency.

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Changes for v4.2-rc1

This contains the EMC clock driver that's been exhaustively reviewed and
tested. It also includes a change to the clock core that allows a clock
provider to perform low-level reparenting of clocks. This is required by
the EMC clock driver because the reparenting needs to be done at a very
specific point in time during the EMC frequency switch.

----------------------------------------------------------------
Marcel Ziswiler (1):
      clk: tegra: Fix hda2codec_2x clock name for Tegra30

Mikko Perttunen (3):
      soc/tegra: fuse: Add RAM code reader helper
      clk: tegra: Remove old Tegra124 EMC clock
      clk: tegra: Add EMC clock driver

Thierry Reding (2):
      Merge branch 'for-4.2/ramcode' into for-4.2/clk
      clk: tegra: EMC clock driver depends on EMC driver

Tomeu Vizoso (6):
      of: Document long-ram-code property in nvidia,tegra20-apbmisc
      clk: Expose clk_hw_reparent() to providers
      of: document new emc-timings subnode in nvidia,tegra124-car
      of: document external-memory-controller property in tegra124-car
      clk: tegra: Set the EMC clock as the parent of the MC clock
      clk: tegra: Have EMC clock implement determine_rate()

 .../bindings/clock/nvidia,tegra124-car.txt         |  44 +-
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |   2 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/clk.c                                  |   8 +
 drivers/clk/tegra/Kconfig                          |   3 +
 drivers/clk/tegra/Makefile                         |   1 +
 drivers/clk/tegra/clk-emc.c                        | 538 +++++++++++++++++++++
 drivers/clk/tegra/clk-tegra124.c                   |  19 +-
 drivers/clk/tegra/clk-tegra30.c                    |   2 +-
 drivers/clk/tegra/clk.h                            |  12 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |  21 +
 include/linux/clk-provider.h                       |   1 +
 include/soc/tegra/fuse.h                           |   1 +
 13 files changed, 637 insertions(+), 16 deletions(-)
 create mode 100644 drivers/clk/tegra/Kconfig
 create mode 100644 drivers/clk/tegra/clk-emc.c
