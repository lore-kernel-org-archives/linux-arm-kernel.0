From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 15:57:22 +0100
Subject: [PATCH v3 0/4] arm64: avoid early __va translations
Message-ID: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a somewhat cleaner approach for dealing with the issue that the
early FDT performs __va() translations before the linear mapping has been
set up. Being able to defer the assignment of memstart_addr until after we
have discovered all of memory is an important piece of functionality, not
only for KASLR but also for mapping the linear region as efficiently as
possible.

Changes since v2:
- replace __weak function in patches #1 and #2 with a preprocessor macro
- add patch to address the circular header dependency when including
  asm/bug.h in asm/memory.h
- turned the hack that adds the BUG_ON() into a proper patch

Patch #1 refactors the early FDT code so that the actual assignment of
initrd_start and initrd_end (which is where the __va() translations are
performed) can be overridden in architecture specific code.

Patch #2 performs the override, and only records the physical addresses
as they are found in the /chosen node, or on the command line, and defers
the __va() translation until after memstart_addr has been assigned.

Patch #3 reshuffles some #includes and #defines so that asm/bug.h can be
included (and used) in asm/memory.h

Patch #4 implements a BUG_ON() check to ensure that no references to
memstart_addr are made before it has been assigned.

Ard Biesheuvel (4):
  of/fdt: factor out assignment of initrd_start/initrd_end
  arm64: defer __va translation of initrd_start and initrd_end
  arm64: prevent potential circular header dependencies in asm/bug.h
  arm64: prevent __va() translations before memstart_addr is assigned

 arch/arm64/include/asm/bug.h            |  2 +-
 arch/arm64/include/asm/debug-monitors.h |  2 +-
 arch/arm64/include/asm/memory.h         | 12 ++++++++++-
 arch/arm64/kvm/hyp/debug-sr.c           |  1 +
 arch/arm64/mm/init.c                    | 21 +++++++++++++++-----
 drivers/of/fdt.c                        | 14 ++++++++++---
 6 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.5.0
