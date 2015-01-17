From: geoff@infradead.org (Geoff Levand)
Date: Sat, 17 Jan 2015 00:23:34 +0000
Subject: [PATCH 0/8] arm64 kexec kernel patches V7
In-Reply-To: <cover.1415926876.git.geoff@infradead.orgg>
References: <cover.1415926876.git.geoff@infradead.orgg>
Message-ID: <cover.1421449714.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  This v7 of the
series is mainly just a rebase to the latest arm64 for-next/core branch
(v3.19-rc4), and a few very minor changes requested for v6.

I have tested with the ARM VE fast model, the ARM Base model and the ARM
Foundation model with various kernel config options for both the first and
second stage kernels.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

Patch 1 here moves proc-macros.S from arm64/mm to arm64/include/asm so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 2-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patches 5-8 add the actual kexec support.

Please consider all patches for inclusion.

Note that the location of my development repositories has changed:

[1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
[2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git

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

WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.

FIX: Fix KVM to support soft_restart().  KVM needs to restore default exception
vectors, etc.

UEFI
----

PROBLEM: UEFI does not manage its runtime services virtual mappings in a way
that is compatible with a kexec re-boot, so the second stage kernel hangs on
boot-up.

WORK-AROUND:  Disable UEFI in firmware.

FIX: Ard Biesheuvel has done work to fix this.  Basic kexec re-boot has been
tested and works.  More comprehensive testing is needed.

/memreserve/
----------

PROBLEM: The use of device tree /memreserve/ entries is not compatible with
kexec re-boot.  The second stage kernel will use the reserved regions and the
system will become unstable.

WORK-AROUND: Pass a user specified DTB using the kexec --dtb option.

FIX: An interface to expose a binary device tree to user space has been
proposed.  User kexec utilities will need to be updated to add support for this
new interface.

ACPI
----

PROBLEM: The kernel for ACPI based systems does not export a device tree to the
standard user space location of 'proc/device-tree'.  Current applications
expect to access device tree information from this standard location.

WORK-AROUND: Disable ACPI in firmware, OR pass 'acpi=off' on the first stage
kernel command line, OR pass a user specified DTB using the kexec --dtb option.

FIX: FIX: An interface to expose a binary device tree to user space has been
proposed.  User kexec utilities will need to be updated to add support for this
new interface.

----------------------------------------------------------------
The following changes since commit 6083fe74b7bfffc2c7be8c711596608bda0cda6e:

  arm64: respect mem= for EFI (2015-01-16 16:21:58 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v7

for you to fetch changes up to 7db998d9533d5efab816edfad3d7010fc2f7e62c:

  arm64/kexec: Enable kexec in the arm64 defconfig (2015-01-16 14:55:28 -0800)

----------------------------------------------------------------
Geoff Levand (8):
      arm64: Move proc-macros.S to include/asm
      arm64: Convert hcalls to use ISS field
      arm64: Add new hcall HVC_CALL_FUNC
      arm64: Add EL2 switch to soft_restart
      arm64/kexec: Add core kexec support
      arm64/kexec: Add pr_devel output
      arm64/kexec: Add checks for KVM
      arm64/kexec: Enable kexec in the arm64 defconfig

 arch/arm64/Kconfig                           |   9 ++
 arch/arm64/configs/defconfig                 |   1 +
 arch/arm64/include/asm/kexec.h               |  47 ++++++
 arch/arm64/include/asm/proc-fns.h            |   4 +-
 arch/arm64/{mm => include/asm}/proc-macros.S |   0
 arch/arm64/include/asm/virt.h                |  33 ++++
 arch/arm64/kernel/Makefile                   |   1 +
 arch/arm64/kernel/hyp-stub.S                 |  45 ++++--
 arch/arm64/kernel/machine_kexec.c            | 219 +++++++++++++++++++++++++++
 arch/arm64/kernel/process.c                  |  10 +-
 arch/arm64/kernel/relocate_kernel.S          | 160 +++++++++++++++++++
 arch/arm64/kvm/hyp.S                         |  18 ++-
 arch/arm64/mm/cache.S                        |   3 +-
 arch/arm64/mm/proc.S                         |  50 ++++--
 include/uapi/linux/kexec.h                   |   1 +
 15 files changed, 563 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 rename arch/arm64/{mm => include/asm}/proc-macros.S (100%)
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
2.1.0
