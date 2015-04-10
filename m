From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:44 +0200
Subject: [PATCH v3 00/11] arm64: update/clarify/relax Image and FDT placement
 rules
Message-ID: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series came about after Mark Rutland brought up the fact that the current
FDT placement logic used by the EFI stub is flawed. But actually, it turned out
that the documentation for both the Image and FDT placement was incorrect as
well, or confusing at the very least.

Changes since v2:
This is a complete overhaul of the previous version. The FDT changes are mostly
equivalent, but have been reimplemented in a way that does not rely on the
linear mapping to have been initialized yet. This includes changes to the fixmap
code itself to not rely on that either. Combined with the ID map reduction in
patch #1, this paves the way for relaxing the Image placement requirements as
well, i.e., the kernel Image can now be placed anywhere in memory without
affecting the accessibility of memory below it, or causing the resulting mapping
to be less efficient due to physical and virtual memory to not be relatively
aligned.

Changes since v1:
- patch #1: split off reservation of the FDT binary itself from the memreserve
  processing, since the former assumes the FDT is accessed via the linear
  mapping, which we are about to change
- patch #2: mention the older, stricter FDT placement rules in booting.txt,
  get rid of early_print,
  use correct format specifier for phys_addr_t,
  use R/O mapping for FDT,
- patches #3 .. #5: add R-b, minor style and grammar tweaks

Ard Biesheuvel (11):
  arm64: reduce ID map to a single page
  arm64: drop sleep_idmap_phys and clean up cpu_resume()
  of/fdt: split off FDT self reservation from memreserve processing
  arm64: use fixmap region for permanent FDT mapping
  arm64/efi: adapt to relaxed FDT placement requirements
  arm64: implement our own early_init_dt_add_memory_arch()
  arm64: fixmap: allow init before linear mapping is set up
  arm64: mm: explicitly bootstrap the linear mapping
  arm64: move kernel mapping out of linear region
  arm64: allow kernel Image to be loaded anywhere in physical memory
  arm64/efi: adapt to relaxed kernel Image placement requirements

 Documentation/arm64/booting.txt         |  25 ++-
 arch/arm/mm/init.c                      |   1 +
 arch/arm64/include/asm/compiler.h       |   2 +
 arch/arm64/include/asm/efi.h            |   8 +-
 arch/arm64/include/asm/fixmap.h         |   9 ++
 arch/arm64/include/asm/memory.h         |  15 +-
 arch/arm64/include/asm/mmu.h            |   1 +
 arch/arm64/kernel/Makefile              |   1 +
 arch/arm64/kernel/efi-stub.c            |   4 +-
 arch/arm64/kernel/head.S                |  60 ++-----
 arch/arm64/kernel/setup.c               |  45 +++---
 arch/arm64/kernel/sleep.S               |   9 +-
 arch/arm64/kernel/suspend.c             |   3 -
 arch/arm64/kernel/vmlinux.lds.S         |  35 ++++-
 arch/arm64/mm/init.c                    |  35 +++++
 arch/arm64/mm/mmu.c                     | 271 ++++++++++++++++++++++++--------
 arch/arm64/mm/proc.S                    |   3 +-
 arch/powerpc/kernel/prom.c              |   1 +
 drivers/firmware/efi/libstub/arm-stub.c |   5 +-
 drivers/firmware/efi/libstub/efistub.h  |   1 -
 drivers/firmware/efi/libstub/fdt.c      |  23 +--
 drivers/of/fdt.c                        |  19 ++-
 include/linux/of_fdt.h                  |   2 +
 23 files changed, 380 insertions(+), 198 deletions(-)

-- 
1.8.3.2
