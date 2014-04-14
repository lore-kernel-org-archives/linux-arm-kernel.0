From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 14 Apr 2014 16:39:51 +0900
Subject: [PATCH 0/8] Support 4 levels of translation tables for ARM64
Message-ID: <000001cf57b4$b86facd0$294f0670$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This patchset supports 4 levels of tranlsation tables for ARM64.

Firstly, the patchset decouples page size from level of translation tables
as taking account into the comment from Catalin Marinas:
http://www.spinics.net/linux/lists/arm-kernel/msg319552.html

Then, it implements 4 levels of translation tables for both native, HYP
and stage2 sides.

This series is validated with Fast Models and kvmtool as platform and guest
launcher, respectively.

Jungseok Lee (8):
      arm64: Use pr_* instead of printk
      arm/arm64: KVM: Fix line length exceeding 80 characters
      arm64: Decouple page size from level of translation tables
      arm64: Introduce a kernel configuration option for VA_BITS
      arm64: Add a description on 48-bit address space with 4KB pages
      arm64: Add 4 levels of page tables definition with 4KB pages
      arm64: mm: Implement 4 levels of translation tables
      arm64: KVM: Implement 4 levels of translation tables for HYP and stage2

Documentation/arm64/memory.txt                |   59 ++++++++++--
 arch/arm/kvm/mmu.c                            |  100 ++++++++++++++++++---
 arch/arm64/Kconfig                            |   51 ++++++++++-
 arch/arm64/include/asm/kvm_arm.h              |   20 +++++
 arch/arm64/include/asm/kvm_mmu.h              |    1 +
 arch/arm64/include/asm/memory.h               |    6 +-
 arch/arm64/include/asm/page.h                 |    6 +-
 arch/arm64/include/asm/pgalloc.h              |   24 ++++-
 arch/arm64/include/asm/pgtable-4level-hwdef.h |   50 +++++++++++
 arch/arm64/include/asm/pgtable-4level-types.h |   71 +++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   10 ++-
 arch/arm64/include/asm/pgtable.h              |   52 +++++++++--
 arch/arm64/include/asm/tlb.h                  |   10 ++-
 arch/arm64/kernel/head.S                      |   45 +++++++++-
 arch/arm64/kernel/traps.c                     |   19 ++--
 arch/arm64/mm/fault.c                         |    1 +
 arch/arm64/mm/mmu.c                           |   14 ++-
 17 files changed, 488 insertions(+), 51 deletions(-)
