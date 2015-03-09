From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:04 +0000
Subject: [PATCH 0/6] make memtest a generic kernel feature
Message-ID: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Memtest is a simple feature which fills the memory with a given set of
patterns and validates memory contents, if bad memory regions is detected it
reserves them via memblock API. Since memblock API is widely used by other
architectures this feature can be enabled outside of x86 world.

This patch set promotes memtest to live under generic mm umbrella and enables
memtest feature for arm/arm64.

It was reported that this patch set was useful for tracking down an issue with
some errant DMA on an arm64 platform.

Since it touches x86 and mm bits it'd be great to get ACK/NAK for these bits.

Changelog:

    RFC -> v1
        - updated kernel-parameters.txt for memtest entry
        - updated number of test patterns in Kconfig menu
        - added Acked/Tested tags for arm64 bits
        - rebased on v4.0-rc3

Vladimir Murzin (6):
  mm: move memtest under /mm
  memtest: use phys_addr_t for physical addresses
  arm64: add support for memtest
  arm: add support for memtest
  Kconfig: memtest: update number of test patterns up to 17
  Documentation: update arch list in the 'memtest' entry

 Documentation/kernel-parameters.txt |    2 +-
 arch/arm/mm/init.c                  |    3 +
 arch/arm64/mm/init.c                |    2 +
 arch/x86/Kconfig                    |   11 ----
 arch/x86/include/asm/e820.h         |    8 ---
 arch/x86/mm/Makefile                |    2 -
 arch/x86/mm/memtest.c               |  118 -----------------------------------
 include/linux/memblock.h            |    8 +++
 lib/Kconfig.debug                   |   11 ++++
 mm/Makefile                         |    1 +
 mm/memtest.c                        |  118 +++++++++++++++++++++++++++++++++++
 11 files changed, 144 insertions(+), 140 deletions(-)
 delete mode 100644 arch/x86/mm/memtest.c
 create mode 100644 mm/memtest.c

-- 
1.7.9.5
