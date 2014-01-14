From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Jan 2014 10:41:41 -0500
Subject: [GIT PULL] ARM: mvebu: stable fix for v3.13
Message-ID: <20140114154141.GO19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-soc folks,

Sorry for the lateness in the window on this one.  I'd like to see it
get into v3.13 if possible, but if it doesn't get there till v3.13.1, I
understand.

This fixes a boot hang experienced on some Openblocks AX3-4 boards.
Once i2c transaction support was added, it was discovered that the A0
revision of the Armada XP had broken offload support which causes the
kernel to hang at boot.  The only way to detect this situation is to
read the PCI config register to get the SoC revision, then disable
offload if we are on an A0 SoC.

Unfortunately, this makes for a rather large patch series against
stable.  Doing the fix in a smaller patch would create a runtime
dependency between i2c and PCI which we prefer to avoid.

I'm Cc'ing Greg and linux-stable as a heads-up, and so they can comment
or ask questions.

thx,

Jason.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.13

for you to fetch changes up to f8b94beb7e6a374cb0de531b72377c49857b35ca:

  i2c: mv64xxx: Document the newly introduced Armada XP A0 compatible (2014-01-14 02:09:17 +0000)

----------------------------------------------------------------
mvebu late fixes for v3.13

 - mvebu
    - fix boot hang on Armada XP due to broken i2c offloading in A0 SoC revision
	(specifically experienced on some early OpenBlocks AX3-4 boards)

----------------------------------------------------------------
Gregory CLEMENT (4):
      ARM: mvebu: Add support to get the ID and the revision of a SoC
      ARM: mvebu: Add quirk for i2c for the OpenBlocks AX3-4 board
      i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
      i2c: mv64xxx: Document the newly introduced Armada XP A0 compatible

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |   6 +-
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  32 ++++++
 arch/arm/mach-mvebu/mvebu-soc-id.c                 | 119 +++++++++++++++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |  32 ++++++
 drivers/i2c/busses/i2c-mv64xxx.c                   |   5 +
 6 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.c
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.h
