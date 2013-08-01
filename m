From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 10:45:29 +0200
Subject: [PATCH 0/9] ARM: kirkwood: convert a few more boards to DT
Message-ID: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of patches that converts a few additional Kirkwood
boards to use the Device Tree. I intend to continue this effort with
the remaining Kirkwood boards.

Note that I don't have access to any of the platforms that are being
converted in this patch series, so this means that:

 - A careful review would be useful

 - Testing from owners of the boards would be appreciated. The DT
   conversion of Kirkwood boards is a process that has now been
   started a while ago, and we would like to finalize it. If board
   owners don't react by testing the proposed patches, then the
   support for those boards might be broken.

In detail:

 * Patch 1 converts the d2net_v2 board to DT.

   The remaining board file is needed for the Ethernet device and the
   leds-ns2 device. A DT for the mv643xx_eth driver (by Sebastian
   Hesselbarth) is being merged, but I wanted to avoid the dependency
   on a different patch series for now. Ethernet can be moved to DT as
   a followup patch.

 * Patches 2, 3, 4 and 5 remove support for boards that have already
   been converted to the Deice Tree, but for which the legacy board
   file was not removed.

 * Patch 6 converts the mv88f6281gtw_ge board to DT.

   The remaining devices probed in a legacy way are the mv643xx_eth
   driver (same discussion as above), and the DSA switch (note that I
   have an Armada 370 platform with a DSA switch, so I'll have to look
   at how to make this appear in the DT).

 * Patch 7 converts the LaCie Net{2,5}Big v2 platforms to DT

   The remaining devices probed in a legacy way are the Ethernet
   devices, and the leds-netxbig driver. For Ethernet, see above. For
   leds-netxbig, Simon Guinot is currently working on this (see the
   LAKML thread "Location for a kind of GPIO bus driver").

 * Patch 8 removes some common code for LaCie boards that has become
   useless after the DT conversions.

 * Patch 9 adjusts kirkwood_defconfig after the DT conversions.

Thomas

Thomas Petazzoni (9):
  ARM: kirkwood: convert d2net_v2 to DT
  ARM: kirkwood: remove support for legacy booting of Dockstar
  ARM: kirkwood: remove support for legacy booting of Guruplug
  ARM: kirkwood: remove support for legacy booting of Sheevaplug
  ARM: kirkwood: remove LaCie boards that are supported through DT
  ARM: kirkwood: convert the mv88f6281gtw_ge board to DT
  ARM: kirkwood: convert LaCie Net{2,5}Big v2 platforms to DT
  ARM: kirkwood: remove unused common code for LaCie platforms
  ARM: kirkwood: update defconfig after DT conversions

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-d2net-v2.dts            | 204 ++++++++++++++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 125 +++++++++
 arch/arm/boot/dts/kirkwood-net2big-v2.dts          | 204 ++++++++++++++
 arch/arm/boot/dts/kirkwood-net5big-v2.dts          | 238 +++++++++++++++++
 arch/arm/configs/kirkwood_defconfig                |  15 +-
 arch/arm/mach-kirkwood/Kconfig                     |  92 ++-----
 arch/arm/mach-kirkwood/Makefile                    |  15 +-
 arch/arm/mach-kirkwood/board-d2net_v2.c            |  72 +++++
 arch/arm/mach-kirkwood/board-dt.c                  |   7 +
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c     |  50 ++++
 .../{netxbig_v2-setup.c => board-netxbig_v2.c}     | 213 +--------------
 arch/arm/mach-kirkwood/common.h                    |  12 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c            | 231 ----------------
 arch/arm/mach-kirkwood/dockstar-setup.c            | 111 --------
 arch/arm/mach-kirkwood/guruplug-setup.c            | 133 ----------
 arch/arm/mach-kirkwood/lacie_v2-common.c           | 114 --------
 arch/arm/mach-kirkwood/lacie_v2-common.h           |  16 --
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c     | 172 ------------
 arch/arm/mach-kirkwood/netspace_v2-setup.c         | 293 ---------------------
 arch/arm/mach-kirkwood/sheevaplug-setup.c          | 161 -----------
 21 files changed, 950 insertions(+), 1529 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-d2net-v2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
 create mode 100644 arch/arm/mach-kirkwood/board-d2net_v2.c
 create mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 rename arch/arm/mach-kirkwood/{netxbig_v2-setup.c => board-netxbig_v2.c} (53%)
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/netspace_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/sheevaplug-setup.c

-- 
1.8.1.2
