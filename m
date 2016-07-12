From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Jul 2016 14:05:06 +0900
Subject: [PATCH v22 0/8] arm64: add kdump support
Message-ID: <20160712050514.22307-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds kdump support on arm64.

To load a crash-dump kernel to the systems, a series of patches to
kexec-tools [1], which have not yet been merged upstream, are needed.
Please update to the latest if you have been using an older version.

To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
  - crash utility (coming v7.1.6 or later) [2]
    (Necessary patches have already been queued in the master.)

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
     (Please rename "linux,usable-memory" to "linux,usable-memory-range"
      in kexec/arch/arm64/kexec-arm64.c)
[2]  https://github.com/crash-utility/crash.git

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

See the following link [3] for older changes:
[3]  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html

AKASHI Takahiro (7):
  arm64: kdump: reserve memory for crash dump kernel
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
 arch/arm64/kernel/crash_dump.c               |  71 +++++++++
 arch/arm64/kernel/machine_kexec.c            |  67 ++++++++-
 arch/arm64/kernel/setup.c                    |   7 +-
 arch/arm64/kernel/smp.c                      |  64 +++++++++
 arch/arm64/mm/init.c                         | 207 +++++++++++++++++++++++++++
 13 files changed, 528 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
2.9.0
