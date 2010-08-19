From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 19 Aug 2010 23:50:04 +0900
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <1282213882.22370.360.camel@pasglop>
References: <20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
	<1282213882.22370.360.camel@pasglop>
Message-ID: <20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Aug 2010 20:31:22 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2010-08-14 at 18:30 +0900, FUJITA Tomonori wrote:
> > 
> > A long solution would be having two dma_mask for a device and a
> > bus. We also need something to represent a DMA-capable range instead
> > of the dma mask.
> 
> I'd rather have the arch (aka the bus) be able to filter the mask,
> better than having to deal with multiple masks in the generic code.
> Besides, in embedded-land, you never know how many busses are stacked
> before you reach the device, ie, you'd end up having to AND quite a few
> masks before getting there in some cases.

You mean that you like to permit architectures to modify
dev->coherent_dma_mask behind a device? If so, I'm against it because
it means dev->coherent_dma_mask has two meanings. That's confusing.

I don't plan to have the generic code to deal with multiple masks. I
thought about simply moving max_direct_dma_addr in POWERPC's
dev_archdata to a generic place (possibly, struct
device_dma_parameters). I think that having the generic place for bus'
dma mask would be better rather than architecture specific
places. Adding a new API to set bus' dma mask would make sense too.


> Besides, in embedded-land, you never know how many busses are stacked
> before you reach the device, ie, you'd end up having to AND quite a
> few masks before getting there in some cases.
>
> Sounds better to establish that once, at set_coherent_dma_mask() time.

As long as dev->coherent_dma_mask represents the same thing on every
architecture, permitting architectures to have the own
dma_set_coherent_mask() is fine by me. I like to avoid it if possible
though.
