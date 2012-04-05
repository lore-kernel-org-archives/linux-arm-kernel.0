From: ru@gnudd.com (Alessandro Rubini)
Date: Thu, 5 Apr 2012 11:31:52 +0200
Subject: RFC: setting up a pci-to-amba bridge device
Message-ID: <20120405093152.GA24229@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [This goes to Russell King and linux-arm-kernel because of amba.
    Cc: Giancarlo Asnaghi (chip manufacturer), Alan Cox (appointed
    reviewer of my patch-set for the chip), Linus Walleij who stated
    on-list to be happy to help with the review. Feel free to add
    other interested parties]


Hello all.

I sent a similar message on 2012-02-22, but things have proceeded
meanwhile, so I'm doing it again with a fresh new message. No context
assumed in readers, but I consider previous feedback I got while
drafting the trailing list of pending issues.


I'm working on a chip (called STA2X11) that is an I/O Hub for pc-class
computers. In practice it's an ARM SoC with its usual complete set of
peripherals; it has a PCIe bridge so the main CPU can use the
peripherals directly.  A number of them are AMBA (i.e. PrimeCell)
logic blocks, so for example the serial console is PL011, while the
SATA controller is no.  I suspect this path will be followed by other
manufactures as well in the upcoming years, so I'd love the thing
to be done cleanly and possibly merged.

There already is published code for those drivers, but all primecell
device code have been duplicated and then modified (or, worse
sometimes "#include"d from a pci driver, #ifdeffing out the amba
probe/release code).

Links: (http://sourceforge.net/projects/
http://sourceforge.net/projects/sta2x11/files/2.6.39/rel_20120309/sta2x11_RC4_20120309_2.6.39.4_patches.tgz/download)

What I'm doing, instead, is make a trivial pci driver that simply
registers an amba device every time its probe method is called.  The
amba driver, then, works by itself.  Where sourceforge code has
52kB of code, mine is 3kB (1kB compiled size):

  mine: -rw-rw-r-- 1 rubini staff   2990 Apr  4 13:08 amba-pl011-pci.c
  orig: -rw-rw-r-- 1 rubini staff  53698 Apr  4 18:03 amba-pl011.c
  sf:   -rw-rw-r-- 1 rubini staff  51381 Apr  4 13:08 pl011-pci.c

The I/O hub has a number of such devices, that can be supported with
minimal efforts by the bridge. This is the list of amba devices and
the status of internal code:

     UART ports (working as tty, also as console, also with DMA)
     DMA engine (working, thanks to Davide Ciminaghi)
     SPI (being worked on by Federico Vaga)
     MMCI (working, thanks to Davide, still not with DMA at this point)

This is the list of issues that are pending:

* CONFIG_ARM_AMBA: Russell, you suggested to rename to
CONFIG_ARM_PRIMECELL, for a good reason.  Shall I take over this
and submit patches or is just a theoretical idea?

* <asm/sizes.h> I submitted patches to move to <linux/sizes.h> as you
suggested but got no feedback. This was on March 1st, in a patch set
with other stuff that was not good.  Should I re-run the procedure,
with a sizes.h-only patch set?  If so, who is responsible to merge
this change which is somewhat multi-arch?  If I do it, I'd leave the
asm/ headers in place to not disturb current users, coming back to
this after a few months to add a #warning so users can fix themselves,
to then remove the asm/ headers after other few months. Ok?

* clk API: you suggested to wait for the unified implementation
to be merged and that's fine (I haven't checked recently the status,
but I'm going to do my homework here).

* memory areas (this is a new point, not present in my older message).
When amba/bus.c requests the device resources, it fails because of
the hosting PCI bus:

   [    6.866591] request [mem 0xcec00000-0xcec00fff]
   [    6.871110] conflict [mem 0xc7f00000-0xdfffffff]

This is the current /proc/iomem, after ignoring the error:

   c7f00000-dfffffff : PCI Bus 0000:00
     ce000000-dfffffff : PCI Bus 0000:01
       ce000000-dfffffff : PCI Bus 0000:02
         ce000000-d1ffffff : PCI Bus 0000:03
           cec00000-cec00fff : uart-pl011

Any suggestion about a good solution to this "ownership" problem of memory
areas?

Thanks a lot
/alessandro
