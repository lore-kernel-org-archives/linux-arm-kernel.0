From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jun 2018 18:05:59 +0200
Subject: [PATCH 0/5] add support for relative references in jump tables
Message-ID: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
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

For x86, patch #4 applies some preparatory changes for the arch specific
jump label C code, which is a lot more involved than on arm64, which is
why it is split off in this case. Patch #5 wires it up for x86 as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (5):
  kernel/jump_label: abstract jump_entry member accessors
  kernel/jump_label: implement generic support for relative references
  arm64/kernel: jump_label: switch to relative references
  x86: jump_label: switch to jump_entry accessors
  x86/kernel: jump_table: use relative references

 arch/Kconfig                        |  3 +
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/jump_label.h | 16 ++---
 arch/arm64/kernel/jump_label.c      |  6 +-
 arch/x86/Kconfig                    |  1 +
 arch/x86/include/asm/jump_label.h   | 28 +++------
 arch/x86/kernel/jump_label.c        | 43 +++++++------
 include/linux/jump_label.h          | 64 ++++++++++++++++++++
 kernel/jump_label.c                 | 56 ++++++++++-------
 tools/objtool/special.c             |  4 +-
 10 files changed, 145 insertions(+), 77 deletions(-)

-- 
2.11.0
