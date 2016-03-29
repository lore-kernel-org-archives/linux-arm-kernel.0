From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 21:49:09 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160329164758.GQ2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <29105031.S6XB0bXn2i@wuerfel> <20160329164758.GQ2350@sirena.org.uk>
Message-ID: <21028994.N5ajfyoUoV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 09:47:58 Mark Brown wrote:
> 
> > I think it makes a lot of sense to define a separate window for each CS
> > at boot time, just so you don't have to reprogram the windows manually.
> > After all, the entire point of the direct mode is to avoid having to
> > do any of the setup work, and have the SPI master set the right CS
> > itself based on the MBus ID that is used for accessing the slave mmio
> > window. This is also required if we want to enable things like
> > XIP (DaX) mappings for file systems on a SPI-NOR flash.
> 
> Well, in the cases where we have one device on the bus then it's not a
> big deal since we can check what the last thing we set was.  The direct
> access stuff is going to have trouble if we have multiple devices on the
> bus since we try to mix it with non-MMIO access we run the risk of
> conflicting simultaneous use unless we continue to route everything
> through the SPI subsystem (like we do with the current flash read
> support).
> 
> It really only makes a difference if the reprogramming process happens a
> lot and is expensive relative to the transfers and that doesn't seem
> like something I'd expect.

Maybe we can avoid that if we enforce at the driver level that we
use the same mode for all slaves? The way I read the manual, I think
that's how it is intended at least.

Also, as mentioned we don't have any machine with more than one SPI
slave so far, so we don't really need to overengineer it and can
go for the simplest implementation in the SPI master driver.

	Arnd
