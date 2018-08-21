From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Aug 2018 16:55:16 -0500
Subject: [PATCH 0/8] Devicetree build consolidation
Message-ID: <20180821215524.23040-1-robh@kernel.org>
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

Rob

Rob Herring (8):
  powerpc: build .dtb files in dts directory
  nios2: build .dtb files in dts directory
  nios2: use common rules to build built-in dtb
  nios2: fix building all dtbs
  c6x: use common built-in dtb support
  kbuild: consolidate Devicetree dtb build rules
  powerpc: enable building all dtbs
  c6x: enable building all dtbs

 Makefile                           | 30 ++++++++++++++++++
 arch/arc/Makefile                  |  6 ----
 arch/arm/Makefile                  | 20 +-----------
 arch/arm64/Makefile                | 17 +----------
 arch/c6x/Makefile                  |  2 --
 arch/c6x/boot/dts/Makefile         | 17 +++++------
 arch/c6x/boot/dts/linked_dtb.S     |  2 --
 arch/c6x/include/asm/sections.h    |  1 -
 arch/c6x/kernel/setup.c            |  4 +--
 arch/c6x/kernel/vmlinux.lds.S      | 10 ------
 arch/h8300/Makefile                | 11 +------
 arch/microblaze/Makefile           |  4 +--
 arch/mips/Makefile                 | 15 +--------
 arch/nds32/Makefile                |  2 +-
 arch/nios2/Makefile                | 11 +------
 arch/nios2/boot/Makefile           | 22 --------------
 arch/nios2/boot/dts/Makefile       |  6 ++++
 arch/nios2/boot/linked_dtb.S       | 19 ------------
 arch/powerpc/Makefile              |  3 --
 arch/powerpc/boot/Makefile         | 49 ++++++++++++++----------------
 arch/powerpc/boot/dts/Makefile     |  6 ++++
 arch/powerpc/boot/dts/fsl/Makefile |  4 +++
 arch/xtensa/Makefile               | 12 +-------
 scripts/Makefile                   |  1 -
 scripts/Makefile.lib               |  2 +-
 25 files changed, 87 insertions(+), 189 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
