From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 12:49:11 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120723102336.GH4435@opensource.wolfsonmicro.com>
References: <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
 <20120723101641.GD18778@lunn.ch>
 <20120723102336.GH4435@opensource.wolfsonmicro.com>
Message-ID: <20120723104911.GF18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:23:36AM +0100, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 12:16:41PM +0200, Andrew Lunn wrote:
> > On Mon, Jul 23, 2012 at 10:37:47AM +0100, Mark Brown wrote:
> 
> > > The bit I was saying was most low risk was the actual DT changes, as
> > > opposed to the bits that parse and use the DT.
> 
> > Ah, O.K. I understood you wrongly. I actually think they are the most
> > dangerous part. A board booting with these DT changes, and without the
> > driver enablement for DT is likely to fail to find its root
> > filesystem.
> 
> Why would that be?  If there's no DT support for the driver it'll just
> ignore the DT.

Yes, it ignores the DT. However, SPI driver never gets
instantiated. The FLASH chip on the SPI bus never gets
instantiated. MTD partitions are probably created, but since the
underlying device is missing, they don't work and the root filesystem
is not available.
 
There is no logic in the board code to first try DT, and if that
fails, use old fashioned platform_device instantiating of the drivers.

I've also had bad experiences when we have the old platform_device
instantiating plus DT also instantiating the same device.

The only way i've found to convert an existing board from
platform_device to DT is to first add DT support to the driver, and
then atomically swap platform_device structures for DT descriptions.

Andrew
