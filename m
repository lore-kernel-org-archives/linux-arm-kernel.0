From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 29 Oct 2018 16:52:00 -0700
Subject: [PATCH 0/6]  arm64: Get rid of __early_init_dt_declare_initrd()
Message-ID: <20181029235206.30060-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The numbers no longer make any sense since I either did not correctly
understand the feedback being given, or dramatically changed the
approach.

This version introduces an architecture symbol: ARCH_HAS_PHYS_INITRD
which indicates whether the architecture cares/supports parsing the
physical address of the initrd. Currently ARM (32-bit), Unicore32 and
now ARM64 support that.

When that symbol is defined, we also have the generic FDT code populate
the initrd physical address and size, and we can later make use of that
within architecture specific code to populate the memblock regions and
do the righ physical to virtual address conversion.

Rob, hopefully this is what you had in mind.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4


Florian Fainelli (6):
  nds32: Remove phys_initrd_start and phys_initrd_size
  arch: Make phys_initrd_start and phys_initrd_size global variables
  arch: Define ARCH_HAS_PHYS_INITRD for ARM and Unicore32
  of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
  arm64: Utilize ARCH_HAS_PHYS_INITRD
  of/fdt: Remove definition check for __early_init_dt_declare_initrd()

 arch/Kconfig                    |  7 +++++++
 arch/arm/Kconfig                |  1 +
 arch/arm/mm/init.c              |  6 +++---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 23 +++++++++++------------
 arch/nds32/mm/init.c            |  2 --
 arch/unicore32/Kconfig          |  1 +
 arch/unicore32/mm/init.c        |  4 ++--
 drivers/of/fdt.c                |  6 ++++--
 include/linux/initrd.h          |  3 +++
 11 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.17.1
