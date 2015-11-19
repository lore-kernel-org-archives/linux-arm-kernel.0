From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Nov 2015 19:00:33 +0000
Subject: [GIT PULL] arm64 fixes for 4.4
Message-ID: <20151119190030.GA9694@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 92e788b749862ebe9920360513a718e5dd4da7a9:

  arm64: restore bogomips information in /proc/cpuinfo (2015-11-19 17:57:18 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix size alignment in __iommu_{alloc,free}_attrs
- Kernel memory mapping fix with CONFIG_DEBUG_RODATA for page sizes
  other than 4KB and a fix of the mark_rodata_ro permissions
- dma_get_ops() simplification and behaviour alignment between DT and
  ACPI
- function_graph trace fix for cpu_suspend() (CPUs returning from deep
  sleep via a different path and confusing the tracer)
- Use of non-global mappings for UEFI run-time services to avoid a
  (potentially theoretical) TLB conflict
- Crypto priority reduction of core AES cipher (the accelerated
  asynchronous implementation is preferred when available)
- Reverting an old commit that removed BogoMIPS from /proc/cpuinfo on
  arm64. Apparently, we had it for a relatively short time and libvirt
  started checking for its presence
- Compiler warnings fixed (ptrace.h inclusion from compat.h,
  smp_load_acquire with const argument)

----------------------------------------------------------------
Ard Biesheuvel (3):
      arm64: mm: use correct mapping granularity under DEBUG_RODATA
      arm64: use non-global mappings for UEFI runtime regions
      arm64: crypto: reduce priority of core AES cipher

Arnd Bergmann (2):
      arm64: simplify dma_get_ops
      arm64: do not include ptrace.h from compat.h

Laura Abbott (1):
      arm64: Fix R/O permissions in mark_rodata_ro

Lorenzo Pieralisi (1):
      arm64: kernel: pause/unpause function graph tracer in cpu_suspend()

Robin Murphy (1):
      arm64/dma-mapping: Fix sizes in __iommu_{alloc,free}_attrs

Will Deacon (1):
      arm64: barriers: fix smp_load_acquire to work with const arguments

Yang Shi (1):
      arm64: restore bogomips information in /proc/cpuinfo

 arch/arm64/crypto/aes-ce-cipher.c    |  2 +-
 arch/arm64/include/asm/barrier.h     | 16 ++++++++++------
 arch/arm64/include/asm/compat.h      |  3 +--
 arch/arm64/include/asm/dma-mapping.h | 13 +++----------
 arch/arm64/include/asm/mmu_context.h |  2 +-
 arch/arm64/include/asm/pgtable.h     |  1 +
 arch/arm64/kernel/cpuinfo.c          |  5 +++++
 arch/arm64/kernel/efi.c              | 14 +++++---------
 arch/arm64/kernel/suspend.c          | 10 ++++++++++
 arch/arm64/mm/dma-mapping.c          | 35 +++++++++++++++++------------------
 arch/arm64/mm/mmu.c                  | 14 +++++++-------
 11 files changed, 61 insertions(+), 54 deletions(-)

-- 
Catalin
