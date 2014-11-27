From: dyoung@redhat.com (Dave Young)
Date: Thu, 27 Nov 2014 14:19:47 +0800
Subject: [PATCH 0/8] arm64 kexec kernel patches V6
In-Reply-To: <cover.1415926876.git.geoff@infradead.org>
References: <cover.1415926876.git.geoff@infradead.org>
Message-ID: <20141127061947.GB2860@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geoff,

Is there any Linaro card for the KVM soft restart issue?

Ccing Andrew Jones since he might be interested in KVM issues.

On 11/14/14 at 01:22am, Geoff Levand wrote:
> Hi All,
> 
> This series adds the core support for kexec re-boots on arm64.  I have tested
> with the ARM VE fast model, the ARM Base model and the ARM Foundation
> model with various kernel config options for both the first and second stage
> kernels.
> 
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
> 
> Patches 1-3 rework the arm64 hcall mechanism to give the arm64 soft_restart()
> routine the ability to switch exception levels from EL1 to EL2 for kernels that
> were entered in EL2.
> 
> Patch 4 moves proc-macros.S from arm64/mm to arm64/include/asm so that the
> dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> routine.
> 
> Patches 5-8 add the actual kexec support.
> 
> Please consider all patches for inclusion.  Any comments or suggestions on how 
> to improve are welcome.
> 
> [1]  https://git.linaro.org/people/geoff.levand/linux-kexec.git
> [2]  https://git.linaro.org/people/geoff.levand/kexec-tools.git
> 
> Several things are known to have problems on kexec re-boot:
> 
> spin-table
> ----------
> 
> PROBLEM: The spin-table enable method does not implement all the methods needed
> for CPU hot-plug, so the first stage kernel cannot be shutdown properly.
> 
> WORK-AROUND: Upgrade to system firmware that provides PSCI enable method
> support, OR build the first stage kernel with CONFIG_SMP=n, OR pass 'maxcpus=1'
> on the first stage kernel command line.
> 
> FIX: Upgrade system firmware to provide PSCI enable method support or add
> missing spin-table support to the kernel.
> 
> KVM
> ---
> 
> PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
> resources on shutdown, so the first stage kernel cannot be shutdown properly.
> 
> WORK-AROUND:  Build the first stage kernel with CONFIG_KVM=n.
> 
> FIX: Fix KVM to support soft_restart().  KVM needs to restore default exception
> vectors, etc.
> 
> UEFI
> ----
> 
> PROBLEM: UEFI does not manage its runtime services virtual mappings in a way
> that is compatible with a kexec re-boot, so the second stage kernel hangs on
> boot-up.
> 
> WORK-AROUND: Disable UEFI in firmware, OR use EFI uboot emulation if provided
> by your firmware.
> 
> FIX: Fix kernel to manage UEFI virtual mappings properly.
> 
> /memreserve/
> ----------
> 
> PROBLEM: The use of device tree /memreserve/ entries is not compatible with
> kexec re-boot.  The second stage kernel will use the reserved regions and the
> system will become unstable.
> 
> WORK-AROUND: Pass a user specified DTB using the kexec --dtb option.
> 
> FIX: Convert device tree source files (.dts) and/or bootloaders to use device
> tree reserved-memory nodes to specify reserved memory or provide an in kernel
> mechanism to export the /memreserve/ entries to user space.
> 
> ACPI
> ----
> 
> PROBLEM: The kernel for ACPI based systems does not export a device tree to the
> standard user space location of 'proc/device-tree'.  Current applications
> expect to access device tree information from this standard location.
> 
> WORK-AROUND: Disable ACPI in firmware, OR pass 'acpi=off' on the first stage
> kernel command line, OR pass a user specified DTB using the kexec --dtb option.
> 
> FIX: Fix ACPI kernel support to export device tree information suitable for a
> kexec re-boot, and if this information is exported to somewhere other than
> 'proc/device-tree' update existing kexec user applications to use this new
> interface.
> 
> ----------------------------------------------------------------
> The following changes since commit 302cd37c417d59549d073a8986fd028998409cb9:
> 
>   arm64: kvm: eliminate literal pool entries (2014-11-07 15:04:54 +0000)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v6
> 
> for you to fetch changes up to 3fc5a4ba22342ccd8e7e5a09620b00f4b81667a6:
> 
>   arm64/kexec: Enable kexec in the arm64 defconfig (2014-11-13 16:52:16 -0800)
> 
> ----------------------------------------------------------------
> Geoff Levand (8):
>       arm64: Convert hcalls to use ISS field
>       arm64: Add new hcall HVC_CALL_FUNC
>       arm64: Add EL2 switch to soft_restart
>       arm64: Move proc-macros.S to include/asm
>       arm64/kexec: Add core kexec support
>       arm64/kexec: Add pr_devel output
>       arm64/kexec: Add checks for KVM and EFI
>       arm64/kexec: Enable kexec in the arm64 defconfig
> 
>  arch/arm64/Kconfig                           |   9 ++
>  arch/arm64/configs/defconfig                 |   1 +
>  arch/arm64/include/asm/kexec.h               |  47 ++++++
>  arch/arm64/include/asm/proc-fns.h            |   4 +-
>  arch/arm64/{mm => include/asm}/proc-macros.S |   0
>  arch/arm64/include/asm/virt.h                |  33 ++++
>  arch/arm64/kernel/Makefile                   |   1 +
>  arch/arm64/kernel/hyp-stub.S                 |  45 ++++--
>  arch/arm64/kernel/machine_kexec.c            | 232 +++++++++++++++++++++++++++
>  arch/arm64/kernel/process.c                  |  10 +-
>  arch/arm64/kernel/relocate_kernel.S          | 160 ++++++++++++++++++
>  arch/arm64/kvm/hyp.S                         |  18 ++-
>  arch/arm64/mm/cache.S                        |   3 +-
>  arch/arm64/mm/proc.S                         |  50 ++++--
>  include/uapi/linux/kexec.h                   |   1 +
>  15 files changed, 576 insertions(+), 38 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kexec.h
>  rename arch/arm64/{mm => include/asm}/proc-macros.S (100%)
>  create mode 100644 arch/arm64/kernel/machine_kexec.c
>  create mode 100644 arch/arm64/kernel/relocate_kernel.S
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
