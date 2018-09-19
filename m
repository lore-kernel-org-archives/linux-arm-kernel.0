From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Sep 2018 23:51:35 -0700
Subject: [PATCH v3 0/9] add support for relative references in jump tables
Message-ID: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements support for emitting the data structures associated
with jump tables as 32-bit relative references instead of absolute
references, which take up more space on builds that target 64-bit
architectures, or implement self relocation [or both].

This series enables it for arm64 and x86, although other architectures
might benefit as well.

Patch #1 does some preparatory refactoring before patch #2 introduces the
generic pieces required for using relative references.

Patch #3 wires everything up for arm64.

Patch #4 introduces support for handling 64-bit place relative relocations
on x86_64 (see 'Changes since v1' below)

For x86, patch #5 applies some preparatory changes for the arch specific
jump label C code, which is a lot more involved than on arm64, which is
why it is split off in this case. Patch #6 wires it up for x86 as well.

Patch #7 and #8 implement the changes so that the jump_entry arrays reside
in ro_after_init memory rather than remain fully writable all of the time.

Patch #9 enables the feature for s390 (contributed by Heiko)

Changes since v2:
- fix breakage in user mode x86 kernel due to missing definition of the
  R_X86_64_PC64 symbolic constant
- add acks from Jessica and Kees
- add s390 enablement patch

Changes since v1:
- change the relative reference to the static key to a 64-bit wide one on 64
  bit architectures; this is necessary on arm64, which allows modules to
  reside anywhere within a 4 GB window covering the core kernel text, which
  means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
  Note that x86_64 changes are in preparation that widen the relocation
  range as well (using the PIE linker), so I assumed that the same change
  is appropriate for x86 as well.
- add patch #4 to handle the relocations emitted by the compiler as a result
  of the change above
- added patches to move the jump_entry arrays to ro_after_init memory, so
  that they are not as easily corrupted or manipulated.
- add Will's ack to patch #3

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org> 
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (8):
  kernel/jump_label: abstract jump_entry member accessors
  kernel/jump_label: implement generic support for relative references
  arm64/kernel: jump_label: switch to relative references
  x86: add support for 64-bit place relative relocations
  x86: jump_label: switch to jump_entry accessors
  x86/kernel: jump_table: use relative references
  jump_label: annotate entries that operate on __init code earlier
  jump_table: move entries into ro_after_init region

Heiko Carstens (1):
  s390/jump_label: switch to relative references

 arch/Kconfig                        |   3 +
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/jump_label.h |  38 ++++----
 arch/arm64/kernel/jump_label.c      |   6 +-
 arch/s390/Kconfig                   |   1 +
 arch/s390/include/asm/jump_label.h  |  40 ++++----
 arch/s390/kernel/jump_label.c       |  11 ++-
 arch/s390/kernel/vmlinux.lds.S      |   1 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/elf.h          |   3 +-
 arch/x86/include/asm/jump_label.h   |  24 ++---
 arch/x86/kernel/jump_label.c        |  62 +++++-------
 arch/x86/kernel/module.c            |   6 ++
 arch/x86/tools/relocs.c             |  10 ++
 arch/x86/um/asm/elf.h               |   3 +-
 include/asm-generic/vmlinux.lds.h   |  11 ++-
 include/linux/jump_label.h          |  65 ++++++++++++-
 init/main.c                         |   1 -
 kernel/jump_label.c                 | 100 +++++++++-----------
 kernel/module.c                     |   9 ++
 tools/objtool/special.c             |   4 +-
 21 files changed, 226 insertions(+), 174 deletions(-)

-- 
2.17.1
