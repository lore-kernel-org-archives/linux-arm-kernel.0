From: james.morse@arm.com (James Morse)
Date: Mon, 15 Aug 2016 18:11:59 +0100
Subject: [PATCH v4 0/3] arm64: hibernate: Support DEBUG_PAGEALLOC
Message-ID: <1471281122-26295-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches improve arm64's hibernate support by fixing the hibernate
problem with DEBUG_PAGEALLOC reported by Will.
This also addresses the outstanding comment from Catalin [0] regarding
cleaning of the whole kernel to the PoC. Now we clean two new sections
.mmuoff.{data,text}.

This series is based on v4.8-rc2, and can be retrieved from:
git://linux-arm.org/linux-jm.git -b hibernate/debug_pagealloc/v4

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

James Morse (3):
  arm64: Create sections.h
  arm64: vmlinux.ld: Add .mmuoff.{text,data} sections
  arm64: hibernate: Support DEBUG_PAGEALLOC

 arch/arm64/Kconfig                 |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/arm64/include/asm/sections.h  | 31 +++++++++++++++++++++++
 arch/arm64/include/asm/traps.h     |  6 +----
 arch/arm64/include/asm/virt.h      |  9 +------
 arch/arm64/kernel/alternative.c    |  7 +++---
 arch/arm64/kernel/head.S           | 26 +++++++++++++------
 arch/arm64/kernel/hibernate.c      | 51 +++++++++++++++++++++++++++-----------
 arch/arm64/kernel/probes/kprobes.c |  5 +---
 arch/arm64/kernel/sleep.S          |  2 ++
 arch/arm64/kernel/smp_spin_table.c |  3 ++-
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++
 arch/arm64/mm/pageattr.c           | 40 +++++++++++++++++++++++++++++-
 arch/arm64/mm/proc.S               |  4 +++
 14 files changed, 146 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/include/asm/sections.h

-- 
2.8.0.rc3
