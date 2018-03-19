From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Mar 2018 19:19:52 +0800
Subject: [RFC PATCH 0/6] replace static mapping for pgdir region
Message-ID: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems that are affected by S&M variant 3a, KPTI is not sufficient to
hide the physical placement of the kernel, since the trampoline page is
statically allocated, and the contents of TTBR1_EL1 is visible to attackers.

So instead, use a separate physical allocation and map it at the same
virtual offset as swapper_pg_dir and the trampoline were mapped before.

Ard Biesheuvel (6):
  arm64/mm: add explicit physical address argument to map_kernel_segment
  arm64/mm: create dedicated segment for pgdir mappings
  arm64/mm: use physical address as cpu_replace_ttbr1() argument
  arm64/mm: stop using __pa_symbol() for swapper_pg_dir
  arm64/mm: factor out clear_page() for unmapped memory
  arm64/mm: use independent physical allocation for pgdir segment

 arch/arm64/include/asm/mmu_context.h |  4 +-
 arch/arm64/include/asm/pgtable.h     |  2 +
 arch/arm64/include/asm/sections.h    |  1 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  3 +
 arch/arm64/mm/kasan_init.c           |  4 +-
 arch/arm64/mm/mmu.c                  | 84 ++++++++++----------
 8 files changed, 55 insertions(+), 47 deletions(-)

-- 
2.11.0
