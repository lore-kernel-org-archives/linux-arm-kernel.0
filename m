From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 May 2015 10:40:50 +0100
Subject: [PATCH 0/3] arm64: alternative patching rework
Message-ID: <1432806053-987-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current alternative instruction framework is not kind to branches,
potentially leading to all kind of hacks in the code that uses
alternatives. This series expands it to deal with immediate and
conditional branches.

This is a rewrite of fef7f2b20103, which got reverted in b9a95e85bbc
as it was breaking unsuspecting branches inside an alternate
sequence. It now also deals with conditional branches (instead of just
asserting a BUG).

Another nit is addressed by the last patch, where GAS gets confused by
the combinaison of a .inst directive (as used by the msr_s/mrs_s
pseudo-instruction), a label, and a .if directive evaluating said
label. As this is exactly what the alternative framework uses to
detect length mismatch, this patch reverts to using a pair .org
directives in a creative way.

This has been tested on v4.1-rc5.

Marc Zyngier (3):
  arm64: insn: Add aarch64_{get,set}_branch_offset
  arm64: alternative: Allow immediate branch as alternative instruction
  arm64: alternative: Work around .inst assembler bugs

 arch/arm64/include/asm/alternative-asm.h | 29 -------------
 arch/arm64/include/asm/alternative.h     | 52 +++++++++++++++++++++--
 arch/arm64/include/asm/insn.h            |  3 ++
 arch/arm64/kernel/alternative.c          | 71 +++++++++++++++++++++++++++++---
 arch/arm64/kernel/entry.S                |  2 +-
 arch/arm64/kernel/insn.c                 | 60 +++++++++++++++++++++++++++
 arch/arm64/mm/cache.S                    |  2 +-
 7 files changed, 179 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm64/include/asm/alternative-asm.h

-- 
2.1.4
