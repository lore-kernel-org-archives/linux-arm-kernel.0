From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 15 Jun 2011 09:11:39 +0200
Subject: [PATCH 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201106142030.07549.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106141803.00876.arnd@arndb.de>
	<op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>
	<201106142030.07549.arnd@arndb.de>
Message-ID: <000501cc2b2b$789a54b0$69cefe10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 14, 2011 8:30 PM Arnd Bergmann wrote:

> On Tuesday 14 June 2011 18:58:35 Michal Nazarewicz wrote:
> > On Tue, 14 Jun 2011 18:03:00 +0200, Arnd Bergmann wrote:
> > > For all I know, that is something that is only true for a few very
> > > special Samsung devices,
> >
> > Maybe.  I'm just answering your question. :)
> >
> > Ah yes, I forgot that separate regions for different purposes could
> > decrease fragmentation.
> 
> That is indeed a good point, but having a good allocator algorithm
> could also solve this. I don't know too much about these allocation
> algorithms, but there are probably multiple working approaches to this.
> 
> > > I would suggest going forward without having multiple regions:
> >
> > Is having support for multiple regions a bad thing?  Frankly,
> > removing this support will change code from reading context passed
> > as argument to code reading context from global variable.  Nothing
> > is gained; functionality is lost.
> 
> What is bad IMHO is making them the default, which forces the board
> code to care about memory management details. I would much prefer
> to have contiguous allocation parameters tuned automatically to just
> work on most boards before we add ways to do board-specific hacks.

I see your concerns, but I really wonder how to determine the properties
of the global/default cma pool. You definitely don't want to give all
available memory o CMA, because it will have negative impact on kernel
operation (kernel really needs to allocate unmovable pages from time to
time). 

The only solution I see now is to provide Kconfig entry to determine
the size of the global CMA pool, but this still have some issues,
especially for multi-board kernels (each board probably will have
different amount of RAM and different memory-consuming devices
available). It looks that each board startup code still might need to
tweak the size of CMA pool. I can add a kernel command line option for
it, but such solution also will not solve all the cases (afair there
was a discussion about kernel command line parameters for memory 
configuration and the conclusion was that it should be avoided).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
