From: james.morse@arm.com (James Morse)
Date: Wed, 24 Aug 2016 18:27:27 +0100
Subject: [PATCH v6 0/3] arm64: hibernate: Support DEBUG_PAGEALLOC
Message-ID: <1472059650-591-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches improve arm64's hibernate support by fixing the hibernate
problem with DEBUG_PAGEALLOC reported by Will.
This also addresses the outstanding comment from Catalin [0] regarding
cleaning of the whole kernel to the PoC. Now we clean three new sections
.mmuoff.{*.data,text}. The mmuoff data is split into two sections depending
on whether they are read or written the MMU off as the alignment is different.
The two mmuoff.data sections share their start/end markers as the difference
should only matter to the linker.

This series is based on v4.8-rc3, and can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/debug_pagealloc/v6

Changes since v5:
 * Moved .mmuoff.text into .idmap.text,
 * Moved ALIGN() out of .mmuoff.data.read in case this section gets removed.
 * Removed stray "don't"
 * Added pte_mkpresent() and pte_clear_rdonly(), used to make the bit masking
   in _copy_pte() more readable.
 * Removed 'pte_pfn(src_pte) == pfn' paranoia, replaced with BUG_ON().
 * Added comment against kern_page_present(), removed superfluous pte_none()

Changes since v4:
 * Moved alignment rules out of assembly into the linker script.
 * Split mmuoff.data into two sections one written with the mmu off, the other
   read with the mmu off. CWG alignment only applies to mmuoff.write.data.
 * Fixed PE/COFF alignment breakage.

Changes since v3:
 * Pad mmuoff.data section to CWG.
 * Specified the .mmuoff.data section for secondary_holding_pen_release in C
 * Added irqentry_text start/end to sections.h
 * Updated patch 1 for kprobes idmap/hyp_idmap declarations.

Changes since v2:
 * Added a mmuoff.data section for secondary_holding_pen_release etc.

Changes since v1:
 * Added .mmuoff.text section and gathered functions together.
 * Put sections.h in alphabetical order.

[v1] http://www.spinics.net/lists/arm-kernel/msg507805.html
[v2] http://permalink.gmane.org/gmane.linux.power-management.general/77467
[v3] https://www.spinics.net/lists/arm-kernel/msg514644.html
[v4] https://www.spinics.net/lists/arm-kernel/msg477769.html
[v5] https://www.spinics.net/lists/arm-kernel/msg525605.html

[0] http://www.spinics.net/lists/arm-kernel/msg499305.html


James Morse (3):
  arm64: Create sections.h
  arm64: vmlinux.ld: Add mmuoff data sections and move mmuoff text into
    idmap
  arm64: hibernate: Support DEBUG_PAGEALLOC

 arch/arm64/Kconfig                 |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/arm64/include/asm/pgtable.h   | 10 ++++++++
 arch/arm64/include/asm/sections.h  | 30 ++++++++++++++++++++++
 arch/arm64/include/asm/traps.h     |  6 +----
 arch/arm64/include/asm/virt.h      |  9 +------
 arch/arm64/kernel/alternative.c    |  7 +++---
 arch/arm64/kernel/head.S           | 25 +++++++++++--------
 arch/arm64/kernel/hibernate.c      | 51 +++++++++++++++++++++++++++-----------
 arch/arm64/kernel/probes/kprobes.c |  5 +---
 arch/arm64/kernel/sleep.S          |  2 +-
 arch/arm64/kernel/smp_spin_table.c |  3 ++-
 arch/arm64/kernel/vmlinux.lds.S    | 19 ++++++++++++++
 arch/arm64/mm/pageattr.c           | 41 +++++++++++++++++++++++++++++-
 arch/arm64/mm/proc.S               |  4 +++
 15 files changed, 163 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/include/asm/sections.h

-- 
2.8.0.rc3
