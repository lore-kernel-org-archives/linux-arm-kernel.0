From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Mar 2015 20:35:27 +0000
Subject: [PATCH 0/6] arm64 kexec kernel patches V8
Message-ID: <cover.1426793116.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  This v8 of the
series is mainly just a rebase to Linux-4.0-rc3, and a few very minor changes
requested for v7.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

I have tested with the ARM VE fast model, the ARM Base model and the ARM
Foundation model with various kernel config options for both the first and
second stage kernels.  Kexec on EFI systems works correctly.  With the ACPI
kernel patches from [3] applied, kexec on ACPI systems seeems to work correctly.
More ACPI + kexec testing is needed.

Patch 1 here moves the macros from proc-macros.S to asm/assembler.h so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 2-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patches 5-6 add the actual kexec support.

Please consider all patches for inclusion.

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
[2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
[3]  http://git.linaro.org/leg/acpi/acpi.git #acpi-topic-juno-fvp

Several things are known to have problems on kexec re-boot:

spin-table
----------

PROBLEM: The spin-table enable method does not implement all the methods needed
for CPU hot-plug, so the first stage kernel cannot be shutdown properly.

WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
on the first stage kernel command line.

FIX: Upgrade system firmware to provide PSCI enable method support or add
missing spin-table support to the kernel.

KVM
---

PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
resources on shutdown, so the first stage kernel cannot be shutdown properly
when using kexec.

WORK-AROUND: Build the first stage kernel with CONFIG_KVM=n, or apply KVM bug
fix patches from [1].

FIX: Takahiro Akashi has preliminary patches to fix the KVM shutdown problem.  I
have those in my master branch at [1].  KVM + kexec works properly with that
branch.  Patches neeeded:

 arm64: kvm: add a cpu tear-down function
 arm64: kexec: fix kvm issue
 arm64/kvm: Remove !KEXEC Kconfig dependency
 arm64/kexec: Enable kexec in the arm64 defconfig

/memreserve/
----------

PROBLEM: Device tree /memreserve/ entries are not available in
/proc/device-tree.  For systems that have /memreserve/ entries and use
/proc/device-tree during kexec, the second stage kernel will use the reserved
regions and the system will become unstable.

WORK-AROUND: Enable the kernel config option CONFIG_SYSFS=y to expose a binary
device tree to user space at /sys/firmware/fdt that includes /memreserve/
entries OR pass a user specified DTB using the kexec --dtb option.

FIX: This is expected behavior.  To maximize user support, rework device tree
definitions to not use /memreserve/ entries.

-Geoff

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v8

for you to fetch changes up to 9d94104463ae6e3472526fb69e8111201c4a1fa7:

  arm64/kexec: Add pr_devel output (2015-03-19 12:21:43 -0700)

----------------------------------------------------------------
Geoff Levand (6):
      arm64: Fold proc-macros.S into assembler.h
      arm64: Convert hcalls to use HVC immediate value
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add EL2 switch to soft_restart
      arm64/kexec: Add core kexec support
      arm64/kexec: Add pr_devel output

 arch/arm64/Kconfig                  |   9 ++
 arch/arm64/include/asm/assembler.h  |  37 ++++++-
 arch/arm64/include/asm/kexec.h      |  48 +++++++++
 arch/arm64/include/asm/proc-fns.h   |   4 +-
 arch/arm64/include/asm/virt.h       |  40 ++++++++
 arch/arm64/kernel/Makefile          |   1 +
 arch/arm64/kernel/hyp-stub.S        |  43 +++++---
 arch/arm64/kernel/machine_kexec.c   | 189 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c         |   6 +-
 arch/arm64/kernel/relocate_kernel.S | 149 ++++++++++++++++++++++++++++
 arch/arm64/kvm/Kconfig              |   1 +
 arch/arm64/kvm/hyp.S                |  16 +--
 arch/arm64/mm/cache.S               |   2 -
 arch/arm64/mm/proc-macros.S         |  54 -----------
 arch/arm64/mm/proc.S                |  49 +++++++---
 include/uapi/linux/kexec.h          |   1 +
 16 files changed, 557 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S
 delete mode 100644 arch/arm64/mm/proc-macros.S

-- 
2.1.0
