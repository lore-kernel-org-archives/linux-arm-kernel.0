From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Jun 2014 18:31:36 -0700
Subject: [PATCH v8 0/4] arm: dirty page logging support for ARMv7
Message-ID: <1403141500-31010-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for dirty page logging so far tested only on ARMv7,
and verified to compile on ARMv8. With dirty page logging, GICv2 vGIC and arch 
timer save/restore support, live migration is supported.

Dirty page logging support -
- initially write protects VM RAM memory regions - 2nd stage page tables
- add support to read dirty page log and again write protect the dirty pages 
  - second stage page table for next pass.
- second stage huge page are dissolved into page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits
  migration to an almost idle system.
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.
- At this time reverse mappings are not used to for write protecting of 2nd 
  stage tables.

- Future work
  - Enable diry memory logging to work on ARMv8 FastModels.

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

- Basic Network Test - Assuming one ethernet interface available

Source host IP 192.168.10.101/24, VM tap0 192.168.2.1/24 and
VM eth0 192.168.2.100/24 with default route 192.168.2.1

Destination host IP 192.168.10.100/24, VM same settings as above.
Both VMs have identical MAC addresses.

Initially NFS server route to 192.168.2.100 is via 192.168.10.101

- ssh 192.168.2.100
- start migration from source to destination
- after migration ends
- on NFS server switch routes.
   route add -host 192.168.2.100 gw 192.168.10.100

ssh should resume after route switch. ping as well should work
seamlessly.

Changes since v7:
- Reworked write protection of dirty page mask
- Moved generic code back to architecture layer, keep it there for time being,
  until a KVM framework for architecture functions to override genric 
  ones is defined.
- Fixed conditon bug for marking pages dirty
  

Mario Smarduch (4):
  add ARMv7 HYP API to flush VM TLBs without address param
  dirty page logging inital mem region write protect (w/no huge PUD
    support)
  dirty log write protect management support
  dirty page logging 2nd stage page fault handling support

 arch/arm/include/asm/kvm_asm.h        |    1 +
 arch/arm/include/asm/kvm_host.h       |    6 +
 arch/arm/include/asm/kvm_mmu.h        |   20 ++++
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/kvm/arm.c                    |   92 +++++++++++++++
 arch/arm/kvm/interrupts.S             |   11 ++
 arch/arm/kvm/mmu.c                    |  197 ++++++++++++++++++++++++++++++++-
 7 files changed, 322 insertions(+), 6 deletions(-)

-- 
1.7.9.5
