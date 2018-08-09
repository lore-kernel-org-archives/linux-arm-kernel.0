From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 9 Aug 2018 10:15:14 -0700
Subject: qemu machine settings and root fs for armv8?
In-Reply-To: <5d585df0-abbe-c95f-adff-c4c2e3962832@redhat.com>
References: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
 <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
 <5d585df0-abbe-c95f-adff-c4c2e3962832@redhat.com>
Message-ID: <CAKwvOdnaknwFshVAk=G0x44RxZyrMPp+O2yFBauAe9-3C4DpTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2018 at 12:36 AM Laura Abbott <labbott@redhat.com> wrote:
>
> I usually use a buildroot environment and just boot as an initramfs:

I need to play around more with buildroot, but I'll bet that's an
option to make a ramdisk instead of a full disk image?

> qemu-system-aarch64 \
>         -s \
>         -smp 8 \
>         -machine virt \
>         -cpu cortex-a57 \
>         -machine type=virt \
>         -nographic \
>         -m 1024 \
>         -kernel /path/to/kernel \
>         --append "nokaslr slub_debug=- console=ttyAMA0 debug_pagealloc=on
> earlycon=pl011,0x9000000" \

Very cool, thank you for sharing!

I'm guessing that kaslr makes it difficult to keep track of addresses
in between reboots?  There's a parameter "panic=-1" that will reboot
the kernel on panic that probably works well with this.

>         -initrd /path/to/arm64_rootfs.cpio \
>         -fsdev local,security_model=passthrough,id=fsdev0,path=/tmp/share \
>         -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare
>
> I'll note that this setup makes using kernel modules a big pain but

How come?

> it's useful for certain types of testing.
> The virtio settings are from https://www.linux-kvm.org/page/9p_virtio
> for sharing files.

Wow, that's super cool!  That probably helps so that you don't need to
keep rebuilding your ramdisk.  For binaries I'd guess that any
dynamically linked dependencies would have to be in that dir, too,
otherwise the VM wouldn't be able to load them.  But maybe nice for
statically linked cross compiled binaries.

Thanks again.
-- 
Thanks,
~Nick Desaulniers
