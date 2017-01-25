From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Jan 2017 15:36:28 +0000
Subject: [PATCH 0/3] Fix cache flushing when mapping at stage-2
Message-ID: <1485358591-12278-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we fault in a page, we flush it to the PoC (Point of Coherency)
if the faulting vcpu has its own caches off, so that it can observe
the page we just brought it.
    
But if the vcpu has its caches on, we skip that step. Bad things
happen when *another* vcpu tries to access that page with its own
caches disabled. At that point, there is no garantee that the data has
made it to the PoC, and we access stale data.
    
The obvious fix is to always flush to PoC when a page is faulted in,
no matter what the state of the vcpu is.

This leads to additional cleanups, removing the code that was forcing
read-only memslots to be flushed to PoC as well (since the flushing is
now unconditional). Only the first patch is critical, and deserves a
Cc to stable.

Marc Zyngier (3):
  arm/arm64: KVM: Enforce unconditional flush to PoC when mapping to
    stage-2
  arm/arm64: KVM: Stop propagating cacheability status of a faulted page
  arm/arm64: KVM: Get rid of KVM_MEMSLOT_INCOHERENT

 arch/arm/include/asm/kvm_mmu.h   | 12 ++----------
 arch/arm/kvm/mmu.c               | 20 ++++----------------
 arch/arm64/include/asm/kvm_mmu.h |  6 ++----
 include/linux/kvm_host.h         |  1 -
 4 files changed, 8 insertions(+), 31 deletions(-)

-- 
2.1.4
