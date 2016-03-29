From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 12:52:30 -0700
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <21028994.N5ajfyoUoV@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <29105031.S6XB0bXn2i@wuerfel> <20160329164758.GQ2350@sirena.org.uk>
 <21028994.N5ajfyoUoV@wuerfel>
Message-ID: <20160329195230.GK2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 09:49:09PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 09:47:58 Mark Brown wrote:

> > Well, in the cases where we have one device on the bus then it's not a
> > big deal since we can check what the last thing we set was.  The direct
> > access stuff is going to have trouble if we have multiple devices on the
> > bus since we try to mix it with non-MMIO access we run the risk of
> > conflicting simultaneous use unless we continue to route everything
> > through the SPI subsystem (like we do with the current flash read
> > support).

> Maybe we can avoid that if we enforce at the driver level that we
> use the same mode for all slaves? The way I read the manual, I think
> that's how it is intended at least.

Well, we currently don't have any XIP or whatever support at all, it's
still only in the SPI operations so it's academic - that'd be a future
issue if we did start doing things that accessed the memory map outside
of the SPI flow.

> Also, as mentioned we don't have any machine with more than one SPI
> slave so far, so we don't really need to overengineer it and can
> go for the simplest implementation in the SPI master driver.

For me the simplest thing seems like just using one window for all the
devices, it seems more likely to deliver useful results without the
system integrator having to think about how to configure this for
optimisation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/10feda5e/attachment.sig>
