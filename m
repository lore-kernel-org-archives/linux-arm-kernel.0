From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:13 +0100
Subject: [PATCH 00/15] musb: Add support for the Allwinner sunxi musb
 controller
Message-ID: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This patch set has been a while in the making, so I'm very happy to present
the end result here, and I hope everyone likes it.

Before talking about merging this there are 2 things which I would like to
point out:

a) The musb controller in the sunxi SoCs uses some SRAM which needs to be
mapped to the musb controller by poking some bits in the SRAM controller,
just like the EMAC patches which were send a while back I've chosen to use
syscon for this, actually 2 of the patches in this set come directly from the
SRAM mapping patchset for the EMAC.

I know that Maxime is not 100% in favor of using syscon:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320221.html

But I disagree with his arguments for writing a special driver for the SRAM
controller:
1) syscon was specifically designed for global system control registers like
this and is fine to use as long as there are no conflicts where 1 bit is of
interest to multiple drivers, and there is no such conflict here
2) Maxime's other arguments seem to boil down to it would be nice / prettier
to have a specific driver for this, without really proving a hard need for
such a driver. But writing such a driver is going to be a lot of work, and
we've a ton of other work to do, and as said there is no real need for a
separate driver, syscon works fine for this.
3) I actually believe that having a specific driver for this is a bad idea,
because that means inventing a whole new cross driver API for this, and
getting those right is, hard, a lot of work, and even then one is still likely
to get it wrong. We can avoid all this by going with the proven syscon solution.

Maxime, can we please have your ack for moving forward with this using syscon?
(see above for my arguments why)


b) If you look closely at the new drivers/usb/musb/sunxi.c file you will see
that there is some register address translation happening in the
sunxi_musb_readb() function and related functions. This is necessary because
the registermap of the sunxi musb implementation is different from the other
musb implementation and sunxi uses multi-platform kernels.

I've considered adding full dynamic register map support to musb but I've
chosen not to. The problem is that the way the musb code currently works is
that there are 4 different address spaces used within the musb code:

1) musb->regs, the base address of the controller used for general control
register access like the DEVCTL and POWER regs

2) The address space at the offset returned by musb_io.ep_offset, which
contains ep control registers, this may be a different offset per endpoint,
or indexed by the INDEX register

3) The address space at the offset returned by musb_io.fifo_offset, which
contains the endpoint fifo data register, this is a different offset per ep.

4) The address space at the offset returned by MUSB_BUSCTL_OFFSET macro
(which gets repaced by musb_io.busctl_offset in this patchset), this may be a
different offset per endpoint, or indexed by the INDEX register

Turning this into something using dynamic register mapping is quite hard, esp.
since some parts of the address range are per endpoint and the number of
endpoints varies from one implementation to the next.

Besides this there also is the issue that I lack hardware to test invasive
changes like this for all different musb variants. So I've chosen to do the
necessary address translation (which really is only necessary for the general
control registers) in a sunxi specific readb & friends implementation, avoiding
the need to make invasive chances elsewhere and thus hopefully avoiding any
regressions.

Note that some small core changes are still necessary, mostly to rationalize
the busctl register handling, and make it more generic as sunxi has indexed
busctl registers.


So with that all said lets talk about getting this merged upstream, assuming
that the code passes review :)

The first patch in the set adds a header with defines for the sun4i syscon
registers. Since this has already been acked by one of the MFD maintainers,
I suggest we simply merge this through the musb maintainer together with all
the other musb patches, as this introduces a new file without changing any
other files collisions are impossible.

The second patch makes some minimal changes to the phy-sun4i-usb driver,
I believe it is best to merge this through the musb maintainer too, so that
all buildtime deps go in through one tree. Kishon can you review this patch
please and let us know if it is ok to merge this through the musb tree?

Then we get 5 musb patches, 4 preparation patches and 1 adding the actual
sunxi musb support, which should go through the musb tree obviously.

So assuming everyone agrees this means that patches 1 - 7 should be merged
through Felipe's tree. Felipe, is that ok with you and can you review these
patches please?

That leaves us with patches 8 - 15 which are all sunxi dts patches and as such
should go upstream through Maxime's tree once patches 1 - 7 are queued up
for merging. Maxime can you give these a review so that I can address any
comments, so that they will be ready to go once patches 1 - 7 are in place ?

Thanks & Regards,

Hans
