From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 10:27:25 +0100
Subject: [PATCH] mtd: sh_flctl: pass FIFO as physical address
In-Reply-To: <CAMuHMdXjquhLKsby1QZ+U9JN7bVrxX4guPgC0EQuLXJcmVKACw@mail.gmail.com>
References: <3152458.D3kElfhRW2@wuerfel> <20151210022146.GH144338@google.com>
 <CAMuHMdXjquhLKsby1QZ+U9JN7bVrxX4guPgC0EQuLXJcmVKACw@mail.gmail.com>
Message-ID: <6087453.7mT0kthNee@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 10:02:06 Geert Uytterhoeven wrote:
> 
> On Thu, Dec 10, 2015 at 3:21 AM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > On Tue, Dec 08, 2015 at 05:30:02PM +0100, Geert Uytterhoeven wrote:
> >> On Tue, Dec 8, 2015 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > By convention, the FIFO address we pass using dmaengine_slave_config
> >> > is a physical address in the form that is understood by the DMA
> >> > engine, as a dma_addr_t, phys_addr_t or resource_size_t.
> >> >
> >> > The sh_flctl driver however passes a virtual __iomem address that
> >> > gets cast to dma_addr_t in the slave driver. This happens to work
> >> > on shmobile because that platform sets up an identity mapping for
> >> > its MMIO regions, but such code is not portable to other platforms,
> >> > and prevents us from ever changing the platform mapping or reusing
> >> > the driver on other architectures like ARM64 that might not have the
> >> > mapping.
> >>
> >> Note that since the removal of (ARM) sh7367/sh7377/sh7372 support, this
> >> driver is used on SH only.
> >
> > It's still available as COMPILE_TEST, so it's still worth fixing.
> >
> > But really, does anyone use this driver any more?
> 
> It's used on the sh7723-based AP-325RXA board.
> No idea if anyone is really using it.

If the question is about removing the driver, I think the answer then is
that we should either remove the platform and the driver, or neither
of them. sh7723 seems to be one of the more recent ones (added in 2009,
only 7 of the 40 CPU subtypes are more recent, the last ones were
added in 2012).

	Arnd
