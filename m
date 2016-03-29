From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 09:47:58 -0700
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <29105031.S6XB0bXn2i@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <10747635.WkGeFaKqdy@wuerfel> <20160325223922.GG5028@sirena.org.uk>
 <29105031.S6XB0bXn2i@wuerfel>
Message-ID: <20160329164758.GQ2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 02:39:10PM +0200, Arnd Bergmann wrote:
> On Friday 25 March 2016 22:39:22 Mark Brown wrote:

> > So there are some complicated constraints that make it hard to allocate
> > from the bus space?

> Yes, it's basically an optimization problem: the closer you can squeeze
> everything together, the more address space you have left for RAM and/or
> PCI.

But there are allocation constraints that make that hard?

> What we really have though is additional registers that belong to
> the SPI controller and that are not part of internal-regs, so
> we need to move it up one level out of the internal-regs node in order
> to add more registers:

That seems fine, it's part of the controller binding.

> I think it makes a lot of sense to define a separate window for each CS
> at boot time, just so you don't have to reprogram the windows manually.
> After all, the entire point of the direct mode is to avoid having to
> do any of the setup work, and have the SPI master set the right CS
> itself based on the MBus ID that is used for accessing the slave mmio
> window. This is also required if we want to enable things like
> XIP (DaX) mappings for file systems on a SPI-NOR flash.

Well, in the cases where we have one device on the bus then it's not a
big deal since we can check what the last thing we set was.  The direct
access stuff is going to have trouble if we have multiple devices on the
bus since we try to mix it with non-MMIO access we run the risk of
conflicting simultaneous use unless we continue to route everything
through the SPI subsystem (like we do with the current flash read
support).

It really only makes a difference if the reprogramming process happens a
lot and is expensive relative to the transfers and that doesn't seem
like something I'd expect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/16f7e02c/attachment.sig>
