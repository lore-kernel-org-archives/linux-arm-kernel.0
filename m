From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Feb 2016 16:23:53 +0100
Subject: [PATCH 2/2] ARM: dma-mapping: fix alloc/free for coherent + CMA
 + gfp=0
In-Reply-To: <20160219140600.GW19428@n2100.arm.linux.org.uk>
References: <1455869524-13874-1-git-send-email-rabin.vincent@axis.com>
 <1455869524-13874-2-git-send-email-rabin.vincent@axis.com>
 <20160219140600.GW19428@n2100.arm.linux.org.uk>
Message-ID: <20160223152353.GA22447@lnxrabinv.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 02:06:00PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 19, 2016 at 09:12:04AM +0100, Rabin Vincent wrote:
> > Given a device which uses arm_coherent_dma_ops and on which
> > dev_get_cma_area(dev) returns non-NULL, the following usage of the DMA
> > API with gfp=0 results in a memory leak and memory corruption.
> > 
> >  p = dma_alloc_coherent(dev, sz, &dma, 0);
> >  if (p)
> >  	dma_free_coherent(dev, sz, p, dma);
> > 
> > The memory leak is because the alloc allocates using
> > __alloc_simple_buffer() but the free attempts
> > dma_release_from_contiguous(), which does not do free anything since the
> > page is not in the CMA area.
> 
> I'd really like to see a better solution to this problem: over the course
> of the years, I've seen a number of patches that rearrange the test order
> at allocation time because of some problem or the other.
> 
> What we need is a better way to ensure that we use the correct release
> functionality - having two independent set of tests where the order
> matters is really not very good.

I've sent a v2 of this series which refactors the code so that we no
longer have two independent sets of tests.
