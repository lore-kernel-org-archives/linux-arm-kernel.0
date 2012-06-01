From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jun 2012 09:56:47 +0000
Subject: [GIT PULL] ARM: ux500: fixes for mismerge
Message-ID: <201206010956.47658.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 76f901eb4659779ecacd0e4eba49f55442daef53:                                                                                                                                       

  Merge tag 'for-v3.5' of git://git.infradead.org/battery-2.6 (2012-05-31 12:10:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git ux500/hickup

for you to fetch changes up to 5910de9e2de453956c3a18816f4838d96ac86988:

  ARM: ux500: Enable probing of pinctrl through Device Tree (2012-06-01 02:04:53 +0200)

----------------------------------------------------------------
ARM: ux500: fixes for mismerge

The device tree conversion for arm/ux500 in 3.5 turns out to be
incomplete because of a mismerge done by Linus Walleij that
I failed to notice early enough and that Lee Jones as the original
author of those patches did not manage to fix during the -next
cycle. While we originally to get a much larger set of ux500
device tree enablement patches merged, this did not happen in time.

After some discussion at Linaro Connect conference this week,
Lee has been able to do damage control and provide a series to put
the broken platform back into usable shape for both DT and non-DT
based booting.

This series has not been part of linux-next and is based on top
of the current state of the upstream kernel rather than an -rc,
but this is the best we could manage given the earlier breakage.

----------------------------------------------------------------
Lee Jones (15):
      pinctrl-nomadik: Allow Device Tree driver probing
      ARM: ux500: New DT:ed snowball_platform_devs for one-by-one device enablement
      ARM: ux500: New DT:ed u8500_init_devices for one-by-one device enablement
      ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
      ARM: ux500: Remove DB8500 PRCMU platform registration when DT is enabled
      ARM: ux500: PRCMU related configuration and layout corrections for Device Tree
      ARM: ux500: Re-enable SMSC911x platform code registration during non-DT boots
      ARM: ux500: Use correct format for dynamic IRQ assignment
      ARM: ux500: Disable platform setup of the ab8500 when DT is enabled
      ARM: ux500: Only initialise STE's UIBs on boards which support them
      ARM: ux500: Apply db8500-prcmu regulator information to db8500 Device Tree
      ARM: ux500: Allow PRCMU regulator to be probed during a DT enabled boot
      ARM: ux500: Provide regulator support for SMSC911x via Device Tree
      ARM: ux500: Add support for ab8500 regulators into the Device Tree
      ARM: ux500: Enable probing of pinctrl through Device Tree

 arch/arm/boot/dts/db8500.dtsi          |  204 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts         |   32 ++++++++++++++++++--------
 arch/arm/configs/u8500_defconfig       |    1 +
 arch/arm/mach-ux500/board-mop500-uib.c |    4 +---
 arch/arm/mach-ux500/board-mop500.c     |   32 ++++++++++++++++++++++----
 arch/arm/mach-ux500/board-mop500.h     |    4 ++++
 arch/arm/mach-ux500/cpu-db8500.c       |   25 ++++++++++++++++++--
 drivers/mfd/db8500-prcmu.c             |    1 +
 drivers/pinctrl/pinctrl-nomadik.c      |   20 +++++++++++++++-
 9 files changed, 301 insertions(+), 22 deletions(-)
