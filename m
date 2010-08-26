From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 26 Aug 2010 20:55:09 +0900
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <1282254713.22370.368.camel@pasglop>
References: <1282213882.22370.360.camel@pasglop>
	<20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
	<1282254713.22370.368.camel@pasglop>
Message-ID: <20100826205344E.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Aug 2010 07:51:52 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2010-08-19 at 23:50 +0900, FUJITA Tomonori wrote:
> > 
> > You mean that you like to permit architectures to modify
> > dev->coherent_dma_mask behind a device? If so, I'm against it because
> > it means dev->coherent_dma_mask has two meanings. That's confusing.
> 
> No it's not. It has one and only one meaning which is the mask defining
> where the coherent memory can come from for that device. Nobody cares if
> the device can do more and has been "clipped" at set_coherent_dma_mask()
> time by the bus. This is not useful information.

Ok.

I've seen that someone submitted a patch to print the dma_mask under
sysfs, I supposed, for debugging to check if a driver misuses the DMA
API or the bus can't do 64bit DMA when the device can support 64bit
DMA but only gets a buffer under 32bit.

But yeah, we can live withtout it.

Lots of drivers call dma_set_coherent_mask with 64bit mask and then
call it with 32bit mask if 64bit mask fails. So we don't have driver's
coherent mask anyway.


> So I beleive the arch should hook the later and modify the mask as it
> gets applied -once-.

OK. like dma_set_mask(), we could make every architecutre have the own
dma_set_coherent_mask(). But looks like only ARM needs own
dma_set_coherent_mask() (at least now), so adding
ARCH_HAS_DMA_SET_COHERENT_MASK define might be better. I don't like
the asymmetry of dma_set_mask and dma_set_coherent_mask much though.
