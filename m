From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Mar 2016 14:56:06 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160323133612.GO2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132637.GC19953@lunn.ch>
 <20160323133612.GO2566@sirena.org.uk>
Message-ID: <20160323135606.GE19953@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 01:36:12PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2016 at 02:26:37PM +0100, Andrew Lunn wrote:
> 
> > The number of windows is limited. On i think the Armada XP, if you put
> > a PCIe device on every available PCIe bus, you can run out of
> > windows. This is why Thomas implemented dynamic allocation of the
> > Windows, so that only those that are needed are used.
> 
> > So i would not statically and globally allocate as many windows as
> > possible SPI devices.
> 
> > The fact that SPI can fall back to another mechanism if there are no
> > available windows, were as PCIe cannot, suggests that SPI should
> > dynamically allocate a window, and be prepared for it to fail.
> 
> > Since only one SPI device can be active at once on a SPI bus, one
> > window per bus makes sense, and keeps the required number of windows
> > to a minimum.
> 
> If we're under pressure for windows I'd go further and say that we
> should be dynamically allocating the windows only when they're actually
> in use (and modifying other drivers to do the same if that makes sense
> for them), unless it's somehow expensive to allocate windows that means
> that we should reduce the overall pressure.

Hi Mark

We are only under pressure in the extremes, i.e 10 PCIe busses in
use. Only allocating PCIe Windows when needed means in practice, we
have not had issues. We need to be mindful, and don't waste them, but
we don't need to consider them a scarce resource.

I don't see it being an issue for the SPI driver to allocate one on
probe and keeping it until release. I probably would object to it
allocating one per chip select line.

   Andrew
