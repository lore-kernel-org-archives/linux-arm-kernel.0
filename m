From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Sh73a0 Multiplatform Updates for
 v3.20
Message-ID: <cover.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC sh73a0 multiplatform updates for v3.20.

This pull request is based on a merge of:

* Renesas ARM Based SoC Drivers Updates for v3.20,
  tagged as renesas-drivers-for-v3.20, which I have also sent
  a built request for.

* "Renesas ARM Based SoC sh73a0 CCF Updates for v3.20",
  tagged as renesas-sh73a0-ccf-for-v3.20.

It is my understnding that both of those dependencies are required in
order to transition to a bootable muliplatform kernel for the kzm9g board.


This pull request has several minor conflicts with the arm-soc/for-next
branch:

* There is a conflict in arch/arm/mach-shmobile/Makefile.boot
  with the pull-request "Renesas ARM Based SoC Lager Board Removal for
  v3.20", tagged as renesas-lager-board-removal-for-v3.20, which you have
  pulled into the next/cleanup branch.

  A resolution for this conflict is in the renesas-next-20150114-v3.19-rc1
  tag of my renesas tree.

  In words the solution is to remove both
  CONFIG_MACH_KZM9G_REFERENCE and CONFIG_MACH_LAGER.

  The resulting section of arch/arm/mach-shmobile/Makefile.boot is as follows.

loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000

* There is a conflict in arch/arm/boot/dts/Makefile with
  cb612390e54691863 ("ARM: dts: Only build dtb if associated Arch and/or
  SoC is enabled").

  A resolution for this can be found in next-20150115.

  In words the resolution is to take the formating from cb612390e54691863,
  and the dtb file removan and addtion from this pull-request.

  The resulting section of arch/arm/boot/dts/Makefile is as follows.


dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
        r8a73a4-ape6evm.dtb \
        r8a73a4-ape6evm-reference.dtb \
        r8a7740-armadillo800eva.dtb \
        r8a7778-bockw.dtb \
        r8a7778-bockw-reference.dtb \
        r8a7779-marzen.dtb \
        sh7372-mackerel.dtb \
        sh73a0-kzm9g.dtb
dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
        emev2-kzm9d.dtb \
        r7s72100-genmai.dtb \
        r8a73a4-ape6evm.dtb \
        r8a7740-.dtb \
        r8a7779-marzen.dtb \
        r8a7790-lager.dtb \
        r8a7791-henninger.dtb \        r8a7791-koelsch.dtb \
        r8a7794-alt.dtb \
        sh73a0-kzm9g.dtb
dtb-$(CONFIG_ARCH_SOCFPGA) += \
        socfpga_arria5_socdk.dtb \

* arch/arm/boot/dts/sh73a0-kzm9g-reference.dts should be removed



The following changes since commit 26bcc66a8b05febf3c4b5ac3365caf23eb103b4f:

  Merge branch 'drivers-for-v3.20' into sh73a0-multiplatform-for-v3.20.base (2015-01-14 09:39:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-multiplatform-for-v3.20

for you to fetch changes up to 93c9f0228a3d0a14640f86b3e8aeaf3c9b449bb7:

  ARM: shmobile: kzm9g-reference: Remove board C code and DT file (2015-01-14 09:46:48 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC sh73a0 Multiplatform Updates for v3.20

* Multiplatform support for sh73a0 SoC and KZM9G board

----------------------------------------------------------------
Geert Uytterhoeven (10):
      ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
      ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
      ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
      ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node
      ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module
      ARM: shmobile: kzm9g dts: Declare the full 512 MiB of RAM
      ARM: shmobile: kzm9g-reference dts: Declare the full 512 MiB of RAM
      ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
      ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
      ARM: shmobile: kzm9g-reference: Remove board C code and DT file

Laurent Pinchart (2):
      ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
      ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node

Magnus Damm (4):
      ARM: shmobile: sh73a0: Introduce generic setup callback
      ARM: shmobile: sh73a0: Add Multiplatform support
      ARM: shmobile: kzm9g dts: Sync with kzm9g-reference dts
      ARM: shmobile: kzm9g: Build DTS for Multiplatform

Ulrich Hecht (1):
      ARM: shmobile: sh73a0 dtsi: Add selectable sources to DIV6 clocks

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 366 --------------------
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 | 378 ++++++++++++++++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |  92 +++--
 arch/arm/mach-shmobile/Kconfig                     |  19 +-
 arch/arm/mach-shmobile/Makefile                    |   5 +-
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  62 ----
 arch/arm/mach-shmobile/include/mach/zboot.h        |   2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  16 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                |   2 +-
 include/dt-bindings/clock/sh73a0-clock.h           |   3 +
 13 files changed, 477 insertions(+), 477 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
