From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 28 Apr 2014 17:54:41 -0700
Subject: [PATCH v4 0/5] live migration dirty bitmap support for ARMv7
Message-ID: <535EF851.9080009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
 this the fourth iteration of live migration support for the time being
tested on ARMv7. The patches depend on Eric Augers patch for memory regions.

- Tested on two 4-way A15 systems, 2-way/4-way SMP guest upto 2GB memory
- Various dirty data rates tested - 2GB/1s ... 2048 pgs/5ms
- validated source/destination memory image integrity
- Issue: time skips few seconds on dest., timekeeper offset from last
  cycle appears to big, need to investigate further.

Changes since v3:
- changed pte updates to reset write bit instead of setting default 
  value for existing pte's - Steve's comment 
- In addition to PUD add 2nd stage >4GB range functions - Steves
  suggestion
- Restructured initial memory slot write protect function for PGD, PUD, PMD
  table walking - Steves suggestion
- Renamed variable types to resemble their use - Steves suggestions
- Added couple pte helpers for 2nd stage tables - Steves suggestion
- Updated unmap_range() that handles 2nd stage tables and identity mappings
  to handle 2nd stage addresses >4GB. Left ARMv8 unchanged.

Changes since v2:
- move initial VM write protect to memory region architecture prepare function
  (needed to make dirty logging function generic) 
- added stage2_mark_pte_ro() - to mark ptes ro - Marc's comment
- optimized initial VM memory region write protect to do fewer table lookups -
  applied Marc's comment for walking dirty bitmap mask
- added pud_addr_end() for stage2 tables, to make the walk 4-level
- added kvm_flush_remote_tlbs() to use ARM TLB invalidation, made the generic
  one weak, Marc's comment to for generic dirty bitmap log function
- optimized walking dirty bit map mask to skip upper tables - Marc's comment
- deleted x86,arm kvm_vm_ioctl_get_dirty_log(), moved to kvm_main.c tagged 
  the function weak - Marc's comment
- changed Data Abort handler pte index handling - Marc's comment


Mario Smarduch (5):
  add ARMv7 HYP API to flush VM TLBs without address param
  live migration support for initial write protect of VM
  live migration support for VM dirty log management
  add 2nd stage page fault handling during live migration
  change update_range to handle > 4GB 2nd stage range for ARMv7

 arch/arm/include/asm/kvm_asm.h  |    1 +
 arch/arm/include/asm/kvm_host.h |   13 ++
 arch/arm/include/asm/kvm_mmu.h  |   11 ++
 arch/arm/kvm/arm.c              |    8 +-
 arch/arm/kvm/interrupts.S       |    5 +
 arch/arm/kvm/mmu.c              |  377 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.c              |   78 --------
 virt/kvm/kvm_main.c             |   89 ++++++++-
 8 files changed, 488 insertions(+), 94 deletions(-)

-- 
1.7.9.5
