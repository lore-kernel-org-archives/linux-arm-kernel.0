From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  3 Dec 2016 14:05:36 +0000
Subject: [PATCH 0/2] Fix fallouts from asm/opcodes.h removal
Message-ID: <20161203140538.23525-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the asm/opcodes.h file was removed, two bugs have cropped up:

- probes.h contains a reference to asm/opcodes.h that was missed

- An ugly (and alas familiar) bug has reappeared, leading to obscure
  compilation errors when a .inst is part of an alternative and that
  the "auto nop" feature is used to pad the alternative sequence (and
  the whole thing is assembled with an old version of gas). This is
  triggered again now that we generate SET_PSTATE_PAN/UAO using .inst.

The first bug is easy to fix, while the second requires some really
ugly (if limited) surgery using the .fill directive to replace the
"nops" macro.

Marc Zyngier (2):
  arm64: Remove reference to asm/opcodes.h
  arm64: alternatives: Work around NOP generation with broken assembler

 arch/arm64/include/asm/alternative.h | 12 +++++++++++-
 arch/arm64/include/asm/probes.h      |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.10.2
