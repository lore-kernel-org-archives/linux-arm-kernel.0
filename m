From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 1 Aug 2011 09:57:46 +0900
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <004201cc4dfb$47ee4770$d7cad650$%szyprowski@samsung.com>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<20110729093555.GA13522@8bytes.org>
	<001901cc4dd8$4afb4e40$e0f1eac0$%szyprowski@samsung.com>
	<20110729105422.GB13522@8bytes.org>
	<004201cc4dfb$47ee4770$d7cad650$%szyprowski@samsung.com>
Message-ID: <CAHQjnOM58AReFuDpcSjHvNP2UZX1ZUeuWyfWCG6Ayxdfj4QE7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Fri, Jul 29, 2011 at 11:24 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Friday, July 29, 2011 12:54 PM Joerg Roedel wrote:
>
>> On Fri, Jul 29, 2011 at 12:14:25PM +0200, Marek Szyprowski wrote:
>> > > This sounds rather hacky. How about partitioning the address space for
>> > > the device and give the dma-api only a part of it. The other parts can
>> > > be directly mapped using the iommu-api then.
>> >
>> > Well, I'm not convinced that iommu-api should be used by the device drivers
>> > directly. If possible we should rather extend dma-mapping than use such
> hacks.
>>
>> Building this into dma-api would turn it into an iommu-api. The line
>> between the apis are clear. The iommu-api provides direct mapping
>> of bus-addresses to system-addresses while the dma-api puts a memory
>> manager on-top which deals with bus-address allocation itself.
>> So if you want to map bus-addresses directly the iommu-api is the way to
>> go. This is in no way a hack.
>
> The problem starts when you want to use the same driver on two different
> systems:
> one with iommu and one without. Our driver depends only on dma-mapping and the
> fact
> that the first allocation starts from the right address. On systems without
> iommu,
> board code calls bootmem_reserve() and dma_declare_coherent() for the required
> memory range. Systems with IOMMU just sets up device io address space to start
> at the specified address. This works fine, because in our system each device has
> its own, private iommu controller and private address space.
>
> Right now I have no idea how to handle this better. Perhaps with should be
> possible
> to specify somehow the target dma_address when doing memory allocation, but I'm
> not
> really convinced yet if this is really required.
>
What about using 'dma_handle' argument of alloc_coherent callback of
dma_map_ops?
Although it is an output argument, I think we can convey a hint or
start address to map
to the IO memory manager that resides behind dma API.
Of course, it is unable to map a specific physical address with the
dma address with the idea.
I think the problem can be solved for some application
with overriding alloc_coherent callback in the machine initialization code.
Still the above idea cannot answer when a physical address is needed
to be mapped
to a specific dma address with 'dma_map_*()'.

DMA API is so abstract that it cannot cover all requirements by
various device drivers;;

Regards,
Cho KyongHo.
