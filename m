From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 May 2011 15:59:29 +0100
Subject: [PATCH v5 0/8] Switch ARM platforms from integrator-flash to physmap
Message-ID: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the integrator-flash driver is mostly a duplicate of physmap,
move all users of this driver to physmap and get rid of the
then unused driver.

Also change the set_vpp() method in physmap to pass the
platform_device instead of the map_info. This allows for a substantial
cleanup in drivers/mtd/maps/pismo.c

This patch set has been ok'ed by RMK, who is willing to take it
through his tree. This requires an ACK from the MTD maintainers. David
Woodhouse cc-ed on the whole patch set in case he'd prefer to merge it
via his MTD tree.

Chanes since v4:
- Changed set_vpp() method in physmap
- Rebased against v2.6.39-rc7

Changes since v3:
- Dropped patch for aaec2000 platform (removed from tree)
- Rebased against next-20110317

Changes since v2:
- Add integrator-flash's init()/exit() methods in order to control
  write access to the various onboard programmable components, as
  per RMK request.
- Rebased against 2.6.38-rc2

Changes since initial revision:
- Rebased against linux-next (20110107). It should apply cleanly
  on top of Linus' tree, except for a small conflict in the last
  patch of the serie.

Marc Zyngier (8):
  MTD: Add integrator-flash feature to physmap
  ARM: Realview: Use physmap driver instead of integrator-flash
  ARM: Versatile: Use physmap driver instead of integrator-flash
  ARM: VExpress: Use physmap driver instead of integrator-flash
  ARM: Integrator/AP: Use physmap driver instead of integrator-flash
  ARM: Integrator/CP: Use physmap driver instead of integrator-flash
  MTD: Remove integrator-flash
  MTD: physmap: let set_vpp() pass a platform_device instead of a
    map_info

 arch/arm/configs/realview-smp_defconfig   |    2 +-
 arch/arm/configs/realview_defconfig       |    2 +-
 arch/arm/configs/versatile_defconfig      |    2 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |    4 -
 arch/arm/mach-integrator/integrator_ap.c  |   13 +-
 arch/arm/mach-integrator/integrator_cp.c  |   13 +-
 arch/arm/mach-omap1/flash.c               |    2 +-
 arch/arm/mach-pxa/hx4700.c                |    2 +-
 arch/arm/mach-pxa/magician.c              |    2 +-
 arch/arm/mach-realview/core.c             |   31 +---
 arch/arm/mach-s3c2410/nor-simtec.c        |    2 +-
 arch/arm/mach-versatile/core.c            |   31 +---
 arch/arm/mach-vexpress/v2m.c              |   22 +--
 arch/arm/plat-omap/include/plat/flash.h   |    2 +-
 drivers/mtd/Kconfig                       |    3 +-
 drivers/mtd/maps/Makefile                 |    1 -
 drivers/mtd/maps/integrator-flash.c       |  309 -----------------------------
 drivers/mtd/maps/physmap.c                |   31 +++-
 drivers/mtd/maps/pismo.c                  |   40 +----
 include/linux/mtd/physmap.h               |    4 +-
 20 files changed, 68 insertions(+), 450 deletions(-)
 delete mode 100644 drivers/mtd/maps/integrator-flash.c
