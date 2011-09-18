From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 18 Sep 2011 10:40:37 +0200
Subject: [PATCH 0/19] removal of mach/vmalloc.h and generic optimizations
In-Reply-To: <alpine.LFD.2.00.1109172238070.20358@xanadu.home>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<3319383.WZQsqr8ND4@wuerfel>
	<alpine.LFD.2.00.1109172238070.20358@xanadu.home>
Message-ID: <1933895.GJBlYra9yP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011 22:46:33 Nicolas Pitre wrote:
> On Sat, 17 Sep 2011, Arnd Bergmann wrote:
> 
> > On Friday 16 September 2011 03:07:11 Nicolas Pitre wrote:
> > > This patch series removes all instances of mach/vmalloc.h in order to
> > > have a more unified memory map across all ARM architectures.  To do so,
> > > the static mappings are moved inside the vmalloc area.  And finally this
> > > allows for a generic optimization to ioremap where static mappings are
> > > reused whenever possible, using common code instead of having this
> > > duplicated in a couple places.
> > > 
> > > This also provides a net reduction of more than 1200 lines of code.

> 
> > Doing some randconfig tests, I noticed that your series is currently broken
> > on shmobile, which triggers a 
> > 
> > 	BUILD_BUG_ON(VMALLOC_END > CONSISTENT_BASE);
> > 
> > in mem_init(), because the platform has a CONSISTENT_DMA_SIZE of 158MB.
> > All other platforms have a CONSISTENT_DMA_SIZE of at most 14MB, which
> > works correctly.
> 
> Any idea why shmobile requires such an amount of consistent memory?

No, I couldn't find anything in the code or the changelog why this was
done. Magnus changed it in this commit:

commit 28f0721a79046056ced3b9bd79c319c5c417ec30
Author: Magnus Damm <damm@opensource.se>
Date:   Wed Apr 28 08:25:30 2010 +0000

    ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
    
    This patch sets CONSISTENT_DMA_SIZE to 158 MB
    for all SH-Mobile ARM processors.
    
    The DMA area is mapped at 0xf6000000 - 0xffdfffff,
    on top of the 256 MB I/O window at 0xe6000000.
    
    Signed-off-by: Magnus Damm <damm@opensource.se>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Maybe he can give a better explanation and can say whether it's
actually required. The patch series introducing it contained
the introduction of the shdma dmaengine driver and some changes
to video drivers, but I could not tell how they are related
to this change.

> > My feeling is that a 158MB CONSISTENT_DMA_SIZE causes other problems
> > anyway because we cannot map regular RAM both cached and uncached,
> > but this is still a regression. The problem might be solved using
> > Marek's CMA patches, which should eliminate the need for a huge
> > CONSISTENT_DMA_SIZE.
> 
> Maybe.  However I don't want for this series to depend on CMA.  I'll 
> find some temporary hack in the mean time.

Ok

	Arnd
