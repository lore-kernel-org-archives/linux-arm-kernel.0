From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Oct 2018 11:56:56 -0600
Subject: [PATCH v2 0/6] sparsemem support for RISC-V
Message-ID: <20181015175702.9036-1-logang@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements sparsemem on RISC-V. The first few patches
move some code in existing architectures into common helpers
so they can be used by the new RISC-V implementation. The final
patch actually adds sparsmem support to RISC-V.

This is the first small step in supporting P2P on RISC-V.

--

Changes in v2:

* Rebase on v4.19-rc8
* Move the STRUCT_PAGE_MAX_SHIFT define into a common header (near
  the definition of struct page). As suggested by Christoph.
* Clean up the unnecessary nid variable in the memblocks_present()
  function, per Christoph.
* Collected tags from Palmer and Catalin.

--
Logan Gunthorpe (6):
  mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
  mm/sparse: add common helper to mark all memblocks present
  ARM: mm: make use of new memblocks_present() helper
  arm64: mm: make use of new memblocks_present() helper
  sh: mm: make use of new memblocks_present() helper
  RISC-V: Implement sparsemem

 arch/arm/mm/init.c                 | 17 +----------------
 arch/arm64/include/asm/memory.h    |  9 ---------
 arch/arm64/mm/init.c               | 28 +---------------------------
 arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h   | 21 +++++++++++++++++----
 arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
 arch/riscv/kernel/setup.c          |  4 +++-
 arch/riscv/mm/init.c               |  8 ++++++++
 arch/sh/mm/init.c                  |  7 +------
 include/asm-generic/fixmap.h       |  1 +
 include/linux/mm_types.h           |  5 +++++
 include/linux/mmzone.h             |  6 ++++++
 mm/sparse.c                        | 14 ++++++++++++++
 13 files changed, 91 insertions(+), 63 deletions(-)
 create mode 100644 arch/riscv/include/asm/sparsemem.h

--
2.19.0
