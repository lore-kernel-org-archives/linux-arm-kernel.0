From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Sep 2017 12:57:16 -0700
Subject: [PATCH v4 0/5] add support for relative references in special sections
Message-ID: <20170920195721.7939-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for emitting special sections such as initcall arrays,
PCI fixups and tracepoints as relative references rather than absolute
references. This reduces the size by 50% on 64-bit architectures, but
more importantly, it removes the need for carrying relocation metadata
for these sections in relocatables kernels (e.g., for KASLR) that need
to fix up these absolute references at boot time. On arm64, this reduces
the vmlinux footprint of such a reference by 8x (8 byte absolute reference
+ 24 byte RELA entry vs 4 byte relative reference)

Patch #2 was sent out before as a single patch. This series supersedes
the previous submission. This version makes relative ksymtab entries
dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
than trying to infer from kbuild test robot replies for which architectures
it should be blacklisted.

Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
and sets it for the main architectures that are expected to benefit the
most from this feature, i.e., 64-bit architectures, and ones that use
runtime relocation.

Patches #3 - #5 implement relative references for initcallls, PCI fixups
and tracepoints, respectively, all of which produce sections with order
~1000 entries on an arm64 defconfig kernel with tracing enabled. This
means we save about 28 KB of vmlinux space for each of these patches.

For the arm64 kernel, all patches combined reduce the size of vmlinux
by about 300 KB (with KASLR enabled).

Branch:
git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git relative-special-sections-v4

Changes since v3:
- fix module unload issue in patch #5 reported by Jessica, by reusing the
  updated routine for_each_tracepoint_range() for the quiescent check at
  module unload time; this requires this routine to be moved before
  tracepoint_module_going() in kernel/tracepoint.c
- add Jessica's ack to #2
- rebase onto v4.14-rc1

Changes since v2:
- Revert my slightly misguided attempt to appease checkpatch, which resulted
  in needless churn and worse code. This v3 is based on v1 with a few tweaks
  that were actually reasonable checkpatch warnings: unnecessary braces (as
  pointed out by Ingo) and other minor whitespace misdemeanors.

Changes since v1:
- Remove checkpatch errors to the extent feasible: in some cases, this
  involves moving extern declarations into C files, and switching to
  struct definitions rather than typedefs. Some errors are impossible
  to fix: please find the remaining ones after the diffstat.
- Used 'int' instead if 'signed int' for the various offset fields: there
  is no ambiguity between architectures regarding its signedness (unlike
  'char')
- Refactor the different patches to be more uniform in the way they define
  the section entry type and accessors in the .h file, and avoid the need to
  add #ifdefs to the C code.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jessica Yu <jeyu@kernel.org>

Ard Biesheuvel (5):
  arch: enable relative relocations for arm64, power, x86, s390 and x86
  module: use relative references for __ksymtab entries
  init: allow initcall tables to be emitted using relative references
  drivers: pci: add support for relative addressing in quirk tables
  kernel: tracepoints: add support for relative references

 arch/Kconfig                    | 10 ++++
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/Kconfig            |  1 +
 arch/s390/Kconfig               |  1 +
 arch/x86/Kconfig                |  1 +
 arch/x86/include/asm/Kbuild     |  1 +
 arch/x86/include/asm/export.h   |  4 --
 drivers/pci/quirks.c            | 13 +++--
 include/asm-generic/export.h    | 12 ++++-
 include/linux/compiler.h        | 11 +++++
 include/linux/export.h          | 45 +++++++++++++-----
 include/linux/init.h            | 44 ++++++++++++-----
 include/linux/pci.h             | 20 ++++++++
 include/linux/tracepoint.h      | 19 ++++++--
 init/main.c                     | 32 ++++++-------
 kernel/module.c                 | 33 ++++++++++---
 kernel/printk/printk.c          |  4 +-
 kernel/tracepoint.c             | 50 +++++++++++---------
 security/security.c             |  4 +-
 20 files changed, 223 insertions(+), 85 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

-- 
2.11.0
