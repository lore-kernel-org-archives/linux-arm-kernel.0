From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 16:22:50 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
Message-ID: <20091124162250.GA17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 05:46:02PM +0200, saeed bishara wrote:
> On Mon, Nov 23, 2009 at 7:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Nov 23, 2009 at 05:25:06PM +0200, saeed bishara wrote:
> >> > + ? ? ? if (dir == DMA_FROM_DEVICE) {
> >> > + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> >> > + ? ? ? ? ? ? ? dmac_inv_range(kaddr, kaddr + size);
> >> it's not clear why outer cache invalidated before inner cache, and, I
> >> think that it may be incorrect, how can you be sure that a dirty line
> >> that is in inner cache can't be moved down to outer cache?
> >
> > I think you have a point, but also see Catalin's point. ?When we are
> > invalidating, we have to invalidate the outer caches before the inner
> > caches, otherwise there is a danger that the inner caches could
> > prefetch from the outer between the two operations.
> >
> > I think that the only thing we can do is as my previous version did,
> > and always clean the caches at this point - first the inner and then
> > the outer caches.
>
> this makes sense, if  a specific CPU needs the outer cache to be
> invalidated before the inner one, then that better be done in a
> separate patch as this is a different issue and has nothing to do with
> the speculative prefetch

That will mean redoing most of the patch series, which won't be pretty.

> > Yes, but we need to do this for bidirectional mappings as well (which
> > would've only been cleaned.)
> >
> > What would be useful is if someone could run some tests on the performance
> > impact of this (eg, measuring the DMA performance of a SATA hard drive)
> > and comparing the resulting performance.
> >
> > I _could_ do that, but it would mean taking down my network and running
> > the tests on a fairly old machine.
>
> I want to help with that testing, is there any git tree where I can
> pull the code from?

There isn't, because apparantly under git rules, as soon as I publish it
in git form it must be fixed.  So I'm keeping the stuff private and only
issuing patches on this mailing list.

> > If it does turn out to be a problem, we can change the 'inv_range' and
> > 'clean_range' functions to be 'dev_to_cpu' and 'cpu_to_dev' functions,
> > and push the decisions about what to do at each point down into the
> > per-CPU assembly.
>
> the thing is that the inv_range or dev_to_cpu is called before and
> after the DMA operation.
> and for the systems that doesn't have speculative prefetch, we don't
> that function to be called at all after the DMA operation.

Well, the numbers based on trivial looping tests on Versatile/PB926
(in other words, it's not a real test) are:

--- original ---
Test: Null Function: 108.000ns
Test: Map 4K DMA_FROM_DEVICE: 10393.000ns
Test: Unmap 4K DMA_FROM_DEVICE: 107.000ns 
Test: Map+Unmap 4K DMA_FROM_DEVICE: 10388.999ns
Test: Map 4K DMA_TO_DEVICE: 10374.000ns
Test: Unmap 4K DMA_TO_DEVICE: 106.000ns  
Test: Map+Unmap 4K DMA_TO_DEVICE: 10374.000ns
Test: Map 32K DMA_FROM_DEVICE: 78653.998ns
Test: Unmap 32K DMA_FROM_DEVICE: 106.000ns
Test: Map+Unmap 32K DMA_FROM_DEVICE: 78654.003ns
Test: Map 32K DMA_TO_DEVICE: 78639.984ns
Test: Unmap 32K DMA_TO_DEVICE: 107.000ns
Test: Map+Unmap 32K DMA_TO_DEVICE: 78640.041ns

--- replacement ---
Test: Null Function: 109.000ns
Test: Map 4K DMA_FROM_DEVICE: 10196.000ns
Test: Unmap 4K DMA_FROM_DEVICE: 10185.999ns
Test: Map+Unmap 4K DMA_FROM_DEVICE: 20290.999ns
Test: Map 4K DMA_TO_DEVICE: 10164.000ns
Test: Unmap 4K DMA_TO_DEVICE: 327.000ns
Test: Map+Unmap 4K DMA_TO_DEVICE: 10454.000ns
Test: Map 32K DMA_FROM_DEVICE: 78457.995ns
Test: Unmap 32K DMA_FROM_DEVICE: 78473.016ns  
Test: Map+Unmap 32K DMA_FROM_DEVICE: 156819.917ns
Test: Map 32K DMA_TO_DEVICE: 78454.342ns
Test: Unmap 32K DMA_TO_DEVICE: 325.995ns
Test: Map+Unmap 32K DMA_TO_DEVICE: 78715.267ns

which shows minimal impact for the DMA_TO_DEVICE case, but a major impact
on the DMA_FROM_DEVICE case, which I don't think we can live with.

So I think it's time to re-think this.
