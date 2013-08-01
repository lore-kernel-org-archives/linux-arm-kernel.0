From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 17:07:26 +0200
Subject: [PATCHv2 0/9] ARM: kirkwood: convert a few more boards to DT
Message-ID: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of patches that converts a few additional Kirkwood
boards to use the Device Tree. I intend to continue this effort with
the remaining Kirkwood boards. It is based on the mvebu/boards branch
of linux-mvebu.git, which allows to use the Ethernet DT bindings.

Note that I don't have access to any of the platforms that are being
converted in this patch series, so this means that:

 - A careful review would be useful

 - Testing from owners of the boards would be appreciated. The DT
   conversion of Kirkwood boards is a process that has now been
   started a while ago, and we would like to finalize it. If board
   owners don't react by testing the proposed patches, then the
   support for those boards might be broken.

To ease testing, the branch containing those changes has been pushed
to:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/kirkwood-dt-conversion-step1-v2

and kernel images for the affected boards have been uploaded to the
following locations. They contain the correct appended DTB, and a
small initramfs to ease testing:

  http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-d2net-v2
  http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-mv88f6281gtw-ge
  http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-net2big-v2
  http://free-electrons.com/~thomas/pub/kirkwood/uImage.kirkwood-net5big-v2

In detail:

 * Patch 1 converts the d2net_v2 board completely to DT.

 * Patches 2, 3, 4 and 5 remove support for boards that have already
   been converted to the Deice Tree, but for which the legacy board
   file was not removed.

 * Patch 6 converts the mv88f6281gtw_ge board to DT.

   The remaining devices probed in a legacy way are the mv643xx_eth
   driver, and the DSA switch (note that I have an Armada 370 platform
   with a DSA switch, so I'll have to look at how to make this appear
   in the DT). I've left the Ethernet device not converted to DT
   because the interaction with the DSA switch is a bit special.

 * Patch 7 converts the LaCie Net{2,5}Big v2 platforms to DT

   The remaining device probed is the one managed by the leds-netxbig
   driver. For Ethernet, see above. For leds-netxbig, Simon Guinot is
   currently working on this (see the LAKML thread "Location for a
   kind of GPIO bus driver").

 * Patch 8 removes some common code for LaCie boards that has become
   useless after the DT conversions.

 * Patch 9 adjusts kirkwood_defconfig after the DT conversions.

Changes since v1:

 * Rebased on top of linux-mvebu.git/mvebu/boards
 * Use the Ethernet DT binding where possible and do the corresponding
   simplication.
 * Use the lacie,ns2-leds driver DT binding where possible, as
   suggested by Simon Guinot
 * Fix the LaCie Net{2,5}Big conversion, where the function doing the
   legacy registration of devices was not being called for board-dt.c.
 * Ensure DTB files are produced for all boards.
 * Fixed various mistakes in the .dts files.

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

 arch/arm/boot/dts/Makefile                     |   4 +
 arch/arm/boot/dts/kirkwood-d2net-v2.dts        | 231 ++++++++++++++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 125 ++++++++
 arch/arm/boot/dts/kirkwood-net2big-v2.dts      | 219 +++++++++++++
 arch/arm/boot/dts/kirkwood-net5big-v2.dts      | 265 ++++++++++++++++
 arch/arm/configs/kirkwood_defconfig            |  15 +-
 arch/arm/mach-kirkwood/Kconfig                 |  96 ++----
 arch/arm/mach-kirkwood/Makefile                |  15 +-
 arch/arm/mach-kirkwood/board-dt.c              |   7 +
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c |  50 +++
 arch/arm/mach-kirkwood/board-netxbig_v2.c      | 199 ++++++++++++
 arch/arm/mach-kirkwood/common.h                |  12 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c        | 231 --------------
 arch/arm/mach-kirkwood/dockstar-setup.c        | 111 -------
 arch/arm/mach-kirkwood/guruplug-setup.c        | 133 --------
 arch/arm/mach-kirkwood/lacie_v2-common.c       | 114 -------
 arch/arm/mach-kirkwood/lacie_v2-common.h       |  16 -
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c | 172 ----------
 arch/arm/mach-kirkwood/netspace_v2-setup.c     | 293 -----------------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      | 422 -------------------------
 arch/arm/mach-kirkwood/sheevaplug-setup.c      | 161 ----------
 21 files changed, 1139 insertions(+), 1752 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-d2net-v2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
 create mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 create mode 100644 arch/arm/mach-kirkwood/board-netxbig_v2.c
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/dockstar-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/netspace_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/sheevaplug-setup.c

-- 
1.8.1.2
