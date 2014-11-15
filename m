From: m.smarduch@samsung.com (m.smarduch at samsung.com)
Date: Sat, 15 Nov 2014 00:19:07 -0800
Subject: [PATCH v2 0/3] arm/arm64: Add dirty page logging for ARMv8
 (3.17.0-rc1)
Message-ID: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

This patch series adds support for ARMv8 dirty page logging. It applies on top
of ARMv7 patch series. This feature hooks into generic dirty page logging,
and reuses earlier ARMv7 architecture support added with few ARMv8 additions.

Testing:
--------
- ARMv8 - Tested on Foundation Model.
- ARMv7 - retested on Exynos 5440 development board.

Test Description:
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

See https://github.com/mjsmar/arm-dirtylog-tests 'v8' subfolder

ARMv7/v8 Dirty page logging implementation overivew-
- initially write protects memory region pages 2nd stage page tables
- add support to read dirty page log and again write protect dirty pages 
  for next pass.
- second stage huge page are dissolved into small page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits
  migration to an almost idle system. Small page size logging supports higher
  memory dirty rates.
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.

Changes Since (v1):
- Rebased to ARMv7 version
- Addressed Christoffers review comments.

Mario Smarduch (3):
  KVM: arm64: ARMv8 header changes for page logging
  KVM: arm64: Add HYP interface to flush VM Stage 1/2nd TLB entires
  KVM: arm/arm64: Enable Dirty Page logging for ARMv8

 arch/arm/include/asm/kvm_host.h        | 12 ------------
 arch/arm/kvm/arm.c                     |  4 ----
 arch/arm/kvm/mmu.c                     | 20 +++++++++++---------
 arch/arm64/include/asm/kvm_asm.h       |  1 +
 arch/arm64/include/asm/kvm_host.h      |  1 +
 arch/arm64/include/asm/kvm_mmu.h       | 20 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/kvm/Kconfig                 |  2 ++
 arch/arm64/kvm/hyp.S                   | 22 ++++++++++++++++++++++
 9 files changed, 58 insertions(+), 25 deletions(-)

-- 
1.9.1
