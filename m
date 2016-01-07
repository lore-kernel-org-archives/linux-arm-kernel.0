From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 Jan 2016 13:25:35 +0000
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <567B41E3.5060800@roeck-us.net>
References: <567B41E3.5060800@roeck-us.net>
Message-ID: <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 December 2015 at 00:52, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi all,
>
> since commit 60792ad349f3 ("arm64: kernel: enforce pmuserenr_el0
> initialization
> and restore"), my arm64 qemu tests of linux-next are failing. After this
> commit,
> qemu does not display any output.
>
> Qemu version is 2.5.0. Linux kernel configuration is arm64:defconfig.
>
> qemu command line is as follows:
>
>         qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt
> -nographic -smp 1 \
>                 -m 512 -kernel arch/arm64/boot/Image -initrd
> rootfs.arm64.cpio -no-reboot \
>                 -append "console=ttyAMA0"
>
> Any idea what might cause this problem and how to fix it (presumably in
> qemu) ?

This turns out to be because QEMU doesn't currently implement
PMUSERENR_EL0 for AArch64 (we do have an AArch32 implementation),
so you get an immediate UNDEF when the kernel touches it, followed
by an infinite loop of UNDEF exceptions because the instruction
at the UNDEF vector entrypoint is unallocated at this point in
execution.

We had previously been relying on the kernel not attempting to
touch the PMU if the ID_AA64DFR0_EL1 PMUVer bits read 0000
("Performance Monitors extension System registers not implemented").

Since the v8 ARM ARM states that the Performance Monitors Extension is
an optional feature of an implementation, this seems like a kernel
bug to me. (QEMU should probably get round to implementing the PMU
at some point for feature parity with v7, but this has not been
a priority for us since they're not actually very useful in a
fully emulated setup.)

thanks
-- PMM
