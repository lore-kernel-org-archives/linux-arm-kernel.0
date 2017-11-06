From: james.morse@arm.com (James Morse)
Date: Mon,  6 Nov 2017 18:44:23 +0000
Subject: [PATCH 0/4] Switch GHES ioremap_page_range() to use fixmap
Message-ID: <20171106184427.31905-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GHES is doing ioremap_page_range() in both NMI and irq context, neither
are safe as it may sleep to allocate intermediate levels of page table.

Replace the NMI/irq GHES_IOREMAP_PAGES to use a fixmap entry each.

After this nothing uses ghes_ioremap_area or arch_apei_flush_tlb_one(),
rip them out.

This hasn't been tested on a system with x86's NOTIFY_NMI. Any more
more testing would be welcome. These patches are (still) based on rc7.

Changes since RFC:
 * Added #ifdefs around the entries in fixmap.h
 * Added a paragraph about HAVE_ACPI_APEI to the commit message
 * Merged the first three patches for improved history

I've tried to be clear with who-acked-what when merging the patches.
For reference, the arch-acks are here:
https://lkml.org/lkml/2017/11/2/254
https://lkml.org/lkml/2017/10/31/780


Thanks,

James Morse (4):
  ACPI / APEI:  Replace ioremap_page_range() with fixmap
  ACPI / APEI: Remove ghes_ioremap_area
  arm64: mm: Remove arch_apei_flush_tlb_one()
  ACPI / APEI: Remove arch_apei_flush_tlb_one()

 arch/arm64/include/asm/acpi.h   | 12 ------
 arch/arm64/include/asm/fixmap.h |  7 ++++
 arch/arm64/mm/mmu.c             |  4 ++
 arch/x86/include/asm/fixmap.h   |  6 +++
 arch/x86/kernel/acpi/apei.c     |  5 ---
 drivers/acpi/apei/ghes.c        | 84 +++++++++--------------------------------
 include/acpi/apei.h             |  1 -
 7 files changed, 34 insertions(+), 85 deletions(-)

-- 
2.15.0.rc2
