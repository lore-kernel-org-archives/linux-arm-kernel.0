From: geoff@infradead.org (Geoff Levand)
Date: Fri, 03 Apr 2015 09:48:39 -0700
Subject: [PATCH 0/6] arm64 kexec kernel patches V8
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <1428079719.1118.6.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I rebased my series to the latest arm64 for-next/core (v4.0-rc4)
and pushed it out to:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v9

-Geoff

On Thu, 2015-03-19 at 20:35 +0000, Geoff Levand wrote:
> Hi All,
> 
> This series adds the core support for kexec re-boots on arm64.  This v8 of the
> series is mainly just a rebase to Linux-4.0-rc3, and a few very minor changes
> requested for v7.
> 
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
> 
> I have tested with the ARM VE fast model, the ARM Base model and the ARM
> Foundation model with various kernel config options for both the first and
> second stage kernels.  Kexec on EFI systems works correctly.  With the ACPI
> kernel patches from [3] applied, kexec on ACPI systems seeems to work correctly.
> More ACPI + kexec testing is needed.
> 
> Patch 1 here moves the macros from proc-macros.S to asm/assembler.h so that the
> dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> routine.
> 
> Patches 2-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
> routine the ability to switch exception levels from EL1 to EL2 for kernels that
> were entered in EL2.
> 
> Patches 5-6 add the actual kexec support.
> 
> Please consider all patches for inclusion.
> 
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
> [3]  http://git.linaro.org/leg/acpi/acpi.git #acpi-topic-juno-fvp
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
> resources on shutdown, so the first stage kernel cannot be shutdown properly
> when using kexec.
> 
> WORK-AROUND: Build the first stage kernel with CONFIG_KVM=n, or apply KVM bug
> fix patches from [1].
> 
> FIX: Takahiro Akashi has preliminary patches to fix the KVM shutdown problem.  I
> have those in my master branch at [1].  KVM + kexec works properly with that
> branch.  Patches neeeded:
> 
>  arm64: kvm: add a cpu tear-down function
>  arm64: kexec: fix kvm issue
>  arm64/kvm: Remove !KEXEC Kconfig dependency
>  arm64/kexec: Enable kexec in the arm64 defconfig
> 
> /memreserve/
> ----------
> 
> PROBLEM: Device tree /memreserve/ entries are not available in
> /proc/device-tree.  For systems that have /memreserve/ entries and use
> /proc/device-tree during kexec, the second stage kernel will use the reserved
> regions and the system will become unstable.
> 
> WORK-AROUND: Enable the kernel config option CONFIG_SYSFS=y to expose a binary
> device tree to user space at /sys/firmware/fdt that includes /memreserve/
> entries OR pass a user specified DTB using the kexec --dtb option.
> 
> FIX: This is expected behavior.  To maximize user support, rework device tree
> definitions to not use /memreserve/ entries.
> 
> -Geoff
