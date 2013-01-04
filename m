From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  4 Jan 2013 14:17:14 +0000
Subject: [PATCH v3 0/7] arm64: ARMv8 RTSM model SoC support
Message-ID: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

That's the third version of the patch series adding support for the
ARMv8 RTSM model (vexpress-like) to the AArch64 kernel. There is no
SoC-specific code under arch/arm64/ as the kernel makes use of the
vexpress support already under drivers/ (apart from dts, defconfig and
some Kconfig changes).

The patches here can be found on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-experimental

In addition, there are two patches from Ryan and Tixy adding DT support
for CLCD, together with my patches for CLCD support on the ARMv8 RTSM
model (full, not the foundation one). My understanding is that Pawel
will push an updated patch for CLCD/DT support, so I won't worry about
it.

I'll push the arch/arm64/ patches myself but I expect the other patches
to go in via the arm-soc tree (sp810.h, vexpress clk/sysreg). I'll send
a pull request for the latter to arm-soc once Pawel is back from holiday
acks them.

Catalin


Catalin Marinas (6):
  arm: Move sp810.h to include/linux/amba/
  vexpress: Match the "arm,sp810" DT entry for clock initialisation
  vexpress: Allow vexpress-sysreg to self-initialise
  arm64: Populate the platform devices
  arm64: Enable ARMv8 RTSM model (SoC) support
  arm64: Add simple earlyprintk support

Pawel Moll (1):
  arm64: Add dts files for the ARMv8 RTSM model

 Documentation/arm64/memory.txt                     |   2 +
 arch/arm/plat-spear/restart.c                      |   2 +-
 arch/arm64/Kconfig                                 |  12 +-
 arch/arm64/Kconfig.debug                           |   9 +
 arch/arm64/boot/dts/Makefile                       |   2 +
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts             | 154 ++++++++++++++
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi       | 234 +++++++++++++++++++++
 arch/arm64/boot/dts/skeleton.dtsi                  |  13 ++
 arch/arm64/configs/vexpress_defconfig              |  90 ++++++++
 arch/arm64/include/asm/io.h                        |   3 +
 arch/arm64/include/asm/memory.h                    |   1 +
 arch/arm64/include/asm/mmu.h                       |   1 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/early_printk.c                   | 118 +++++++++++
 arch/arm64/kernel/head.S                           |  12 +-
 arch/arm64/kernel/setup.c                          |   8 +
 arch/arm64/mm/mmu.c                                |  42 ++++
 drivers/clk/versatile/clk-vexpress.c               |  31 +--
 drivers/mfd/vexpress-sysreg.c                      |   8 +-
 drivers/net/ethernet/smsc/Kconfig                  |   4 +-
 .../asm/hardware => include/linux/amba}/sp810.h    |   0
 include/linux/vexpress.h                           |   2 +-
 22 files changed, 727 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
 create mode 100644 arch/arm64/boot/dts/skeleton.dtsi
 create mode 100644 arch/arm64/configs/vexpress_defconfig
 create mode 100644 arch/arm64/kernel/early_printk.c
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)
