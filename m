From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Aug 2016 17:38:42 +0200
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic 
Message-ID: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are various places in the ARM kernel where the following pattern
is used to create a PC-relative reference that is valid even before the
MMU is on:

     adr    rX, 1f
     ldr    rY, [rX]
     add    rX, rX, rY
     ...
  1: .long  <symbol> - .   

or
     adr    rX, 1f
     ldmia  rX, {rY .. rY+n}
     sub    rX, rX, rY
     add    rY+1, rY+1, rX
     add    rY+2, rY+2, rX
     ...
  1: .long  .
     .long  <symbolY>
     .long  <symbolY+1>
     ...

Both cases can be greatly simplified by letting the linker do the
calculations for us. This series implements adr_l, ldr_l and str_l
macros, and uses them to simplify a couple of instances of the above
patterns.

Ard Biesheuvel (8):
  ARM: assembler: introduce adr_l, ldr_l and str_l macros
  ARM: head-common.S: use PC-relative insn sequence for __proc_info
  ARM: head-common.S: use PC-relative insn sequence for __turn_mmu_on
  ARM: head.S: use PC-relative insn sequence for secondary_data
  ARM: head: use PC-relative insn sequence for __smp_alt
  ARM: sleep.S: use PC-relative insn sequence for
    sleep_save_sp/mpidr_hash
  ARM: head.S: use PC-relative insn sequences for __fixup_pv_table
  ARM: head.S: use PC relative insn sequence to calculate PHYS_OFFSET

 arch/arm/include/asm/assembler.h | 59 ++++++++++++++
 arch/arm/kernel/head-common.S    | 22 ++---
 arch/arm/kernel/head.S           | 86 +++++---------------
 arch/arm/kernel/sleep.S          | 15 +---
 4 files changed, 88 insertions(+), 94 deletions(-)

-- 
2.7.4
