From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 17:55:26 +0200
Subject: [PATCH 0/3] arm64: remove UEFI reserved regions from linear mapping
Message-ID: <1442246129-13930-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an alternative approach to the series I posted in November 2014:
thread.gmane.org/gmane.linux.kernel.efi/5133

For arm64, we need to keep track of which parts of the physical memory space
are backed by normal memory, since device mappings and memory mappings are
mutually incompatible (device mappings don't allow unaligned accesses which
may occur when parsing ACPI tables, for instance, and mapping devices as
memory is also not allowed)
 
Instead of adding a physmem memblock table that contains all of memory,
including the memory that should not be covered by the linear mapping,
this series introduces a MEMBLOCK_NOMAP attribute that allows us to
carry the same information in the ordinary 'memory' memblock table.

Patch #1 introduces the attribute and the associated plumbing to interpret
the attribute and to ensure MEMBLOCK_NOMAP regions are not considered for
allocations.

Patch #2 makes the arm64 core mapping code aware of MEMBLOCK_NOMAP, by
honoring it when setting up the linear mapping, and by making pfn_valid()
aware of it.

Patch #3 updates the UEFI memory map handling logic to mark reserved regions
as MEMBLOCK_NOMAP.

Notable about this series is that it does not require any changes to the
iomem resource table handling or the definition of page_is_ram(), since
the nomap regions are still registered as 'System RAM'.

Ard Biesheuvel (3):
  mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
  arm64: only consider memblocks with NOMAP cleared for linear mapping
  arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP

 arch/arm64/kernel/efi.c  |  5 ++--
 arch/arm64/mm/init.c     |  2 +-
 arch/arm64/mm/mmu.c      |  2 ++
 include/linux/memblock.h |  8 ++++++
 mm/memblock.c            | 28 ++++++++++++++++++++
 5 files changed, 41 insertions(+), 4 deletions(-)

-- 
1.9.1
