From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 09:04:53 +0200
Subject: [PATCH 0/8] Support Marvell bootloaders remapping registers at
 different locations
Message-ID: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Marvell platforms, the base address of the "internal registers"
(i.e registers of all peripherals) can be configured at runtime. At
reset, it is set to 0xD0000000, but it can freely be changed to some
other location.

On all previous Marvell SoC families, Linux assumes the bootloader has
remapped the internal registers at 0xF1000000, and Marvell is now
moving to do the same on Armada 370/XP, since it allows to use as much
RAM as possible in the 0 -> 4G area. However, due to early issues,
until now, Marvell bootloaders were leaving the internal registers
address set to 0xD0000000, and recently, Marvell has started shipping
bootloaders that remapped those registers to 0xF1000000.

In order to support those two cases, we want to make sure the Device
Tree is the only location where the physical base address of the
internal registers is stored. This patch set removes the places where
the physical base address of the registers was hardcoded and provides
two Kconfig options for the earlyprintk UART address selection (one
for 0xD0000000 and one for 0xF1000000).

It no longer uses the CP15 trick, nor it tries to do runtime remapping
to 0xF1 if it wasn't done by the bootloader. But it allows to easily
boot a kernel with both old and new bootloaders by doing a simple
change, in a single location in the Device Tree.

This patch series is based on jcooper/mvebu/fixes-non-critical and
jcooper/mvebu/cleanup, which contains 3 patches that are necessary to
make this patch series work properly.

Thanks,

Thomas

Thomas Petazzoni (8):
  arm: mvebu: remove dependency of SMP init on static I/O mapping
  arm: mvebu: avoid hardcoded virtual address in coherency code
  arm: mvebu: move cache and mvebu-mbus initialization later
  arm: mvebu: remove hardcoded static I/O mapping
  arm: mvebu: don't hardcode a physical address in headsmp.S
  arm: mvebu: don't hardcode the physical address for mvebu-mbus
  arm: mvebu: add another earlyprintk Kconfig option
  arm: mvebu: disable DEBUG_LL/EARLY_PRINTK in defconfig

 arch/arm/Kconfig.debug              | 30 ++++++++++++++++++++--
 arch/arm/configs/mvebu_defconfig    |  2 --
 arch/arm/include/debug/mvebu.S      |  5 ++++
 arch/arm/mach-mvebu/armada-370-xp.c | 51 ++++++++++++++++++++-----------------
 arch/arm/mach-mvebu/armada-370-xp.h | 10 --------
 arch/arm/mach-mvebu/coherency.c     | 36 ++++++++++----------------
 arch/arm/mach-mvebu/coherency.h     |  4 ---
 arch/arm/mach-mvebu/common.h        |  2 ++
 arch/arm/mach-mvebu/headsmp.S       | 19 ++++++++------
 arch/arm/mach-mvebu/platsmp.c       | 10 +++++++-
 10 files changed, 96 insertions(+), 73 deletions(-)

-- 
1.8.1.2
