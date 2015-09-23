From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Sep 2015 17:37:36 -0700
Subject: [PATCH v2 0/7] arm64: relax Image placement rules
Message-ID: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the "arm64: update/clarify/relax Image and FDT placement
rules" series I sent a while ago:
(http://article.gmane.org/gmane.linux.ports.arm.kernel/407148)

This has now been split in two series: this second series deals with the
physical and virtual placement of the kernel Image.

This series updates the mapping of the kernel Image and the linear mapping of
system memory to allow more freedom in the choice of placement without affecting
the accessibility of system RAM below the kernel Image, and the mapping
efficiency (i.e., memory can always be mapped in 512 MB or 1 GB blocks).

Changes since v1:
- dropped somewhat unrelated patch #1 and patches #2 and #3 that have been
  merged separately
- rebased onto v4.2-rc3
- tweak the generic early_init_dt_add_memory_arch for our purposes rather than
  clone the implementation completely

Changes since original combined series:
- rebased onto v4.1-rc3
- dropped phys_offset_bias in favor of updating memstart_addr with the bias
  temporarily
- bootstrap the linear mapping of the base of RAM in addition to the linear
  mapping of the statically allocated page tables
- fixed a bug in the handling of the mem= kernel command line parameter.

Known issues:
- the mem= command line parameter works correctly now, but removes memory from
  the bottom first before clipping from the top, which may be undesirable since
  it may discard precious memory below the 4 GB boundary.s

Patch #1 refactors the generic early_init_dt_add_memory_arch implementation to
allow to minimum memblock address to be overridden by the architecture.

Patch #2 changes the memblock_reserve logic so that unused page table
reservations are left unreserved in memblock.

Patch #3 refactors early_fixmap_init() so that we can reuse its core for
bootstrapping other memory mappings.

Patch #4 bootstraps the linear mapping explicitly. Up until now, this was done
implicitly due to the fact that the linear mapping starts at the base of the
kernel Image.

Patch #5 moves the mapping of the kernel Image outside of the linear mapping.

Patch #6 changes the attributes of the linear mapping to non-executable since
we don't execute code from it anymore.

Patch #7 allows the kernel to be loaded at any 2 MB aligned offset in physical
memory, by assigning PHYS_OFFSET based on the available memory and not based on
the physical address of the base of the kernel Image.

Ard Biesheuvel (7):
  of/fdt: make memblock minimum physical address arch configurable
  arm64: use more granular reservations for static page table
    allocations
  arm64: split off early mapping code from early_fixmap_init()
  arm64: mm: explicitly bootstrap the linear mapping
  arm64: move kernel mapping out of linear region
  arm64: map linear region as non-executable
  arm64: allow kernel Image to be loaded anywhere in physical memory

 Documentation/arm64/booting.txt   |  12 +-
 arch/arm64/include/asm/boot.h     |   7 +
 arch/arm64/include/asm/compiler.h |   2 +
 arch/arm64/include/asm/memory.h   |  27 ++-
 arch/arm64/kernel/head.S          |  18 +-
 arch/arm64/kernel/vmlinux.lds.S   |  40 +++-
 arch/arm64/mm/dump.c              |   3 +-
 arch/arm64/mm/init.c              |  56 ++++-
 arch/arm64/mm/mmu.c               | 230 +++++++++++++-------
 drivers/of/fdt.c                  |   5 +-
 10 files changed, 290 insertions(+), 110 deletions(-)

-- 
1.9.1
