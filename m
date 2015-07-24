From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 16:37:40 +0100
Subject: [PATCH v3 0/9] arm64: Use BRK instruction for generic BUG traps
Message-ID: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Final repost to address outstanding minor comments.

Note that I have dropped tags from the following non-trivially changed
patches:

 * patch 7/9 arm64/debug: Add missing #includes

   (Merged in remnants of dropped patch "arm64: esr.h type fixes and
   cleanup")

 * patch 6/9 arm64/debug: Simplify BRK insn opcode declarations

   (Added truncating type casts for ESR value assignment, to silence
   compiler warnings.)


Changes since v2:

 * Get rid of broad-brush type annotation changes in <asm/esr.h>.
   They are replaced with a couple of explicit casts where the affected
   constants are used.  The only purpose of this is to silence harmless
   compiler warnings.


Changes since v1:

 * Modified BRK immediate for BUG so that it doesn't overlap the range
   allocated for KGDB.

 * Typo fixes.

 * Don't assume that BUG() kills the thread, so that catching BUGs in
   kgdb works again.

 * Separate header for the BRK immediates removed, at Will's request.
   I've retained the other refactoring since it contains useful tidy-
   ups, but some of that could go away if desired.


Original cover letter:

Currently, the minimal default BUG() implementation from asm-generic is
used for arm64.

This series uses the BRK software breakpoint instruction to generate a
trap instead, similarly to most other arches, with the generic BUG code
generating the dmesg boilerplate.  This eliminates a fair amount of
inlined code at BUG() and WARN() sites.


This work makes it look increasingly desirable to collect BRK immediates
together in one place.  Patches 1-7 do some refactoring to prepare for
this, and patch 8 moves the definitions to a fresh header, <asm/brk.h>.

Patch 9 provides the BRK-based GENERIC_BUG support for arm64.

A side-effect of this change is that WARNs are now generated via a
different bit of generic code (lib/bug.c:report_bug()) that no longer
prints a backtrace (compare kernel/panic.c:warn_slowpath_common()).)  I
will post a separate mini-RFC series to address that in the generic
code.  Patch 10 hacks a backtrace back into the arm64 arch code in the
meantime.

[...]


Dave Martin (9):
  arm64/debug: Eliminate magic number for size of BRK instruction
  arm64/debug: Mask off all reserved bits from generated ESR values
  arm64/debug: Eliminate magic number from ESR template definition
  arm64/debug: More consistent naming for the BRK ESR template macro
  arm64/debug: Move BRK ESR template macro into <asm/esr.h>
  arm64/debug: Simplify BRK insn opcode declarations
  arm64/debug: Add missing #includes
  arm64/BUG: Use BRK instruction for generic BUG traps
  arm64/BUG: Show explicit backtrace for WARNs

 arch/arm64/Kconfig                      |    8 ++++
 arch/arm64/include/asm/bug.h            |   64 +++++++++++++++++++++++++++++++
 arch/arm64/include/asm/debug-monitors.h |   38 +++++++-----------
 arch/arm64/include/asm/esr.h            |    9 +++++
 arch/arm64/kernel/kgdb.c                |   12 +++---
 arch/arm64/kernel/traps.c               |   61 ++++++++++++++++++++++++++++-
 arch/arm64/mm/fault.c                   |   12 +++++-
 7 files changed, 170 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/include/asm/bug.h

-- 
1.7.10.4
