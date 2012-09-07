From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Sep 2012 17:55:27 +0100
Subject: [PATCH v2 0/7] Allow the kernel to be booted in HYP mode
Message-ID: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allows the kernel (and the decompressor) to be
entered in HYP mode, which is a requirement for supporting hypervisors
such as KVM.

The main idea is to have a stub hypervisor to go back and forth
between HYP and SVC modes, and let the kernel install a full blown
hypervisor if necessary. Also, we ensure that a kernel without virt
support can still be entered in HYP mode and safely go back to SVC.

Most of the heavy lifting has been done by Dave Martin, but all bugs
have been introduced by me while reworking it. This series also relies
on Dave's earlier opcode injection series :
http://comments.gmane.org/gmane.linux.ports.arm.kernel/180901

It's been tested on a variety of platforms (VE A9/A15, Fast Model)
with all combinaisons of entering in HYP or SVC, ARM or Thumb2
kernels.

Patches against 3.6-rc4, and available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git hyp-mode-boot-next

* From v1:
  - Fix undefined behaviour when initializing HDCR

Dave Martin (5):
  ARM: virt: allow the kernel to be entered in HYP mode
  ARM: zImage/virt: hyp mode entry support for the zImage loader
  ARM: virt: Update documentation for hyp mode entry support
  ARM: virt: Add boot-time diagnostics
  ARM: virt: Add CONFIG_ARM_VIRT_EXT option

Marc Zyngier (2):
  ARM: opcodes: add __ERET/__MSR_ELR_HYP instruction encoding
  ARM: virt: arch_timers: enable access to physical timers

 Documentation/arm/Booting           |  22 +++-
 arch/arm/boot/compressed/.gitignore |   1 +
 arch/arm/boot/compressed/Makefile   |   9 +-
 arch/arm/boot/compressed/head.S     |  71 ++++++++++--
 arch/arm/include/asm/assembler.h    |  28 +++++
 arch/arm/include/asm/opcodes-virt.h |  10 ++
 arch/arm/include/asm/ptrace.h       |   1 +
 arch/arm/include/asm/virt.h         |  69 +++++++++++
 arch/arm/kernel/Makefile            |   2 +
 arch/arm/kernel/head.S              |  14 ++-
 arch/arm/kernel/hyp-stub.S          | 223 ++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c             |  20 ++++
 arch/arm/kernel/smp.c               |   3 +
 arch/arm/mm/Kconfig                 |  17 +++
 14 files changed, 478 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/include/asm/virt.h
 create mode 100644 arch/arm/kernel/hyp-stub.S

-- 
1.7.12
