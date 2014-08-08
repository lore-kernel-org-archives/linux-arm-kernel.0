From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 08 Aug 2014 10:50:50 -0700
Subject: [PATCH v9 1/4] arm: add ARMv7 HYP API to flush VM TLBs ... -
 looking for comments
In-Reply-To: <53D295DE.2090901@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-2-git-send-email-m.smarduch@samsung.com>
 <53D1F537.2070306@suse.de> <53D295DE.2090901@samsung.com>
Message-ID: <53E50DFA.4090803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
  I'm circling back on this patch series for review comments. Primarily
patches 1 and 3 (numbered below). 

To summarize this patch series adds dirty page logging for ARMv7, the dirty 
page log read function has been moved to generic layer common between 
x86, armv7, as result the function has generic and  architecture variants.

This led to split of kvm tlb flushing, patch 1 adds architecture variant
for ARM to support its hardware broadcast TLB invalidation. 

In both cases same approach is used - changes to arch kvm Kconfigs and
generic kvm Kconfig.

Would appreciate some feedback yes/no/maybe if?, I'm currently working on 
arm64, and review of this version will impact next.

1- https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010557.html
2- https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010559.html
3- https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010558.html
4- https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010560.html

- Mario

>This patch adds support for dirty page logging so far tested only on ARMv7 HW,
>and verified to compile on armv8, ia64, mips, ppc, s390 and compile and run on
>x86_64. 
>
>Change from previous version:
>- kvm_flush_remote_tlbs() has generic and architecture specific variants.
>  armv7 (later armv8) uses arch variant all other archtectures use generic 
>  version. Reason being arm uses HW broadcast for TLB invalidation.
>- kvm_vm_ioctl_get_dirty_log() - is generic between armv7, x86 (later ARMv8),
>  other architectures use arch variant
>
>The approach is documented 
>
>https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010329.html
>https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010338.html
>
>Compile targets
>- x86_64 - defconfig also did validation, simple migration on same host.
>- ia64 - ia64-linux-gcc4.6.3 - defconfig, ia64 Kconfig defines BROKEN worked 
>  around that to make sure new changes don't break build. Eventually build 
>  breaks when comping ioapic.c, unrelated to this patch.
>- mips - mips64-linux-gcc4.6.3 - malta_kvm_defconfig
>- ppc - powerpc64-linux-gcc4.6.3 - pseries_defconfig
>- s390 - s390x-linux-gcc4.6.3 - defconfig
>
>Dirty page logging support -
>- initially write protects VM RAM memory regions - 2nd stage page tables
>- add support to read dirty page log and again write protect the dirty pages 
>  - second stage page table for next pass.
>- second stage huge page are dissolved into page tables to keep track of
>  dirty pages at page granularity. Tracking at huge page granularity limits
>  migration to an almost idle system.
>- In the event migration is canceled, normal behavior is resumed huge pages
>  are rebuilt over time.
>- At this time reverse mappings are not used to for write protecting of 2nd 
>  stage tables.
>
>- Future work
>  - Enable diry memory logging to work on ARMv8 FastModels/Foundations Model
>
>Test Environment:
>---------------------------------------------------------------------------
>NOTE: RUNNING on FAST Models will hardly ever fail and mask bugs, initially 
>      light loads were succeeding without dirty page logging support.
>---------------------------------------------------------------------------
>- Will put all components on github, including test setup on github
>- In short summary
>  o Two ARM Exyonys 5440 development platforms - 4-way 1.7 GHz, with 8GB, 256GB
>    storage, 1GBs Ethernet, with swap enabled
>  o NFS Server runing Ubuntu 13.04
>    - both ARM boards mount shared file system
>    - Shared file system includes - QEMU, Guest Kernel, DTB, multiple Ext3 root
>      file systems.
>  o Component versions: qemu-1.7.5, vexpress-a15, host/guest kernel 3.15-rc1,
>  o Use QEMU Ctr+A+C and migrate -d tcp:IP:port command
>    - Destination command syntax: can change smp to 4, machine model outdated,
>      but has been tested on virt by others (need to upgrade)
>
>        /mnt/migration/qemu-system-arm -enable-kvm -smp 2 -kernel \
>        /mnt/migration/zImage -dtb /mnt/migration/guest-a15.dtb -m 1792 \
>        -M vexpress-a15 -cpu cortex-a15 -nographic \
>        -append "root=/dev/vda rw console=ttyAMA0 rootwait" \
>        -drive if=none,file=/mnt/migration/guest1.root,id=vm1 \
>        -device virtio-blk-device,drive=vm1 \
>        -netdev type=tap,id=net0,ifname=tap0 \
>        -device virtio-net-device,netdev=net0,mac="52:54:00:12:34:58" \
>        -incoming tcp:0:4321
>
>    - Source command syntax same except '-incoming'
>
>  o Test migration of multiple VMs use tap0, tap1, ..., and guest0.root, .....
>    has been tested as well.
>  o On source run multiple copies of 'dirtyram.arm' - simple program to dirty
>    pages periodically.
>    ./dirtyarm.ram <total mmap size> <dirty page size> <sleep time>
>    Example:
>    ./dirtyram.arm 102580 812 30
>    - dirty 102580 pages
>    - 812 pages every 30ms with an incrementing counter
>    - run anywhere from one to as many copies as VM resources can support. If
>      the dirty rate is too high migration will run indefintely
>    - run date output loop, check date is picked up smoothly
>    - place guest/host into page reclaim/swap mode - by whatever means in this
>      case run multiple copies of 'dirtyram.ram' on host
>    - issue migrate command(s) on source
>    - Top result is 409600, 8192, 5
>  o QEMU is instrumented to save RAM memory regions on source and destination
>    after memory is migrated, but before guest started. Later files are
>    checksummed on both ends for correctness, given VMs are small this works.
>  o Guest kernel is instrumented to capture current cycle counter - last cycle
>    and compare to qemu down time to test arch timer accuracy.
>  o Network failover is at L3 due to interface limitations, ping continues
>    working transparently
>  o Also tested 'migrate_cancel' to test reassemble of huge pages (inserted low
>    level instrumentation code).
>- Basic Network Test - Assuming one ethernet interface available
>
>Source host IP 192.168.10.101/24, VM tap0 192.168.2.1/24 and
>VM eth0 192.168.2.100/24 with default route 192.168.2.1
>
>Destination host IP 192.168.10.100/24, VM same settings as above.
>Both VMs have identical MAC addresses.
>
>Initially NFS server route to 192.168.2.100 is via 192.168.10.101
>
>- ssh 192.168.2.100
>- start migration from source to destination
>- after migration ends
>- on NFS server switch routes.
>   route add -host 192.168.2.100 gw 192.168.10.100
>
>ssh should resume after route switch. ping as well should work
>seamlessly.
>
>
>
>Mario Smarduch (4):
>  add ARMv7 HYP API to flush VM TLBs, change generic TLB flush to
>    support arch flush
>  ARMv7  dirty page logging inital mem region write protect (w/no huge
>    PUD support)
>  dirty log write protect mgmt. Moved x86, armv7 to generic, set armv8
>    ia64 mips powerpc s390 arch specific
>  ARMv7 dirty page logging 2nd stage page fault handling support
>
> arch/arm/include/asm/kvm_asm.h        |    1 +
> arch/arm/include/asm/kvm_host.h       |    2 +
> arch/arm/include/asm/kvm_mmu.h        |   20 ++++
> arch/arm/include/asm/pgtable-3level.h |    1 +
> arch/arm/kvm/Kconfig                  |    1 +
> arch/arm/kvm/arm.c                    |   17 ++-
> arch/arm/kvm/interrupts.S             |   12 ++
> arch/arm/kvm/mmu.c                    |  198 ++++++++++++++++++++++++++++++++-
> arch/arm64/include/asm/kvm_host.h     |    2 +
> arch/arm64/kvm/Kconfig                |    1 +
> arch/ia64/include/asm/kvm_host.h      |    1 +
> arch/ia64/kvm/Kconfig                 |    1 +
> arch/ia64/kvm/kvm-ia64.c              |    2 +-
> arch/mips/include/asm/kvm_host.h      |    2 +-
> arch/mips/kvm/Kconfig                 |    1 +
> arch/mips/kvm/kvm_mips.c              |    2 +-
> arch/powerpc/include/asm/kvm_host.h   |    2 +
> arch/powerpc/kvm/Kconfig              |    1 +
> arch/powerpc/kvm/book3s.c             |    2 +-
> arch/powerpc/kvm/booke.c              |    2 +-
> arch/s390/include/asm/kvm_host.h      |    2 +
> arch/s390/kvm/Kconfig                 |    1 +
> arch/s390/kvm/kvm-s390.c              |    2 +-
> arch/x86/kvm/x86.c                    |   86 --------------
> include/linux/kvm_host.h              |    3 +
> virt/kvm/Kconfig                      |    6 +
> virt/kvm/kvm_main.c                   |   94 ++++++++++++++++
> 27 files changed, 366 insertions(+), 99 deletions(-)
>
>-- 
>1.7.9.5
