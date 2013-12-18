From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Dec 2013 21:50:38 +0100
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1387226300.13062.161.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312161856.11384.arnd@arndb.de>
 <1387226300.13062.161.camel@host5.omatika.ru>
Message-ID: <201312182150.39037.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 December 2013, Sergei Ianovich wrote:
> On Mon, 2013-12-16 at 18:56 +0100, Arnd Bergmann wrote:
> > Ok, I see. This sounds like some of the other platforms we have with
> > external memory buses. If there is a chance that Linux ever has to
> > program the per-CS settings into the bus controller, I would suggest
> > to represent that as well as a separate node, like this
> 
> This is a platform-specific bus (PXA27x). Should it go into pxa27x.dtsi
> rather than machine dts?

Yes, that was the idea.

> > In case there is a driver for the extbus node, I would not make it
> > "simple-bus" but instead add a separate compatible string to match
> > the driver, and let that driver call of_platform_populate
> > to probe the children after the bus is set up.
> 
> There seems to be none at the moment. However, some machines need to
> setup these partitions as a part of their initialization. So complete
> migration to DT will require this driver.
> 
> In LP-8x4x case everything is setup by the bootloader. So "simple-bus"
> works for me.

Hmm, this is a bit tricky then. I think it would be best to not
use "simple-bus" then, to allow migrating the other platforms later,
but that will be a little more work. Maybe you can register a trivial
driver in the platform code that only calls of_platform_populate on
the device for now?

	Arnd
