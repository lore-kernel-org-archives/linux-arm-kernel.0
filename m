From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 08:13:29 +0100
Subject: linux-next: arm64 no longer boots with initramfs in qemu tests
In-Reply-To: <20160214221242.GA23489@roeck-us.net>
References: <20160214221242.GA23489@roeck-us.net>
Message-ID: <CAKv+Gu-dyLKo2y503Lj7Uc7qwO5-b9LyZNAeV0guse86uuAqxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2016 at 23:12, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi,
>
> my qemu tests for arm64 fail to boot in linux-next, starting with next-20160209.
> Primary error is
>
>   VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
>   Please append a correct "root=" boot option; here are the available partitions:
>   Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>
> but that doesn't mean much since I try to boot an initramfs.
>
> A bisect attempt points to 'arm64: move kernel image to base of vmalloc area',
> but that doesn't really help since some of the bisect attempts fail to build
> with linker errors. Just for reference, a bisect log is attached.
>
> Comparing console logs between 4.5-rc3 and next-20160212, one key difference is
> that the kernel now displays
>
>   Moving initrd from [88000000-889ae7ff] to [5d251000-5dbff7ff]
>
> which was not the case before. Turns out RAM ends at 60000000, so the address
> appears to be a bit odd (4.5-rc3 shows initramfs at a lower address).
> My qemu test runs with 512MB RAM. If I increase the RAM size to 2G,
> the "Moving" message is no longer displayed. However, I still get the same
> error.
>
> Qemu command line:
>
> qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt \
>         -nographic -smp 1 -m 512 -kernel arch/arm64/boot/Image \
>         -initrd rootfs.arm64.cpio -append "console=ttyAMA0"
>
> Configuration is defconfig. Initramfs can be copied from
>         https://github.com/groeck/linux-build-test/blob/master/rootfs/arm64/rootfs.arm64.cpio
>
> Please let me know if there is anything I can do to help tracking down
> the problem.
>

Hi Guenter,

Thanks for the detailed analysis. This looks like the same issue I fixed here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/477645

Regards,
Ard.
