From: robh@kernel.org (Rob Herring)
Date: Mon,  1 Oct 2018 10:25:22 -0500
Subject: [PATCH v4 0/9] Devicetree build consolidation
Message-ID: <20181001152531.3385-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series addresses a couple of issues I have with building dts files.

First, the ability to build all the dts files in the tree. This has been
supported on most arches for some time with powerpc being the main
exception. The reason powerpc wasn't supported was it needed a change
in the location built dtb files are put.

Secondly, it's a pain to acquire all the cross-compilers needed to build
dtbs for each arch. There's no reason to build with the cross compiler and
the host compiler is perfectly fine as we only need the pre-processor.

I started addressing just those 2 problems, but kept finding small
differences such as target dependencies and dtbs_install support across
architectures. Instead of trying to align all these, I've consolidated the
build targets moving them out of the arch makefiles.

I'd like to take the series via the DT tree.

PPC maintainers, really need you review/ack on this especially patch 1.

Rob


v4:
 - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather than
   CONFIG_OF_EARLY_FLATTREE
 - Fix install path missing kernel version for dtbs_install
 - Fix "make CONFIG_OF_ALL_DTBS=y" for arches like ARM which selectively
   enable CONFIG_OF (and therefore dtc)

v3:
 - Rework dtc dependency to avoid 2 entry paths to scripts/dtc/. Essentially,
   I copied 'scripts_basic'.
 - Add missing scripts_basic dependency for dtc and missing PHONY tag.
 - Drop the '|' order only from dependencies
 - Drop %.dtb.S and %.dtb.o as top-level targets
 - PPC: remove duplicate mpc5200 dtbs from image-y targets

v2:
 - Fix $arch/boot/dts path check for out of tree builds
 - Fix dtc dependency for building built-in dtbs
 - Fix microblaze built-in dtb building
 - Add dtbs target for microblaze


Rob Herring (9):
  powerpc: build .dtb files in dts directory
  nios2: build .dtb files in dts directory
  nios2: use common rules to build built-in dtb
  nios2: fix building all dtbs
  c6x: use common built-in dtb support
  kbuild: consolidate Devicetree dtb build rules
  powerpc: enable building all dtbs
  c6x: enable building all dtbs
  microblaze: enable building all dtbs

 Makefile                           | 37 +++++++++++++++++++-
 arch/arc/Makefile                  |  6 ----
 arch/arm/Makefile                  | 20 +----------
 arch/arm64/Makefile                | 17 +--------
 arch/c6x/Makefile                  |  2 --
 arch/c6x/boot/dts/Makefile         | 17 ++++-----
 arch/c6x/boot/dts/linked_dtb.S     |  2 --
 arch/c6x/include/asm/sections.h    |  1 -
 arch/c6x/kernel/setup.c            |  4 +--
 arch/c6x/kernel/vmlinux.lds.S      | 10 ------
 arch/h8300/Makefile                | 11 +-----
 arch/microblaze/Makefile           |  4 +--
 arch/microblaze/boot/dts/Makefile  |  4 +++
 arch/mips/Makefile                 | 15 +-------
 arch/nds32/Makefile                |  2 +-
 arch/nios2/Makefile                | 11 +-----
 arch/nios2/boot/Makefile           | 22 ------------
 arch/nios2/boot/dts/Makefile       |  6 ++++
 arch/nios2/boot/linked_dtb.S       | 19 -----------
 arch/powerpc/Makefile              |  3 --
 arch/powerpc/boot/Makefile         | 55 ++++++++++++++----------------
 arch/powerpc/boot/dts/Makefile     |  6 ++++
 arch/powerpc/boot/dts/fsl/Makefile |  4 +++
 arch/xtensa/Makefile               | 12 +------
 scripts/Makefile                   |  3 +-
 scripts/Makefile.lib               |  2 +-
 scripts/dtc/Makefile               |  2 +-
 27 files changed, 102 insertions(+), 195 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
