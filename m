From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Fri, 13 Oct 2017 11:02:42 -0400
Subject: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <20171013145431.GA5919@leverpostej>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com> <20171013145431.GA5919@leverpostej>
Message-ID: <CAOAebxvdxNwq5yV+7DpHu_u_k_vxmmwMdGQJzT+iGwnez8EO-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Do you know what your physical memory layout looks like?

[    0.000000] Memory: 34960K/131072K available (16316K kernel code,
6716K rwdata, 7996K rodata, 1472K init, 8837K bss, 79728K reserved,
16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     kasan   : 0xffff000000000000 - 0xffff200000000000
( 32768 GB)
[    0.000000]     modules : 0xffff200000000000 - 0xffff200008000000
(   128 MB)
[    0.000000]     vmalloc : 0xffff200008000000 - 0xffff7dffbfff0000
( 96254 GB)
[    0.000000]       .text : 0xffff200008080000 - 0xffff200009070000
( 16320 KB)
[    0.000000]     .rodata : 0xffff200009070000 - 0xffff200009850000
(  8064 KB)
[    0.000000]       .init : 0xffff200009850000 - 0xffff2000099c0000
(  1472 KB)
[    0.000000]       .data : 0xffff2000099c0000 - 0xffff20000a04f200
(  6717 KB)
[    0.000000]        .bss : 0xffff20000a04f200 - 0xffff20000a8f09e0
(  8838 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000
(  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000
(    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000
(  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0000200000
(     2 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800008000000
(   128 MB)

>
> Knowing that would tell us where shadow memory *should* be.
>
> Can you share the command line you're using the launch the VM?
>

virtme-run --kdir . --arch aarch64 --qemu-opts -s -S

and get messages from connected gdb session via lx-dmesg command.

The actual qemu arguments are these:

qemu-system-aarch64 -fsdev
local,id=virtfs1,path=/,security_model=none,readonly -device
virtio-9p-device,fsdev=virtfs1,mount_tag=/dev/root -fsdev
local,id=virtfs5,path=/usr/share/virtme-guest-0,security_model=none,readonly
-device virtio-9p-device,fsdev=virtfs5,mount_tag=virtme.guesttools -M
virt -cpu cortex-a57 -parallel none -net none -echr 1 -serial none
-chardev stdio,id=console,signal=off,mux=on -serial chardev:console
-mon chardev=console -vga none -display none -kernel
./arch/arm64/boot/Image -append 'earlyprintk=serial,ttyAMA0,115200
console=ttyAMA0 psmouse.proto=exps "virtme_stty_con=rows 57 cols 105
iutf8" TERM=screen-256color-bce rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
ro init=/bin/sh -- -c "mount -t tmpfs run /run;mkdir -p
/run/virtme/guesttools;/bin/mount -n -t 9p -o
ro,version=9p2000.L,trans=virtio,access=any virtme.guesttools
/run/virtme/guesttools;exec /run/virtme/guesttools/virtme-init"' -s -S
