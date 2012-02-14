From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2012 18:12:38 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <20120214174035.GA29765@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202141716.26930.arnd@arndb.de>
 <20120214174035.GA29765@n2100.arm.linux.org.uk>
Message-ID: <201202141812.38847.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2012, Russell King - ARM Linux wrote:
> > Yes, at least in the long run. Note that this should make no difference
> > at all from a performance point of view, but it does impact code size a bit.
> 
> That depends whether the additional reloads of pci_io_base can be properly
> scheduled by the compiler, and experience shows that you tend to end up
> with the load delay slot not being filled on older processors.
> 
> Not only that, but the compiler will evaluate the entire:
> 
>         pci_io_base + (addr & IO_SPACE_LIMIT)
> 
> thing every time.  With a 64K mask, that will include reloading the
> mask every single access.
> 
> So, we'll probably end up with about three additional loads per IO
> operation, none of which would be scheduled particularly well.
> 
> "Yuck" and "not in my kernel" comes to mind.

I totally agree with the code size point, but my point above was that
from performance perspective all that you mentioned should be dwarfed
by the overhead of actually doing a synchronous operation on an
external bus. writel may be reasonably fast on a CPU internal bus,
but inb/outb implies a full bus synchronization and is only
used on older PCI hardware, typically those that date back to
ISA in some form.

	Arnd
