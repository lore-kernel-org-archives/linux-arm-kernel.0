From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:51:48 +0000
Subject: [PATCH 00/13] arm64 kexec kernel patches V2
Message-ID: <cover.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series adds the core support for kexec re-boots on arm64.  I have tested
with the ARM VE fast model using various kernel config options for both the
first and second stage kernels.

To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools [2], which have not yet been merged upstream, are needed.

This series does not include some re-work of the spin-table CPU enable method
that is needed to support it, nor does it include some re-work of KVM to support
CPU soft reset.  A kernel built with these patches will boot and run correctly,
but will fail to load a kexec kernel if running on a machine with any spin-table
enabled CPUs and will fail the kexec re-boot if the first stage kernel was built
with CONFIG_KVM=y.  Work-in-progress patches to support these are in the master
branch of my linux-kexec repository [1].

Patches 1-5 rework the arm64 hcall mechanism to give the arm64 soft_restart()
routine the ability to switch exception levels from EL1 to EL2 for kernels that
were entered in EL2.

Patches 6 and 7 add two new arm64 generic routines read_cpu_properties() and
local_disable() that the kexec code uses.

Patches 8-10 fixup machine_shutdown() to work correctly for a kexec re-boot.
The implementation relies on the effects of smp_send_stop() to shutdown the
secondary processors of an SMP system via the cpu_disable and cpu_die methods of
the arm64 cpu_ops structure.

Patches 11 and 12 add the actual kexec support.

Patch 13 adds a kernel command line parameter kexec_ignore_compat_check for
expert users to give more control over loading second stage kernels.

Please consider all patches for inclusion.  Any comments or suggestions on how 
to improve are welcome.

[1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
[2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff

The following changes since commit e3672649faae400e8a598938766a63f395a27ae6:

  arm64: defconfig: increase NR_CPUS default to 64 (2014-09-08 14:55:27 +0100)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v2

for you to fetch changes up to 99f09410a26c001efd06c270aa2e348d6cac6b01:

  arm64/kexec: Add kexec_ignore_compat_check param (2014-09-09 15:33:48 -0700)

Geoff Levand (13):
  arm64: Add ESR_EL2_EC macros to hyp-stub
  arm64/kvm: Fix assembler compatibility of macros
  arm64: Convert hcalls to use ISS field
  arm64: Add new hcall HVC_CALL_FUNC
  arm64: Add EL2 switch to soft_restart
  arm64: Add new routine read_cpu_properties
  arm64: Add new routine local_disable
  arm64: Use cpu_ops for smp_stop
  arm64/kexec: Kexec expects cpu_die
  arm64/kexec: Revert change to machine_shutdown()
  arm64/kexec: Add core kexec support
  arm64/kexec: Enable kexec in the arm64 defconfig
  arm64/kexec: Add kexec_ignore_compat_check param

 Documentation/kernel-parameters.txt |  13 +
 arch/arm64/Kconfig                  |   8 +
 arch/arm64/configs/defconfig        |   1 +
 arch/arm64/include/asm/cpu_ops.h    |   2 +-
 arch/arm64/include/asm/irqflags.h   |  13 +
 arch/arm64/include/asm/kexec.h      |  52 +++
 arch/arm64/include/asm/kvm_arm.h    |   2 +-
 arch/arm64/include/asm/proc-fns.h   |   4 +-
 arch/arm64/include/asm/virt.h       |  31 ++
 arch/arm64/kernel/Makefile          |   2 +
 arch/arm64/kernel/cpu-properties.c  |  58 ++++
 arch/arm64/kernel/cpu-properties.h  |  39 +++
 arch/arm64/kernel/hyp-stub.S        |  51 ++-
 arch/arm64/kernel/machine_kexec.c   | 627 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c         |  15 +-
 arch/arm64/kernel/psci.c            |   4 +-
 arch/arm64/kernel/relocate_kernel.S | 185 +++++++++++
 arch/arm64/kernel/smp.c             |   9 +
 arch/arm64/kvm/hyp.S                |  19 +-
 arch/arm64/mm/proc.S                |  47 ++-
 include/uapi/linux/kexec.h          |   1 +
 21 files changed, 1139 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/cpu-properties.c
 create mode 100644 arch/arm64/kernel/cpu-properties.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
1.9.1
