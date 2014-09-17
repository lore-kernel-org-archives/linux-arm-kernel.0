From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Sep 2014 14:56:15 -0700
Subject: [PATCH 0/6] KVM: handling of MMIO pass-through regions
Message-ID: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the patches 'kvm: define PAGE_S2_DEVICE as
read-only by default' I sent out last week. Essentially build tested
only: while QEMU on KVM still works correctly for my use case with
these patches applied, it does not in fact use passthrough mappings
of device memory.

Patch #1 is a trivial fix for an issue identified by sparse where we
are calling memset(0) on 2 MB worth of pages.

Patch #2 fixes a potential NULL dereference in user_mem_abort()

Patch #3 adds a 'writable' parameter to kmv_phys_addr_ioremap() so that
read-only device regions can be mapped using this function. The existing
callers are updated to pass 'true' for this parameter.

Patch #4 and #5 were sent out before, and change the value of
PAGE_S2_DEVICE to read-only, so that read-only regions can be
ioremap()'ed

Patch #6 ensures that VM_PFNMAP linear mappings of non-system RAM host
memory are mapped eagerly rather than faulted in page by page.


Ard Biesheuvel (6):
  arm/arm64: KVM: use __GFP_ZERO not memset() to get zeroed pages
  arm/arm64: KVM: fix potential NULL dereference in user_mem_abort()
  arm/arm64: KVM: add 'writable' parameter to kvm_phys_addr_ioremap
  ARM: kvm: define PAGE_S2_DEVICE as read-only by default
  arm64: kvm: define PAGE_S2_DEVICE as read-only by default
  arm/arm64: KVM: map MMIO regions at creation time

 arch/arm/include/asm/pgtable.h   |  2 +-
 arch/arm/kvm/mmu.c               | 64 ++++++++++++++++++++++++++++++++++++----
 arch/arm64/include/asm/kvm_mmu.h |  2 +-
 arch/arm64/include/asm/pgtable.h |  2 +-
 virt/kvm/arm/vgic.c              |  3 +-
 5 files changed, 64 insertions(+), 9 deletions(-)

-- 
1.8.3.2
