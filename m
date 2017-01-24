From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Jan 2017 16:16:38 +0000
Subject: [PATCH v4 0/2] modversions: redefine kcrctab entries as 32-bit values
Message-ID: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
relative CRC pointers', but since relative CRC pointers do not work in
modules, and are actually only needed by powerpc with CONFIG_RELOCATABLE=y,
I have made it a Kconfig selectable feature instead.

Patch #1 introduces the MODULE_REL_CRCS Kconfig symbol, and adds the kbuild
handling of it, i.e., modpost, genksyms and kallsyms.

Patch #2 switches all architectures to 32-bit CRC entries in kcrctab, where
all architectures except powerpc with CONFIG_RELOCATABLE=y use absolute ELF
symbol references as before.

v4: make relative CRCs kconfig selectable
    use absolute CRC symbols in modules regardless of kconfig selection
    split into two patches

v3: emit CRCs into .rodata rather than .rodata.modver, given that the latter
    will be emitted with read-write permissions, making the CRCs end up in a
    writable module segment.

    fold the modpost fix to ensure that the section address is only substracted
    from the symbol address when the ELF object in question is fully linked
    (i.e., ET_DYN or ET_EXEC, and not ET_REL)

v2: update modpost as well, so that genksyms no longer has to emit symbols
    for both the actual CRC value and the reference to where it is stored
    in the image

[0] http://marc.info/?l=linux-arch&m=148493613415294&w=2

Ard Biesheuvel (2):
  kbuild: modversions: add infrastructure for emitting relative CRCs
  modversions: treat symbol CRCs as 32 bit quantities

 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ----
 include/asm-generic/export.h      | 11 ++---
 include/linux/export.h            | 14 ++++++
 include/linux/module.h            | 14 +++---
 init/Kconfig                      |  4 ++
 kernel/module.c                   | 45 ++++++++++----------
 scripts/Makefile.build            |  2 +
 scripts/genksyms/genksyms.c       | 19 ++++++---
 scripts/kallsyms.c                | 12 ++++++
 scripts/mod/modpost.c             | 10 +++++
 12 files changed, 93 insertions(+), 51 deletions(-)

-- 
2.7.4
