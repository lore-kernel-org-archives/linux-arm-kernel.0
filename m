From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 19 Aug 2010 18:53:38 +0200
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100819234835Y.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Thu, 19 Aug 2010 23:50:04 +0900")
References: <20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
	<1282213882.22370.360.camel@pasglop>
	<20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m38w42sfvx.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

>> I'd rather have the arch (aka the bus) be able to filter the mask,
>> better than having to deal with multiple masks in the generic code.
>> Besides, in embedded-land, you never know how many busses are stacked
>> before you reach the device, ie, you'd end up having to AND quite a few
>> masks before getting there in some cases.
>
> You mean that you like to permit architectures to modify
> dev->coherent_dma_mask behind a device? If so, I'm against it because
> it means dev->coherent_dma_mask has two meanings. That's confusing.

Well, I think it may be the only really correct solution, and in fact
it's arch-independent.

The coherent_dma_mask would mean one thing: address space shared between
the CPU(s) and the device.
This usually equals device's address space - only because CPU and
bridges next to it have wide (logical) address busses. It's not always
the case, though, and may be not the case on any arch.

We should make sure we got it right (including drivers), since any
reduction of the dma*mask would be irreversible (new masks would be
ANDed with the existing masks).

> I think that having the generic place for bus'
> dma mask would be better rather than architecture specific
> places.

Definitely, if possible. BTW the dmabounce (and equivalent code on other
archs, including probably swiotlb on x86-64) could probably be merged as
well. I don't know the internals very well, though. At least it may be
worth it looking at them.

> Adding a new API to set bus' dma mask would make sense too.

Not sure. Which bus? There could be many :-)
In practice - 64-bit PCIe -> 32-bit PCI -> 24-bit ISA - etc.
Or, like with IXP/PXA - 26-bit PCI -> 32-bit device.

> As long as dev->coherent_dma_mask represents the same thing on every
> architecture, permitting architectures to have the own
> dma_set_coherent_mask() is fine by me.

That would be ideal. Buses work on all archs the same after all.
-- 
Krzysztof Halasa
