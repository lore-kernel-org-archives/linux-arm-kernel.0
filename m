From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jul 2011 13:25:27 +0100
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107011819.43316.arnd@arndb.de>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTikoMu3ccUxj5KRmKzdReQcBqK4Y9Q@mail.gmail.com>
	<201107011819.43316.arnd@arndb.de>
Message-ID: <20110702122527.GH21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 06:19:43PM +0200, Arnd Bergmann wrote:
> On Friday 01 July 2011, Barry Song wrote:
> > It looks like we can new a common function named as of_io_earlymap()
> > or something in drivers/of/address.c. of_iomap() does ioremap,
> > of_io_earlymap() does early static mapping?
> > Then all SoCs can call this function to do early static mapping. if
> > so, some lines can be deleted in sirfsoc_of_clk_init(). How do you
> > think about newing the function in drivers/of/address.c?
> 
> I think that's a good idea, but the ARM specific implementation cannot
> be in common code. Other architectures have stuff similar to iotable_init
> in asm/fixmap.h. If we decide on a function prototype for this, the
> implementation can be arch/*/.

One of the issues with fixmap is that its based around single pages
and indexing an area.  It's idiotic to use such a thing if you have
to map the ISA memory regions for VGA.

Plus, of course, forcing everything down the route of ioremap() and
fixmap forces everyone to use 2-level page tables and 4K page table
entries, avoiding the possibility of having just a single 1st level
page table entry covering their IO space.  Not only does it increase
TLB pressure but it also makes page table walking more expensive.
