From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 10:57:45 +0000
Subject: [PATCH] clk: Add axi-clkgen driver
In-Reply-To: <50FFC02C.9000109@metafoo.de>
References: <1357755120-32735-1-git-send-email-lars@metafoo.de>
 <20130122175552.24671.27893@quantum> <50FFB4D8.5060801@metafoo.de>
 <20130123102755.GP23505@n2100.arm.linux.org.uk> <50FFC02C.9000109@metafoo.de>
Message-ID: <20130123105744.GQ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:49:16AM +0100, Lars-Peter Clausen wrote:
> On 01/23/2013 11:27 AM, Russell King - ARM Linux wrote:
> > On Wed, Jan 23, 2013 at 11:00:56AM +0100, Lars-Peter Clausen wrote:
> >> I think I read somewhere at some point that ioread{8,16,32} is preferred
> >> over write{b,h,l} in new code.
> > 
> > But... there's *no* point using ioread*() if you don't only use the
> > ioremap() interface.
> > 
> > ioread*() is there to allow PC IO and PC MMIO accesses through one
> > accessor depending on the cookie.  ioremap() only ever returns cookies
> > for MMIO accesses.
> 
> So your point is, if you know that it is MMIO memory only ever use readl and
> friends?

My point is... if you're going to stick with using ioremap(), then don't
bother with the potential overhead from ioread*() - you don't gain
anything but you have a few extra CPU cycles per access.  You might as
well just stick with read*() which aren't going anywhere anytime soon.

Sure, if you need stuff to work on both IO and MMIO accesses, then use
ioread*() but you'd also need the driver to:
- accept IORESOURCE_IO resource types.
- request these resources in the IO resource tree rather than the MMIO
  resource tree.
- use ioport_map() to "map" these resource types.

So, I don't mind seeing ioread*() in a driver _if_ it also uses IO resources
and handles them correctly, but it's pointless to use this accessor in any
driver which doesn't.
