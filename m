From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 19:52:53 +0100
Subject: [PATCH v4 0/4] ARM: extend VA range of ID map for core kernel and KVM
Message-ID: <1426013577-32081-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the VA range patches presented as a coherent set. The bounce page
and 'HYP init code too big' error are probably not prerequisites anymore now
that I switched from merging the HYP runtime map with the HYP id map rather
than the kernel ID map, but I would strongly prefer to keep it as a single
series. (There is an unlikely scenario where the kernel Image could be inside
VA_BITS but the bounce page outside VA_BITS, but this is currently broken
anyway.)

Changes since previous version:
- move ARM HYP idmap to a separate output section __hyp_idmap_rodata instead
  of .rodata to address Russell's concern that the linker may handle this poorly
- fix the linker script ASSERTs on the HYP page size and alignment: both would
  incorrectly reject a 0 size HYP idmap (i.e., when !CONFIG_KVM) if the start
  and end symbols were both aligned to a page
- update the VA range patches to use the new adr_l/ldr_l/str_l macros that are
  introduced in the arm64/head.S cleanup series

Ard Biesheuvel (3):
  arm64: mm: increase VA range of identity map
  ARM, arm64: kvm: get rid of the bounce page
  arm64: KVM: use ID map with increased VA range if required

Arnd Bergmann (1):
  ARM: KVM: avoid "HYP init code too big" error

 arch/arm/include/asm/kvm_mmu.h         | 10 +++++
 arch/arm/kernel/vmlinux.lds.S          | 34 ++++++++++++++---
 arch/arm/kvm/init.S                    |  3 ++
 arch/arm/kvm/mmu.c                     | 69 +++++++++++++++-------------------
 arch/arm64/include/asm/kvm_mmu.h       | 33 ++++++++++++++++
 arch/arm64/include/asm/mmu_context.h   | 43 +++++++++++++++++++++
 arch/arm64/include/asm/page.h          |  6 ++-
 arch/arm64/include/asm/pgtable-hwdef.h |  7 +++-
 arch/arm64/kernel/head.S               | 37 ++++++++++++++++++
 arch/arm64/kernel/smp.c                |  1 +
 arch/arm64/kernel/vmlinux.lds.S        | 17 ++++++---
 arch/arm64/kvm/hyp-init.S              | 25 ++++++++++++
 arch/arm64/mm/mmu.c                    |  7 +++-
 arch/arm64/mm/proc-macros.S            | 10 +++++
 arch/arm64/mm/proc.S                   |  3 ++
 15 files changed, 251 insertions(+), 54 deletions(-)

-- 
1.8.3.2
