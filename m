From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 19 Nov 2012 12:19:51 -0600
Subject: [PATCH 0/3] ARM: zynq: ARCH_MULTIPLATFORM support
Message-ID: <cover.1353349191.git.josh.cartwright@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal-

Here's an attempt at supporting ARCH_MULTIPLATFORM on Zynq.  I've gotten
a multiplatform kernel building and booting on the zc702, although I
haven't tried to boot the same image on another non-Zynq board, due to
lack of available hardware.

It would be super awesome if this set could land in 3.8, but I know
we're running out of time there.  I wouldn't be too heartbroken if it
didn't make it.

This patchset is on top of your arm-next branch and with the
debug_ll_init support patch @ arm-soc/devel/debug_ll_init.

Patch 1 drops the early TTC mapping.  It is not necessary, since the TTC
driver now supports pulling mapping info from the device tree.

Patch 2 converts zynq to use the debug_ll_init() infrastructure slated
to go into 3.8.

Patch 3 is the bulk of the set, moving around logic around within
mach-zynq/include, and setting up the necessary build magic to get Zynq
building w/ CONFIG_ARCH_MULTIPLATFORM.

Thanks,
   Josh

---
Josh Cartwright (3):
  ARM: zynq: remove TTC early mapping
  ARM: zynq: make use of debug_ll_io_init()
  ARM: zynq: add support for ARCH_MULTIPLATFORM

 arch/arm/Kconfig                                   | 14 +-----
 arch/arm/Kconfig.debug                             |  1 +
 .../mach/debug-macro.S => include/debug/zynq.S}    | 23 ++++++++--
 arch/arm/mach-zynq/Kconfig                         | 13 ++++++
 arch/arm/mach-zynq/common.c                        | 38 +++++-----------
 arch/arm/mach-zynq/include/mach/uart.h             | 25 ----------
 arch/arm/mach-zynq/include/mach/uncompress.h       | 51 ---------------------
 arch/arm/mach-zynq/include/mach/zynq_soc.h         | 53 ----------------------
 arch/arm/mach-zynq/timer.c                         |  1 -
 9 files changed, 46 insertions(+), 173 deletions(-)
 rename arch/arm/{mach-zynq/include/mach/debug-macro.S => include/debug/zynq.S} (61%)
 create mode 100644 arch/arm/mach-zynq/Kconfig
 delete mode 100644 arch/arm/mach-zynq/include/mach/uart.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/zynq_soc.h

-- 
1.8.0
