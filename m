From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jul 2014 08:49:26 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 4)
Message-ID: <20140725124926.GH23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here's the (late) last round of changes for mvebu.  Daniel and Thomas
did a great job reviewing and resubmitting the cpuidle series, so that
is the primary content of this pull request.  There are also a few small
changes and Thomas added the URLs for publicly released datasheets for
the Armada XP SoCs!

Note that the cpuidle series depends on some fixes in mvebu/fixes,
therefore, mvebu/soc now depends on mvebu/fixes.  No matter how I did a
temporary merge branch, the commit list is correct (no commits from
mvebu/fixes), however, the diffstat includes the changes from
mvebu/fixes (the dts changes give it away).

To remedy this, I've included the diffstat of v3.16-rc1..mvebu/fixes at
the bottom so that you can compare.  Everything in /fixes has already
been pulled.

Based on tags/mvebu-soc-3.17-3, please pull.

thx,

Jason.


The following changes since commit ba3ec5780bba27819bbc4f669e6c77418a00f14b:

  Merge branch 'mvebu/soc-cpufreq' into mvebu/soc (2014-07-22 20:46:48 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-4

for you to fetch changes up to b6e9f521902970732eed7038a1a76354c89daf06:

  Documentation: arm: misc updates to Marvell EBU SoC status (2014-07-25 00:13:13 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.17 (round 4)

 - Armada XP
    - Fix return value check in pmsu code
    - Document URLs for new public datasheets (Thanks, Marvell & free-electrons!)

 - Armada 370/38x
    - Add cpuidle support

 - mvebu
    - Fix build when no platforms are selected
    - Update EBU SoC status in docs

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: mvebu: fix build without platforms selected

Gregory CLEMENT (12):
      ARM: mvebu: split again armada_370_xp_pmsu_idle_enter() in PMSU code
      ARM: mvebu: sort the #include of pmsu.c in alphabetic order
      ARM: mvebu: add a common function for the boot address work around
      ARM: mvebu: use the common function for Armada 375 SMP workaround
      ARM: mvebu: rename the armada_370_xp symbols to mvebu_v7 in pmsu.c
      ARM: mvebu: make the cpuidle initialization more generic
      ARM: mvebu: use a local variable to store the resume address
      ARM: mvebu: make the snoop disabling optional in mvebu_v7_pmsu_idle_prepare()
      ARM: mvebu: export the SCU address
      cpuidle: mvebu: rename the driver from armada-370-xp to mvebu-v7
      ARM: mvebu: add cpuidle support for Armada 370
      ARM: mvebu: add cpuidle support for Armada 38x

Jason Cooper (2):
      Merge branch 'mvebu/fixes' into mvebu/soc-cpuidle
      Merge branch 'mvebu/soc-cpuidle' into mvebu/soc

Thomas Petazzoni (4):
      cpuidle: mvebu: add Armada 370 support
      cpuidle: mvebu: add Armada 38x support
      Documentation: arm: add URLs to public datasheets for the Marvell Armada XP SoC
      Documentation: arm: misc updates to Marvell EBU SoC status

Wei Yongjun (1):
      ARM: mvebu: fix return value check in armada_xp_pmsu_cpufreq_init()

 Documentation/arm/Marvell/README                   |  19 +-
 .../devicetree/bindings/arm/armada-38x.txt         |  14 +-
 arch/arm/boot/dts/armada-380.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-385-db.dts                |   2 +-
 arch/arm/boot/dts/armada-385-rd.dts                |   2 +-
 arch/arm/boot/dts/armada-385.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |   2 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   4 +-
 arch/arm/mach-mvebu/Kconfig                        |   8 +
 arch/arm/mach-mvebu/Makefile                       |   4 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |   1 -
 arch/arm/mach-mvebu/board-v7.c                     |  38 ++-
 arch/arm/mach-mvebu/coherency.c                    |   6 +-
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/headsmp-a9.S                   |  14 +-
 arch/arm/mach-mvebu/platsmp-a9.c                   |  42 +--
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         | 294 +++++++++++++++++----
 arch/arm/mach-mvebu/pmsu.h                         |   5 +
 arch/arm/mach-mvebu/pmsu_ll.S                      |  61 +++++
 arch/arm/mach-mvebu/system-controller.c            |  31 +++
 drivers/cpuidle/Kconfig.arm                        |  12 +-
 drivers/cpuidle/Makefile                           |   2 +-
 drivers/cpuidle/cpuidle-armada-370-xp.c            |  93 -------
 drivers/cpuidle/cpuidle-mvebu-v7.c                 | 150 +++++++++++
 25 files changed, 578 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/pmsu_ll.S
 delete mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/cpuidle-mvebu-v7.c

--------- diff --stat v3.16-rc1..mvebu/fixes ---------------
 .../devicetree/bindings/arm/armada-38x.txt         | 14 +++++++++--
 arch/arm/boot/dts/armada-380.dtsi                  |  2 +-
 arch/arm/boot/dts/armada-385-db.dts                |  2 +-
 arch/arm/boot/dts/armada-385-rd.dts                |  2 +-
 arch/arm/boot/dts/armada-385.dtsi                  |  2 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  2 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  4 +--
 arch/arm/mach-mvebu/Kconfig                        |  2 ++
 arch/arm/mach-mvebu/Makefile                       |  2 +-
 arch/arm/mach-mvebu/board-v7.c                     | 29 ++++++++++++++--------
 arch/arm/mach-mvebu/coherency.c                    |  6 ++++-
 arch/arm/mach-mvebu/headsmp-a9.S                   |  9 ++++++-
 arch/arm/mach-mvebu/pmsu.c                         | 19 ++++++--------
 arch/arm/mach-mvebu/pmsu_ll.S                      | 25 +++++++++++++++++++
 14 files changed, 86 insertions(+), 34 deletions(-)
