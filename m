From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 03 Jun 2014 16:19:23 -0700
Subject: [PATCH v7 0/4] arm: dirty page logging support for ARMv7
Message-ID: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for dirty page logging so far tested only on ARMv7.
With dirty page logging, GICv2 vGIC and arch timer save/restore support, live 
migration is supported. 

Dirty page logging support -
- initially write protects VM RAM memory regions - 2nd stage page tables
- add support to read dirty page log and again write protect the dirty pages 
  - second stage page table for next pass.
- second stage huge page are disolved into page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits 
  migration to an almost idle system. There are couple approaches to handling
  huge pages:
  1 - break up huge page into page table and write protect all pte's
  2 - clear the PMD entry, create a page table install the faulted page entry
      and write protect it.

  This patch implements #2, in the future #1 may be implemented depending on
  more bench mark results.

  Option 1: may over commit and do unnecessary work, but on heavy loads appears
            to converge faster during live migration
  Option 2: Only write protects pages that are accessed, migration
	    varies, takes longer then Option 1 but eventually catches up.

- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.
- Another alternative is use of reverse mappings where for each level 2nd
  stage tables (PTE, PMD, PUD) pointers to spte's are maintained (x86 impl.).
  Primary reverse mapping benefits are for mmu notifiers for large memory range
  invalidations. Reverse mappings also improve dirty page logging, instead of
  walking page tables, spete pointers are accessed directly via reverse map
  array.
- Reverse mappings will be considered for future support once the current
  implementation is hardened.
  o validate current dirty page logging support
  o VMID TLB Flushing, migrating multiple guests
  o GIC/arch-timer migration
  o migration under various loads, primarily page reclaim and validate current
    mmu-notifiers
  o Run benchmarks (lmbench for now) and test impact on performance, and
    optimize
  o Test virtio - since it writes into guest memory. Wait until pci is supported
    on ARM.
  o Currently on ARM, KVM doesn't appear to write into Guest address space,
    need to mark those pages dirty too (???).
- Move onto ARMv8 since 2nd stage mmu is shared between both architectures. 
  But in addition to dirty page log additional support for GIC, arch timers, 
  and emulated devices is required. Also working on emulated platform masks
  a lot of potential bugs, but does help to get majority of code working.

Test Environment:
---------------------------------------------------------------------------
NOTE: RUNNING on FAST Models will hardly ever fail and mask bugs, infact 
      initially light loads were succeeding without dirty page logging support.
---------------------------------------------------------------------------
- Will put all components on github, including test setup diagram
- In short summary
  o Two ARM Exyonys 5440 development platforms - 4-way 1.7 GHz, with 8GB, 256GB
    storage, 1GBs Ethernet, with swap enabled
  o NFS Server runing Ubuntu 13.04 
    - both ARM boards mount shared file system 
    - Shared file system includes - QEMU, Guest Kernel, DTB, multiple Ext3 root
      file systems.
  o Component versions: qemu-1.7.5, vexpress-a15, host/guest kernel 3.15-rc1,
  o Use QEMU Ctr+A+C and migrate -d tcp:IP:port command
    - Destination command syntax: can change smp to 4, machine model outdated,
      but has been tested on virt by others (need to upgrade)
	
	/mnt/migration/qemu-system-arm -enable-kvm -smp 2 -kernel \
	/mnt/migration/zImage -dtb /mnt/migration/guest-a15.dtb -m 1792 \
	-M vexpress-a15 -cpu cortex-a15 -nographic \
	-append "root=/dev/vda rw console=ttyAMA0 rootwait" \
	-drive if=none,file=/mnt/migration/guest1.root,id=vm1 \
	-device virtio-blk-device,drive=vm1 \
	-netdev type=tap,id=net0,ifname=tap0 \
	-device virtio-net-device,netdev=net0,mac="52:54:00:12:34:58" \
	-incoming tcp:0:4321

    - Source command syntax same except '-incoming'

  o Test migration of multiple VMs use tap0, tap1, ..., and guest0.root, .....
    has been tested as well.
  o On source run multiple copies of 'dirtyram.arm' - simple program to dirty
    pages periodically.
    ./dirtyarm.ram <total mmap size> <dirty page size> <sleep time>
    Example:
    ./dirtyram.arm 102580 812 30
    - dirty 102580 pages
    - 812 pages every 30ms with an incrementing counter 
    - run anywhere from one to as many copies as VM resources can support. If 
      the dirty rate is too high migration will run indefintely
    - run date output loop, check date is picked up smoothly
    - place guest/host into page reclaim/swap mode - by whatever means in this
      case run multiple copies of 'dirtyram.ram' on host
    - issue migrate command(s) on source
    - Top result is 409600, 8192, 5
  o QEMU is instrumented to save RAM memory regions on source and destination
    after memory is migrated, but before guest started. Later files are 
    checksummed on both ends for correctness, given VMs are small this works. 
  o Guest kernel is instrumented to capture current cycle counter - last cycle
    and compare to qemu down time to test arch timer accuracy. 
  o Network failover is at L3 due to interface limitations, ping continues
    working transparently
  o Also tested 'migrate_cancel' to test reassemble of huge pages (inserted low
    level instrumentation code).

Changes since v6:
- primarily reworked initial write protect, and write protect of dirty pages on
  logging request
- Only code logic change, disolve huge pages to page tables in page fault 
  handler
- Made many many changes based on Christoffers comments.

Mario Smarduch (4):
  add ARMv7 HYP API to flush VM TLBs without address param
  dirty page logging inital mem region write protect (w/no huge PUD
    support)
  dirty log write protect management sppport
  dirt page logging 2nd stage page fault handling support

 arch/arm/include/asm/kvm_asm.h        |    1 +
 arch/arm/include/asm/kvm_host.h       |    5 +
 arch/arm/include/asm/kvm_mmu.h        |   20 +++
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/kvm/arm.c                    |   11 +-
 arch/arm/kvm/interrupts.S             |   11 ++
 arch/arm/kvm/mmu.c                    |  243 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                    |   86 ------------
 virt/kvm/kvm_main.c                   |   83 ++++++++++-
 9 files changed, 367 insertions(+), 94 deletions(-)

-- 
1.7.9.5
