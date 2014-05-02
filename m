From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 02 May 2014 14:44:56 +0900
Subject: [PATCH v5 0/6] Support 4 levels of translation tables for ARM64
In-Reply-To: <000001cf64e5$c2d71e40$48855ac0$@samsung.com>
References: <000001cf64e5$c2d71e40$48855ac0$@samsung.com>
Message-ID: <06d401cf65c9$a60e2350$f22a69f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jungseok Lee wrote:
> 
> Hi All,
> 
> This v5 patchset supports 4 levels of tranlsation tables for ARM64.
> 
> Firstly, the patchset introduces virtual address space size and
> translation level options as taking account into the comment from
> Catalin Marinas:
> http://www.spinics.net/linux/lists/arm-kernel/msg319552.html
> 
> Then, it implements 4 levels of translation tables for native, HYP and
> stage2 sides.
> 
> All ARMv8 and ARMv7 related changes are validated with FastModels+kvmtool
> and
> A15+QEMU, respectively.
> 
> Changes since v1:
> - fixed unmatched data types as per Steve's comment
> - removed unnecessary #ifdef in arch/arm64/mm/* as per Steve's comment
> - revised create_pgd_entry to deal with PUD entry as per Steve's comment
> - introduced a macro for initial memblock limit as per Steve's comment
> - dropped "Fix line length exceeding 80 characters" patch as per Marc's
> comment
> - removed unnecessary #ifdef in arch/arm/kvm/mmu.c as per Marc's comment
> - added a macro for a number of objects of as per Marc's comment
> 
> Changes since v2:
> - revised some macros in a generic way as per Marc's comment
> - added a 2 level option for kvm mmu cache allocation as per Marc's
> comment
> 
> Changes since v3:
> - added #ifdef to decide swapper and idmap size as per Steve's comment
> - introduced Steve's create_pgd_entry
> 
> Changes since v4:
> - hided translation level options from menuconfig as per Catalin's comment
> - dropped some printk changes as per Mitchel's comment
> - squashed VA_BITS related patches into a single patch
> 
> Jungseok Lee (6):
>   arm64: Use pr_* instead of printk
>   arm64: Introduce VA_BITS and translation level options
>   arm64: Add a description on 48-bit address space with 4KB pages
>   arm64: Add 4 levels of page tables definition with 4KB pages
>   arm64: mm: Implement 4 levels of translation tables
>   arm64: KVM: Implement 4 levels of translation tables for HYP and
>     stage2
> 
>  Documentation/arm64/memory.txt                |   59 ++++++++++++++---
>  arch/arm/include/asm/kvm_mmu.h                |   10 +++
>  arch/arm/kvm/mmu.c                            |   88
+++++++++++++++++++++----
>  arch/arm64/Kconfig                            |   53 ++++++++++++++-
>  arch/arm64/include/asm/kvm_arm.h              |   34 ++++++++--
>  arch/arm64/include/asm/kvm_mmu.h              |   12 ++++
>  arch/arm64/include/asm/memblock.h             |    6 ++
>  arch/arm64/include/asm/memory.h               |    6 +-
>  arch/arm64/include/asm/page.h                 |    6 +-
>  arch/arm64/include/asm/pgalloc.h              |   24 ++++++-
>  arch/arm64/include/asm/pgtable-4level-hwdef.h |   50 ++++++++++++++
>  arch/arm64/include/asm/pgtable-4level-types.h |   71 ++++++++++++++++++++
>  arch/arm64/include/asm/pgtable-hwdef.h        |    8 ++-
>  arch/arm64/include/asm/pgtable.h              |   53 +++++++++++++--
>  arch/arm64/include/asm/tlb.h                  |   11 +++-
>  arch/arm64/kernel/head.S                      |   46 ++++++++++---
>  arch/arm64/kernel/traps.c                     |   13 ++--
>  arch/arm64/mm/fault.c                         |    1 +
>  arch/arm64/mm/mmu.c                           |   16 +++--
>  19 files changed, 507 insertions(+), 60 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pgtable-4level-hwdef.h
>  create mode 100644 arch/arm64/include/asm/pgtable-4level-types.h
> 
> --
> 1.7.10.4

Looks good to me and Samsung SoCs stuff :-)

All of this series:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin
