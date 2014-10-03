From: geoff@infradead.org (Geoff Levand)
Date: Fri, 03 Oct 2014 23:12:23 +0000
Subject: [PATCH 0/8] arm64 kexec kernel patches V4
Message-ID: <cover.1412376956.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  I have tested
with  the arm64 wrapper program on the ARM VE fast model and the Foundation
model, and using Linaro's EFI build on the ARM base AEMv8 fast model with
various kernel config options for both the first and second stage kernels.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

This series does not include some re-work of the spin-table CPU enable method
that is needed to support it, nor does it include some re-work of KVM to support
CPU soft reset.  A first stage kernel built with these patches will boot and run
correctly, but will fail to load a second stage kernel if running on a machine
with any spin-table enabled secondary CPUs (CONFIG_SMP=n works OK), and will
fail the kexec re-boot resulting in a system hang if the first stage kernel was
built with CONFIG_KVM=y.  Work-in-progress patches to support these are in my
linux-kexec source repository [1].

Patches 1-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patch 5 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
dcache_line_size macro it defines can be uesd by kexec's relocate kernel
routine.

Patches 11-13 add the actual kexec support.

Please consider all patches for inclusion.  Any comments or suggestions on how 
to improve are welcome.

[1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
[2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff

The following changes since commit 0a6479b0ffad8dd236915e271faaf2cbb4cac287:

	arm64: Remove unneeded extern keyword (2014-10-03 14:51:02 +0100)

are available in the git repository at:

	git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v4

for you to fetch changes up to e122ed3a1b2afbaf69baf2c7cf354f7e557c5851:

	arm64/kexec: Add pr_devel output (2014-10-03 15:53:58 -0700)

----------------------------------------------------------------
Geoff Levand (8):
	arm64/kvm: Fix assembler compatibility of macros
	arm64: Convert hcalls to use ISS field
	arm64: Add new hcall HVC_CALL_FUNC
	arm64: Add EL2 switch to soft_restart
	arm64: Move proc-macros.S to include/asm
	arm64/kexec: Add core kexec support
	arm64/kexec: Enable kexec in the arm64 defconfig
	arm64/kexec: Add pr_devel output

arch/arm64/Kconfig                           |   9 ++
arch/arm64/configs/defconfig                 |   1 +
arch/arm64/include/asm/kexec.h               |  47 ++++++
arch/arm64/include/asm/kvm_arm.h             |  21 +--
arch/arm64/include/asm/proc-fns.h            |   4 +-
arch/arm64/{mm => include/asm}/proc-macros.S |   0
arch/arm64/include/asm/virt.h                |  33 ++++
arch/arm64/kernel/Makefile                   |   1 +
arch/arm64/kernel/hyp-stub.S                 |  45 ++++--
arch/arm64/kernel/machine_kexec.c            | 225 +++++++++++++++++++++++++++
arch/arm64/kernel/process.c                  |   6 +-
arch/arm64/kernel/relocate_kernel.S          | 184 ++++++++++++++++++++++
arch/arm64/kvm/hyp.S                         |  18 ++-
arch/arm64/mm/cache.S                        |   3 +-
arch/arm64/mm/proc.S                         |  50 ++++--
include/uapi/linux/kexec.h                   |   1 +
16 files changed, 600 insertions(+), 48 deletions(-)
create mode 100644 arch/arm64/include/asm/kexec.h
rename arch/arm64/{mm => include/asm}/proc-macros.S (100%)
create mode 100644 arch/arm64/kernel/machine_kexec.c
create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
1.9.1
