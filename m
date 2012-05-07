From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 11:37:29 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071014.03632.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
 <20120507094718.GD4415@opensource.wolfsonmicro.com>
 <201205071014.03632.arnd@arndb.de>
Message-ID: <20120507103724.GF4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 10:14:03AM +0000, Arnd Bergmann wrote:
> On Monday 07 May 2012, Mark Brown wrote:

> > Don't think I've got any examples with regions beginning at 0 but other
> > regions seem to not run into any problems with overlap.  Note that all
> > these drivers do with the regions is use them to look up the base
> > register.

> ISA devices start at 0. Using a definition for IORESOURCE_IO of "PCI
> port number for relatively large values, but either ISA or PCMCIA or
> an arbitrary MFD for relatively small values" is absolutely crazy.

So what you're saying is that it's nothing to do with zero and just
about plain conflicts - there's nothing magic about zero (which is what
Russell seemed to be suggesting)?  For whatever reason in the MFD usage
the conflicts don't seem to be triggering - I suspect it's because the
struct resource is simply inspected by the driver rather than doing
whatever it is that PCI/ISA devices do with them, though I've not
checked recently.

> FWIW, there are resources you define in include/linux/mfd/wm831x/core.h
> that have values between 0x4000 and 0x8000, which is exactly the
> range occupied by PCI devices on my thinkpad. It's only a matter of
> time until someone puts conflicting devices into one machine.

Yes, I agree it will be a problem if they're part of the same resource
tree and used via the same API but if we allow multiple trees of I/O
resources then does that avoid the issue?  It seems like it ought to be
something we can do, if not we'll have to define a new resource type and
like I say it's a pretty full bitmask at the minute...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/72995196/attachment.sig>
