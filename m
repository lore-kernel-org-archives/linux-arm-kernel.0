From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:41 -0600
Subject: [GIT PULL 3/8] ARM: tegra: cleanup
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes various cleanup of the core Tegra support.

* Unification of the separate board-dt-tegra*.c files into a single
  tegra.c, now that everything is DT-driven and basically identical.
* Use of_clk_get() in the Tegra clocksource driver so that clocks are
  described in DT rather than hard-coding clock names.
* Some cleanup of the PMC-related code, with the aim that the PMC
  "driver" contains more of the code that touches PMC registers, rather
  than spreading PMC register accesses through other files.
* Conversion of the "PMC" driver to acquire resources describe in device
  tree rather than hard-coding them.
* Use of common code for the CPU sleep TLB invalidation.

This branch is based on the previous fixes pull request.

----------------------------------------------------------------

The following changes since commit 84b808da2dea7020211f1d73d015ff6c3ac207c4:

  ARM: tegra: fix ignored return value of regulator_enable

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-cleanup

for you to fetch changes up to 6affb4826405dc1f53bae0e5c302a18f734a44ca:

  ARM: tegra: use setup_mm_for_reboot rather than explicit pgd switch

----------------------------------------------------------------

Hiroshi Doyu (4):
      ARM: tegra: Unify tegra{20,30,114}_init_early()
      ARM: tegra: Rename board-dt-tegra20.c to tegra.c
      ARM: tegra: Unify Device tree board files
      ARM: tegra: refactor tegra{20,30}_boot_secondary

Joseph Lo (5):
      ARM: tegra: pmc: add specific compatible DT string for Tegra30 and Tegra114
      ARM: tegra: fix the PMC compatible string in DT
      ARM: tegra: pmc: convert PMC driver to support DT only
      ARM: tegra: pmc: add power on function for secondary CPUs
      ARM: tegra: replace the CPU power on function with PMC call

Peter De Schrijver (1):
      clocksource: tegra: move to of_clk_get

Will Deacon (1):
      ARM: tegra: use setup_mm_for_reboot rather than explicit pgd switch

 arch/arm/boot/dts/tegra114.dtsi                 |    2 +-
 arch/arm/boot/dts/tegra20.dtsi                  |    2 +
 arch/arm/boot/dts/tegra30.dtsi                  |    4 +-
 arch/arm/mach-tegra/Makefile                    |    4 +-
 arch/arm/mach-tegra/board-dt-tegra114.c         |   46 ------
 arch/arm/mach-tegra/board-dt-tegra30.c          |   60 -------
 arch/arm/mach-tegra/board.h                     |    4 +-
 arch/arm/mach-tegra/common.c                    |   26 +--
 arch/arm/mach-tegra/hotplug.c                   |   23 ++-
 arch/arm/mach-tegra/platsmp.c                   |  110 +++++--------
 arch/arm/mach-tegra/pm.c                        |    7 +-
 arch/arm/mach-tegra/pmc.c                       |  152 ++++++++++++++----
 arch/arm/mach-tegra/pmc.h                       |    4 +
 arch/arm/mach-tegra/sleep.h                     |   10 +-
 .../mach-tegra/{board-dt-tegra20.c => tegra.c}  |   16 +-
 drivers/clocksource/tegra20_timer.c             |    4 +-
 16 files changed, 207 insertions(+), 267 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-dt-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/board-dt-tegra30.c
 rename arch/arm/mach-tegra/{board-dt-tegra20.c => tegra.c} (89%)
