From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Aug 2016 13:53:52 +0100
Subject: [PATCH v4 0/4] ARM: kernel: module PLT optimizations
Message-ID: <1472475236-3083-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Jongsung, the O(n^2) search in the PLT allocation code may
disproportionately affect module load time for modules with a larger number
of relocations.

Since the existing routines rather naively take branch instructions into
account that are internal to the module, we can improve the situation
significantly by checking the symbol section index first, and disregarding
symbols that are defined in the same module. Also, we can reduce the
algorithmic complexity to O(n log n) by sorting the reloc section before
processing it, and disregarding zero-addend relocations in the optimization.

Patch #1 merge the core and init PLTs, since the latter is virtually empty
anyway.

Patch #2 implements the optimization to only take SHN_UNDEF symbols into
account.

Patch #3 sort the reloc section, so that the duplicate check can be done by
comparing an entry with the previous one. Since REL entries (as opposed to
RELA entries) do not contain the addend, simply disregard non-zero addends
in the optimization since those are rare anyway.

Patch #4 replaces the brute force search for a matching existing entry in
the PLT generation routine with a simple check against the last entry that
was emitted. This is now sufficient since the relocation section is sorted,
and presented at relocation time in the same order.

Note that this implementation is now mostly aligned with the arm64 version
(with the exception that the arm64 implementation stashes the address of the
PLT entry in the symtab instead of comparing the last emitted entry)

v4:
- Update is_zero_addend_relocation() to take the actual relocation type into
  account rather than treat all encountered jump/call relocations as ARM or
  Thumb2 depending on the mode the kernel was built in. This is not necessary
  in practice, but since the ARM version of apply_relocate() does not reject
  ARM-to-ARM calls in the Thumb2 build, it is required for strict correctness.
  (patch #3)
- added Jongsung's Tested-by (patches #1 - #4)

v3: 
- move the SHN_UNDEF check into the switch statement, so that we only
  dereference the symbol for relocations we care about (#2)
- compare the undecoded addend values bitwise when checking for zero addends,
  rather than fully decoding the offsets and doing an arithmetic comparison
  against '-8' (or '-4' for Thumb)
- added patch #4
   
v2:
- added patch #3

Ard Biesheuvel (4):
  ARM: kernel: merge core and init PLTs
  ARM: kernel: allocate PLT entries only for external symbols
  ARM: kernel: sort relocation sections before allocating PLTs
  ARM: kernel: avoid brute force search on PLT generation

 arch/arm/include/asm/module.h |   6 +-
 arch/arm/kernel/module-plts.c | 243 ++++++++++++--------
 arch/arm/kernel/module.lds    |   3 +-
 3 files changed, 147 insertions(+), 105 deletions(-)

-- 
2.7.4
