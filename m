From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 09 Oct 2014 19:34:04 -0700
Subject: [PATCH 0/3] arm/arm64: Add dirty page logging for ARMv8
Message-ID: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for ARMv8 dirty page logging. It applies on top
of ARMv7 patch series. Similar ARMv8 to dirty page log read is moved to generic
layer and tlb flush has architecture specific flush.

Testing:
--------
- ARMv8 - Tested on Foundation Model.
- ARMv7 - retested on Exynos 5440 development board.

Components:
- Added mmio device to QEMU 'machvirt' with on board memory (1MB in this case),
  Device memory is Posix shared memory segment visible to host. Enabled 
  dirty logging for that memslot.
- Added memslot migration thread to export dirty bit map to host.
- Implemented memory migration thread on host.

Operation:
  o On Guest application mmaps() the region (via /dev/mem) and dirties pages.
  o The host migration thread does a pre-copy of /dev/shm/aeshmem to a host
    file, repeatedly requests QEMU for memory region dirty page log, 
    incrementally copies dirty pages from /dev/shm/aeshmem to host file.
  o Guest application is stopped and both /dev/shm/aeshmem and host file are
    checksummed to check for match to validate dirty page log applied 
    incremental updates, validating logging.

Will upload details to https://github.com/mjsmar/arm-migration-howto 
- qemu binary, host mgiration thread, and other deliverables to reproduce
  test environment.

Mario Smarduch (3):
  ARMv8 headers changes for dirty page logging
  Add HYP interface to flush State 1/2 TLB entires
  Enable Dirty Page logging for ARMv8 move log read, tlb flush to
    generic code

 arch/arm/include/asm/kvm_host.h        | 12 ------------
 arch/arm/kvm/arm.c                     |  9 ---------
 arch/arm/kvm/mmu.c                     | 17 +++++++++++------
 arch/arm64/include/asm/kvm_asm.h       |  1 +
 arch/arm64/include/asm/kvm_host.h      |  1 +
 arch/arm64/include/asm/kvm_mmu.h       | 20 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/kvm/Kconfig                 |  2 +-
 arch/arm64/kvm/hyp.S                   | 22 ++++++++++++++++++++++
 9 files changed, 57 insertions(+), 28 deletions(-)

-- 
1.9.1
