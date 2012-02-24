From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 24 Feb 2012 21:25:17 +0000
Subject: [GIT PULL] DaVinci cleanups for v3.4
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317D2DB9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull these DaVinci clean-up patches for
the v3.4 merge window? I have made sure that these don't
have any conflicts with the rmk/for-armsoc branch of
the arm-soc tree.

These patches need the following two commits from linux-next
(next-20120224) to keep the VPIF and CQ93VC drivers building.

2e932f2  ASoC: CQ93VC: remove machine specific header file inclusion from codec
db38951  [media] davinci: vpif: remove machine specific header file includes

However, there will not be any merge conflicts even if these patches
are not applied.

These patches do generate merge conflicts in latest linux-next
due to a recent DaVinci bug fix. I resolved the conflict in the
following manner:

diff --cc arch/arm/mach-davinci/board-dm644x-evm.c
index 1247ecd,b89bebe..864f676
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@@ -40,7 -39,9 +39,9 @@@
  #include <mach/usb.h>
  #include <mach/aemif.h>
  
+ #include "davinci.h"
+ 
 -#define DM644X_EVM_PHY_ID		"0:01"
 +#define DM644X_EVM_PHY_ID		"davinci_mdio-0:01"
  #define LXT971_PHY_ID	(0x001378e2)
  #define LXT971_PHY_MASK	(0xfffffff0)
  
diff --cc arch/arm/mach-davinci/board-neuros-osd2.c
index 8d34f51,3d12a3a..a772bb4
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@@ -39,7 -38,9 +38,9 @@@
  #include <mach/mmc.h>
  #include <mach/usb.h>
  
+ #include "davinci.h"
+ 
 -#define NEUROS_OSD2_PHY_ID		"0:01"
 +#define NEUROS_OSD2_PHY_ID		"davinci_mdio-0:01"
  #define LXT971_PHY_ID			0x001378e2
  #define LXT971_PHY_MASK			0xfffffff0
  
diff --cc arch/arm/mach-davinci/board-sffsdr.c
index 31da3c5,897cec5..76e67509
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@@ -42,7 -41,9 +41,9 @@@
  #include <mach/mux.h>
  #include <mach/usb.h>
  
+ #include "davinci.h"
+ 
 -#define SFFSDR_PHY_ID		"0:01"
 +#define SFFSDR_PHY_ID		"davinci_mdio-0:01"
  static struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
  	/* U-Boot Environment: Block 0
  	 * UBL:                Block 1

The pull request follows:

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.4/cleanup

Manjunath Hadli (8):
      ARM: davinci: dm644x: move private definitions to C file
      ARM: davinci: dm365: move private definitions to C file
      ARM: davinci: dm646x: move private definitions to C file
      ARM: davinci: create new common platform header for davinci
      ARM: davinci: streamline sysmod access
      ARM: davinci: dm644x: improve readability using macro
      ARM: davinci: dm644x: fix inconsistent variable naming
      ARM: davinci: dm644x: don't force vpfe registeration on all boards

 arch/arm/mach-davinci/board-dm355-evm.c       |    3 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |    3 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |    3 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |   28 ++++----
 arch/arm/mach-davinci/board-dm646x-evm.c      |   32 +++------
 arch/arm/mach-davinci/board-neuros-osd2.c     |    3 +-
 arch/arm/mach-davinci/board-sffsdr.c          |    3 +-
 arch/arm/mach-davinci/davinci.h               |   96 +++++++++++++++++++++++++
 arch/arm/mach-davinci/devices.c               |   32 ++++++---
 arch/arm/mach-davinci/dm355.c                 |    3 +-
 arch/arm/mach-davinci/dm365.c                 |   19 +++++-
 arch/arm/mach-davinci/dm644x.c                |   53 +++++++++-----
 arch/arm/mach-davinci/dm646x.c                |   21 ++++--
 arch/arm/mach-davinci/include/mach/dm355.h    |   32 --------
 arch/arm/mach-davinci/include/mach/dm365.h    |   52 -------------
 arch/arm/mach-davinci/include/mach/dm644x.h   |   47 ------------
 arch/arm/mach-davinci/include/mach/dm646x.h   |   41 -----------
 arch/arm/mach-davinci/include/mach/hardware.h |    2 -
 18 files changed, 218 insertions(+), 255 deletions(-)
 create mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
