From: glee-list@swspec.com (Greg Lee)
Date: Mon, 21 Sep 2009 20:00:51 -0400
Subject: Follow-up on "WARNING: at arch/arm/mm/consistent.c:368
	dma_free_coherent"
Message-ID: <f7cd29ea0909211700l4e79476bi9f09fe058804a17f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm following up on an old thread
(http://lists.arm.linux.org.uk/lurker/message/20080907.211924.e2bee80b.en.html)
from September 2008 between Russell King and Mikael Pettersson
regarding dmabounce.

Mikael Pettersson writes:

>I've now traced the actions in dmabounce.c, and I _think_ I
>understand what's going on.

...

>Tracing dmabounce.c:map_single() showed that bouncing never triggered
>due to the dma_mask, because clearly no page ever resided above it.
>However, mach-ixp4xx/common-pci.c:dma_needs_bounce() returned true
>whenever the very last page at 64MB-4096 was accessed. dma_needs_bounce()
>tests dma_addr + size >= SZ_64M, but that's actually off-by-one.
>Changing it to dma_addr + size - 1 >= SZ_64M disabled the bounces,
>but also caused the system hang to reappear.

I then found a recently updated patch from Mikael that appears to
address this problem here
(http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-arm-ixp4xx-disable-dmabounce-2.6.31).

This updated patch does not appear to account for the 4K region at the
end of the 64MB PCI window that I mentioned above.  Does this region
in fact need to be accounted for?  Or has this now been handled
differently?

Greg
