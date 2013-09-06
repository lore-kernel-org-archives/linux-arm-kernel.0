From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri,  6 Sep 2013 10:19:16 +0100
Subject: [PATCH v2 0/2] Add early_ioremap()/early_memremap() support to arm
Message-ID: <1378459158-2145-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86 and ia64 have the early_ioremap()/early_memremap() functions, which
are useful for supporting things like UEFI, ACPI and SMBIOS, where
configuration tables need to be parsed before proper memory management
is available, regardless of highmem status.

This patchset implements a restricted form of early_ioremap() and
early_memremap(), available before paging_init() only. Like the x86 code
on which it is based, it (p)re-uses the fixmap regions for its virtual
mapping range. Up to 7 simultaneous mappings of up to 128KB can be
accommodated in the available fixmap space.

New for this version is the addition of the early_memremap() call,
which maps a region in with uncached normal memory type.

Leif Lindholm (2):
  Documentation: arm: early_ioremap/early_memremap
  arm: add early_ioremap support

 Documentation/arm/00-INDEX          |    2 +
 Documentation/arm/early_ioremap.txt |   23 +++
 arch/arm/Kconfig                    |    7 +
 arch/arm/include/asm/fixmap.h       |   31 +++-
 arch/arm/include/asm/io.h           |   17 +++
 arch/arm/kernel/setup.c             |    5 +
 arch/arm/mm/Makefile                |    1 +
 arch/arm/mm/early_ioremap.c         |  271 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                   |    4 +
 9 files changed, 359 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm/early_ioremap.txt
 create mode 100644 arch/arm/mm/early_ioremap.c

-- 
1.7.10.4
