From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Aug 2017 10:09:08 +0100
Subject: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
In-Reply-To: <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
 <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
 <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
Message-ID: <20170817090908.GP20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 11:16:20AM +0200, Linus Walleij wrote:
> writel() should be guaranteeing that the values hit the hardware, wmb() is
> spelled out "write memory barrier" I don't see what you're after here.

Incorrect.  writel() has a barrier which ensures that data written to
memory (eg, dma coherent memory) is visible to the hardware prior to
the write hitting the hardware.

There is no barrier to ensure that the write hits the hardware in a
timely manner - the write can be buffered by the buses, which will
delay it before it hits its destination.

PCI particularly buffers MMIO writes, and the requirement there has
always been that if you need the write to hit the hardware in a timely
fashion, you must perform a read-back to force the bus to deliver the
write (since a read is not allowed to overlap a write.)

The solution is never to use barrier() - barrier() is a _compiler_
barrier and does nothing for posted writes on hardware buses.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
