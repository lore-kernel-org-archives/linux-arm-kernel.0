From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 12:11:33 +0100
Subject: [PATCH v3 0/7] ARM: KVM: various mmu related fixes for 3.10
Message-ID: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a number of of KVM/ARM issues that have either
been spotted during the review of the arm64 code, or while reworking
related code.

Only the first patch fixes a potential (if unlikely) problem, the
others are either cosmetic or performance related.

Tested on TC-2, based on 3.10-rc1.

* From v2:
  - [1/7] Drop the unnecessary "TLB invalidate all", as we already do
  it on a page-per-page level.
  - [3/7] Add a cache cleaning primitive, move the cleaning outside of
  kvm_set_pte(), and clean a range as large as possible when inserting
  PTEs.
  - [4,5,7/7] New patches

Marc Zyngier (7):
  ARM: KVM: be more thorough when invalidating TLBs
  ARM: KVM: remove dead prototype for __kvm_tlb_flush_vmid
  ARM: KVM: relax cache maintainance when building page tables
  ARM: KVM: use phys_addr_t instead of unsigned long long for HYP PGDs
  ARM: KVM: don't special case PC when doing an MMIO
  ARM: KVM: get rid of S2_PGD_SIZE
  ARM: KVM: drop use of PAGE_S2_DEVICE

 arch/arm/include/asm/kvm_arm.h     |  1 -
 arch/arm/include/asm/kvm_asm.h     |  2 --
 arch/arm/include/asm/kvm_emulate.h |  5 ----
 arch/arm/include/asm/kvm_host.h    |  4 +--
 arch/arm/include/asm/kvm_mmu.h     | 17 +++++++-----
 arch/arm/include/asm/pgtable.h     |  2 --
 arch/arm/kvm/arm.c                 |  8 +++---
 arch/arm/kvm/mmio.c                |  6 -----
 arch/arm/kvm/mmu.c                 | 53 ++++++++++++++++++++++----------------
 arch/arm/mm/mmu.c                  |  6 ++---
 10 files changed, 50 insertions(+), 54 deletions(-)

-- 
1.8.2.3
