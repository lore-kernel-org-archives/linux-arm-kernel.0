From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 17:46:38 +0900
Subject: [PATCH v30 00/11] arm64: add kdump support
Message-ID: <20170124084638.3770-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds kdump support on arm64.

To load a crash-dump kernel to the systems, a series of patches to
kexec-tools[1] are also needed. Please use the latest one, v5 [2].
For your convinience, you can pick them up from:
   https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
   https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
  - crash utility (v7.1.8 or later, i.e. master for now) [3]

I tested this patchset on fast model and hikey.
The previous version, v29, was also:
Tested-by: Pratyush Anand <panand@redhat.com> (mustang and seattle)

Changes for v30 (Jan 24, 2017)
  o rebased to Linux-v4.10-rc5
  o remove "linux,crashkernel-base/size" from exported device tree
  o protect memory region for crash-dump kernel (adding patch#4,5)
  o remove "in_crash_kexec" variable
  o and other trivial changes

Changes for v29 (Dec 28, 2016)
  o rebased to Linux-v4.10-rc1
  o change asm constraints in crash_setup_regs() per Catalin

Changes for v28 (Nov 22, 2016)
  o rebased to Linux-v4.9-rc6
  o revamp patch #1 and merge memblock_cap_memory_range() with
    memblock_mem_limit_remove_map()

Changes for v27 (Nov 1, 2016)
  o rebased to Linux-v4.9-rc3
  o revert v26 change, i.e. revive "linux,usable-memory-range" property
    (patch #2/#3, updating patch #9)
  o minor fixes per review comments (patch #3/#4/#6/#8)
  o re-order patches and improve commit messages for readability

Changes for v26 (Sep 7, 2016):
  o Use /reserved-memory instead of "linux,usable-memory-range" property
    (dropping v25's patch#2 and #3, updating ex-patch#9.)

Changes for v25 (Aug 29, 2016):
  o Rebase to Linux-4.8-rc4
  o Use memremap() instead of ioremap_cache() [patch#5]

Changes for v24 (Aug 9, 2016):
  o Rebase to Linux-4.8-rc1
  o Update descriptions about newly added DT proerties

Changes for v23 (July 26, 2016):

  o Move memblock_reserve() to a single place in reserve_crashkernel()
  o Use  cpu_park_loop() in ipi_cpu_crash_stop()
  o Always enforce ARCH_LOW_ADDRESS_LIMIT to the memory range of crash kernel
  o Re-implement fdt_enforce_memory_region() to remove non-reserve regions
    (for ACPI) from usable memory at crash kernel

Changes for v22 (July 12, 2016):

  o Export "crashkernel-base" and "crashkernel-size" via device-tree,
    and add some descriptions about them in chosen.txt
  o Rename "usable-memory" to "usable-memory-range" to avoid inconsistency
    with powerpc's "usable-memory"
  o Make cosmetic changes regarding "ifdef" usage
  o Correct some wordings in kdump.txt

Changes for v21 (July 6, 2016):

  o Remove kexec patches.
  o Rebase to arm64's for-next/core (Linux-4.7-rc4 based).
  o Clarify the description about kvm in kdump.txt.

See the link [4] for older changes.


[1] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
[2] http://lists.infradead.org/pipermail/kexec/2017-January/018002.html
[3] https://github.com/crash-utility/crash.git
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html

AKASHI Takahiro (10):
  memblock: add memblock_cap_memory_range()
  arm64: limit memory regions based on DT property, usable-memory-range
  arm64: kdump: reserve memory for crash dump kernel
  arm64: mm: allow for unmapping memory region from kernel mapping
  arm64: kdump: protect crash dump kernel memory
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: add VMCOREINFO's for user-space tools
  arm64: kdump: provide /proc/vmcore file
  arm64: kdump: enable kdump in defconfig
  Documentation: kdump: describe arm64 port

James Morse (1):
  Documentation: dt: chosen properties for arm64 kdump

 Documentation/devicetree/bindings/chosen.txt |  37 +++++++
 Documentation/kdump/kdump.txt                |  16 ++-
 arch/arm64/Kconfig                           |  11 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/hardirq.h             |   2 +-
 arch/arm64/include/asm/kexec.h               |  42 +++++++-
 arch/arm64/include/asm/mmu.h                 |   2 +
 arch/arm64/include/asm/pgtable-hwdef.h       |   2 +
 arch/arm64/include/asm/pgtable-prot.h        |   1 +
 arch/arm64/include/asm/pgtable.h             |   4 +
 arch/arm64/include/asm/smp.h                 |   2 +
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/crash_dump.c               |  71 +++++++++++++
 arch/arm64/kernel/machine_kexec.c            | 132 ++++++++++++++++++-----
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  63 +++++++++++
 arch/arm64/mm/init.c                         | 150 +++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                          |  63 +++++++++--
 include/linux/memblock.h                     |   1 +
 mm/memblock.c                                |  44 +++++---
 20 files changed, 596 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
2.11.0
