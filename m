From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 30 Aug 2016 15:49:40 +0900
Subject: [PATCH v25] 0/9] Subject: arm64: add kdump support
Message-ID: <20160830064941.19452-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds kdump support on arm64.
There are some prerequisite patches [1],[2].

To load a crash-dump kernel to the systems, a series of patches to
kexec-tools, which have not yet been merged upstream, are needed.
Please use my kdump patches [3].

To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
  - crash utility (coming v7.1.6 or later) [4]
    (Necessary patches have already been queued in the master.)


[1] "arm64: mark reserved memblock regions explicitly in iomem"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
[2] "efi: arm64: treat regions with WT/WC set but WB cleared as memory"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451491.html
[3] T.B.D.
[4] https://github.com/crash-utility/crash.git


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

See the following link [5] for older changes:
[5]  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html

AKASHI Takahiro (8):
  arm64: kdump: reserve memory for crash dump kernel
  memblock: add memblock_cap_memory_range()
  arm64: limit memory regions based on DT property, usable-memory-range
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: add kdump support
  arm64: kdump: add VMCOREINFO's for user-space coredump tools
  arm64: kdump: enable kdump in the arm64 defconfig
  arm64: kdump: update a kernel doc

James Morse (1):
  Documentation: dt: chosen properties for arm64 kdump

 Documentation/devicetree/bindings/chosen.txt |  45 ++++++
 Documentation/kdump/kdump.txt                |  16 ++-
 arch/arm64/Kconfig                           |  11 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/hardirq.h             |   2 +-
 arch/arm64/include/asm/kexec.h               |  41 +++++-
 arch/arm64/include/asm/smp.h                 |   2 +
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/crash_dump.c               |  71 ++++++++++
 arch/arm64/kernel/machine_kexec.c            |  67 ++++++++-
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  63 +++++++++
 arch/arm64/mm/init.c                         | 202 +++++++++++++++++++++++++++
 include/linux/memblock.h                     |   1 +
 mm/memblock.c                                |  28 ++++
 15 files changed, 551 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
2.9.0


AKASHI Takahiro (8):
  arm64: kdump: reserve memory for crash dump kernel
  memblock: add memblock_cap_memory_range()
  arm64: limit memory regions based on DT property, usable-memory-range
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: add kdump support
  arm64: kdump: add VMCOREINFO's for user-space coredump tools
  arm64: kdump: enable kdump in the arm64 defconfig
  arm64: kdump: update a kernel doc

James Morse (1):
  Documentation: dt: chosen properties for arm64 kdump

 Documentation/devicetree/bindings/chosen.txt |  50 +++++++
 Documentation/kdump/kdump.txt                |  16 ++-
 arch/arm64/Kconfig                           |  11 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/hardirq.h             |   2 +-
 arch/arm64/include/asm/kexec.h               |  41 +++++-
 arch/arm64/include/asm/smp.h                 |   2 +
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/crash_dump.c               |  71 ++++++++++
 arch/arm64/kernel/machine_kexec.c            |  67 ++++++++-
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  63 +++++++++
 arch/arm64/mm/init.c                         | 202 +++++++++++++++++++++++++++
 include/linux/memblock.h                     |   1 +
 mm/memblock.c                                |  28 ++++
 15 files changed, 556 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
2.9.0
