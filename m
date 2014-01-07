From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:03:10 +0100
Subject: [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
Message-ID: <20140107220310.GD3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

One of the great strength of Allwinner's kernel is that it behaves
pretty much like DT does: their kernel image is mostly generic, and
all the device specific part is stored in a binary file (compiled from
a FEX file), that gets loaded together with the kernel by the
bootloader.

The kernel will then parse that file to get all the informations it
needs (which devices are enabled, which pins are muxed to what
function, etc.). Sounds familiar?

FEX and DT however are not compatible at all, so one board out there
might not have any support in mainline, while it already passes the
hardware description to the kernel.

Hence why I started to work on sunxi-babelfish. It aims at being a
very thin wrapper around the kernel image, that would generate an
uImage, with the babelfish code itself, plus the compiled DTSI we have
for the targetted SoCs, and finally the kernel image. During bootup,
babelfish will take one of these DTBs, and complete it using the
informations fetched from the compiled FEX file the board is feeding
it, before finally passing the DTB to Linux that will continue its
usual boot.

I've been working on this for a week, but we already have all the
pieces of infrastructure needed, plus some basic support for the
devices themselves. Currently, babelfish will only care about the
ATAGS and the UARTs, but I expect the list of devices it's aware of to
grow quite quickly.

The code is stored here:
  https://github.com/mripard/sunxi-babelfish/

There's a lot of room for improvements, so patches are welcome :)

Once downloaded, you can compile it using:
  CROSS_COMPILE=arm-linux- ZIMAGE=kernel/arch/arm/boot/zImage make uImage

It will obviously generate a uImage, that you will be able to boot
from u-boot.

This has been tested on the A20-olinuxino, so there might be some
glitches on the other SoCs, but I don't really expect any at the
moment, since stuff are pretty generic for now.

Another nice thing about it is that a FEX-to-DT compiler comes at no
cost afterwards. Since dtc is able to generate a DTS from
/proc/device-tree, you can easily generate a DTS for your previously
non-supported board using

  dtc -I fs -O dts -o my-board.dts /proc/device-tree/

Anyway, enough talking. Any feedback is, as usual, appreciated.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/46139cde/attachment.sig>
