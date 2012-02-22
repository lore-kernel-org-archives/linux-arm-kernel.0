From: ru@gnudd.com (Alessandro Rubini)
Date: Wed, 22 Feb 2012 20:13:39 +0100
Subject: AMBA devices behing a PCI bridge
Message-ID: <20120222191339.GA28388@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell.
I'm working, with some mates, on a device which is basically a bridge
from PCIe to AMBA.

Some of the peripherals that live behind the bridge are actually
normal primecell devices, with minor or no modifications from the
original ARM cores. The list includes dma, uart, spi, i2c and mmc.

The code that I received (on show at sta2x11.sourceforge.net) includes
several files that are almost exact copies of the respective amba
drivers in a pci enclosure. Then, the actual code includes a number of
other changes, but that's another issue that I'll attack later.

I don't like this code duplication and I don't think it is acceptable
upstream. So I tried to enable amba under arch/x86; in this way I
could write a simple PCI driver that registers one amba
device every time its probe function is called.  The ends meet and I
happily find my 4 serial ports registered in the system -- they are
not currently working: bugs are a fact of life and I'm working on it.

I'm confident this is the way to go for all the devices listed above.
If you agree with me, as ARM and AMBA maintainer, then I'd love to
have your opinion about how to address the following three issues.  I
currently just hacked stuff up to prove it works, but I can submit the
relevant patches for discussion and integration, if the idea is
accepted.

* CONFIG_ARM_AMBA: maybe it's high time to rename it to CONFIG_AMBA (
or CONFIG_PRIMECELL) like we have CONFIG_PCI, CONFIG_USB and a zillion
others? (I expect both the new and old config names to be accepted
for a while, to allow out-of-tree code to sync gracefully)

* <asm/sizes.h>: most of the amba world uses this header. Maybe it should
be turned into <linux/sizes.h>, since it has nothing arch-specific in it?
(you may remember I removed the inclusion from amba/bus.c, but that's
not enough as most amba code uses the header anyways).

* Not all archs use the clk API. Currently I copied over the empty
definitions found in arch/m68k/platform/coldfire/clk.c into
arch/x86/platform/sta2x11/clk.c . Maybe we should offer weak empty
definition for those functions? Or should the clk world be ported to x86
and other architectures? (the latter I can't do by myself, I'm sorry).

/alessandro
