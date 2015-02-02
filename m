From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Feb 2015 22:31:25 +0100
Subject: gzip initramfs while only lz4/lzop selected
Message-ID: <9c809c0a07de100e6e0112f482a589b9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Configuring the kernel without gzip support for initramfs but with
LZO/LZ4, while not having LZ4 on the build system, leads to a kernel
which is not bootable:

...
[    0.488232] RPC: Registered udp transport module.
[    0.493437] RPC: Registered tcp transport module.
[    0.498693] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.505922] Kernel panic - not syncing: compression method gzip not
configured
[    0.513855] ---[ end Kernel panic - not syncing: compression method
gzip not configured

I wondered, what format my initramfs might be, looking at the build
output suggested LZ4...

...
  CC      arch/arm/common/firmware.o
  CC      arch/arm/mm/dma-mapping.o
  CC      arch/arm/kernel/elf.o
  GEN     usr/initramfs_data.cpio.lz4
  AS      usr/initramfs_data.o
...

However...
$ file usr/initramfs_data.cpio.lz4
usr/initramfs_data.cpio.lz4: gzip compressed data, max compression, from
Unix

I actually use LZO and enabled LZ4 just to test some initramfs. But the
build system seem to have chosen it as its preferred compression method
for the built-in initramfs. 

I would have expected a build error or at least a warning on such a
situation.

The relevant .config part looks like this:
...
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
...

I hit this because my build machine produced binaries which did not boot
anymore (unfortunately, the tty is not initialized at that point, so I
was completely left in the dark at first).

There was a similar problem some time ago:
https://lkml.org/lkml/2009/2/17/477

--
Stefan
