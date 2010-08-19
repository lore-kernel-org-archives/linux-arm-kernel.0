From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 20 Aug 2010 07:51:52 +1000
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
References: <20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
	<1282213882.22370.360.camel@pasglop>
	<20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1282254713.22370.368.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-19 at 23:50 +0900, FUJITA Tomonori wrote:
> 
> You mean that you like to permit architectures to modify
> dev->coherent_dma_mask behind a device? If so, I'm against it because
> it means dev->coherent_dma_mask has two meanings. That's confusing.

No it's not. It has one and only one meaning which is the mask defining
where the coherent memory can come from for that device. Nobody cares if
the device can do more and has been "clipped" at set_coherent_dma_mask()
time by the bus. This is not useful information.

So I beleive the arch should hook the later and modify the mask as it
gets applied -once-.

> I don't plan to have the generic code to deal with multiple masks. I
> thought about simply moving max_direct_dma_addr in POWERPC's
> dev_archdata to a generic place (possibly, struct
> device_dma_parameters). I think that having the generic place for bus'
> dma mask would be better rather than architecture specific
> places. Adding a new API to set bus' dma mask would make sense too.

Well, max_direct_dma_addr used on powerpc is a bit nasty because it
doesn't necessarily represent a power of 2, so a mask is no good here
indeed.

> > Besides, in embedded-land, you never know how many busses are
> stacked
> > before you reach the device, ie, you'd end up having to AND quite a
> > few masks before getting there in some cases.
> >
> > Sounds better to establish that once, at set_coherent_dma_mask()
> time.
> 
> As long as dev->coherent_dma_mask represents the same thing on every
> architecture, permitting architectures to have the own
> dma_set_coherent_mask() is fine by me. I like to avoid it if possible
> though.

Ben.
