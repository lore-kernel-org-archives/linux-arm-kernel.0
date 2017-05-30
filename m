From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 May 2017 13:52:18 +0000
Subject: [PATCH v2 0/2] arm64: ftrace: fix interop issues with module PLTs
Message-ID: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
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

v2:
- no changes to #1
- don't hardcode references to ftrace_caller() (#2)
- avoid a stack frame for the trampoline, given that it will confuse the
  ftrace code (#2)

Ard Biesheuvel (2):
  arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
  arm64: ftrace: add support for far branches to dynamic ftrace

 arch/arm64/Kconfig              |  2 +-
 arch/arm64/Makefile             |  3 ++
 arch/arm64/include/asm/module.h |  3 ++
 arch/arm64/kernel/Makefile      |  3 ++
 arch/arm64/kernel/ftrace-mod.S  | 18 +++++++
 arch/arm64/kernel/ftrace.c      | 57 ++++++++++++++++++--
 arch/arm64/kernel/module-plts.c | 10 ++++
 7 files changed, 91 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kernel/ftrace-mod.S

-- 
2.9.3
