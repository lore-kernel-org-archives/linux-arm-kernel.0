From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 20:55:59 +0100
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130822193453.GB10038@ld-irv-0074.broadcom.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
 <20130822193453.GB10038@ld-irv-0074.broadcom.com>
Message-ID: <20130822195559.GU26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 12:34:53PM -0700, Brian Norris wrote:
> On Mon, Aug 19, 2013 at 12:10:01PM +0800, Huang Shijie wrote:

> > +- m25p,quad-read : Use the "quad read" opcode to read data from the chip instead
> > +                   of the usual "read" opcode. This opcode is not supported by
> > +                   all chips and support for it can not be detected at runtime.
> > +                   Refer to your chips' datasheet to check if this is supported
> > +                   by your chip.

> Why can't this be detected at runtime? We added a "no fast read" flag to
> the device table, so why not "dual/quad mode supported"? And believe it
> or not, not all m25p80 users have device tree. So it isn't very logical
> to tie this support to device-tree only.

There needs to be some way of saying if the additional data lines are
actually wired up or not; it could be a negative property (flagging if
the lines are not present) but that runs the risk of breaking systems
if a driver acquires the ability to support extra data lines but a
system doesn't have it.

This should be a generic property for all quad devices to use, though,
since the same thing applies everywhere.

> This is not correct. You are assuming that the SPI master knows to read
> with 4 IO lines, instead of the traditional 1 line; IOW, you are
> assuming that:
> (1) if the slave DT node has "quad-read", then the whole system supports
>     it (bad design; you're putting assumptions about the "parent" node
>     in the child)

This is fine, the device tree is for the board as a whole not for the
individual chips - if the board doesn't support quad read the device
tree shouldn't configure the chip for quad mode.  It really needs to be
a slave property since a system could opt to connect some devices with
extra data lines and some without on the same SPI bus.

> What you're really missing from device-tree (and the SPI subystem in
> general) is how to detect those SPI controllers which support dual and
> quad mode transfers, and how to communicate that a particular SPI
> transaction should be performed on 1 or 4 IO lines. We shouldn't have
> this just hacked in via assumptions.

That bit does need to be fixed in this driver, yes.  The SPI core now
has quad mode support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/9b508c5f/attachment.sig>
