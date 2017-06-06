From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Jun 2017 17:00:20 +0000
Subject: [PATCH v3 0/2] arm64: ftrace: fix interop issues with module PLTs
Message-ID: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 ftrace code assumes that all core kernel symbols are within the
range of an ordinary branch instruction from anywhere in the kernel, even
in modules. While this is usually the case, it may not be true when running
with KASLR enabled.

This series fixes two distinct but related issues involving ftrace under
KASLR:

- the initial sweep over all _mcount() calls in newly loaded modules
  validates those calls by comparing each to a 'bl _mcount' opcode, which
  will fail if _mcount() [which is in the core kernel] is out of range, and
  which will result in false negatives, given that those call sites will
  contain a correct branch to _mcount(), but via a PLT entry (patch #1)

- patching up those NOPs into calls to ftrace_caller() [which is the only
  ftrace branch target that we ever use on arm64, IIUC] will fail in the
  same way, and needs to be redirected via a trampoline as well (patch #2)

v3:
- perform partial validation on 'bl _mcount' call sites, i.e., perform full
  validation unless the call site is in a module and is in fact too far away
  from the branch target, in which case we check that the instruction is a
  bl instruction pointing somewhere inside the module itself (#1). Note that
  this will correctly identify the trampolines added in #2 as valid branch
  targets, with the caveat that the 'mod' parameter is only supplied by the
  ftrace framework at module load time.
- disable preemption around __module_text_address(): this is not really needed
  given that ftrace_lock will prevent the module from being unloaded while we
  are using it, but the code in module.c contains an assert for it. (#1, #2)
- add barrier between updating the trampoline target field and patching the
  instruction that invokes it (#2)
- refactored the code so it is obviously identical to the old code when
  CONFIG_ARM64_MODULE_PLTS is disabled. (#1, #2)

v2:
- no changes to #1
- don't hardcode references to ftrace_caller() (#2)
- avoid a stack frame for the trampoline, given that it will confuse the
  ftrace code (#2)

Ard Biesheuvel (2):
  arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
  arm64: ftrace: add support for far branches to dynamic ftrace

 arch/arm64/Kconfig              |  2 +-
 arch/arm64/Makefile             |  3 +
 arch/arm64/include/asm/module.h |  3 +
 arch/arm64/kernel/Makefile      |  3 +
 arch/arm64/kernel/ftrace-mod.S  | 18 ++++
 arch/arm64/kernel/ftrace.c      | 97 +++++++++++++++++++-
 arch/arm64/kernel/module.c      |  6 +-
 7 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kernel/ftrace-mod.S

-- 
2.9.3
