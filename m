From: ccross@google.com (Colin Cross)
Date: Wed, 17 Mar 2010 14:26:32 -0700
Subject: mapping uncached memory
In-Reply-To: <20100317081520.GA15954@n2100.arm.linux.org.uk>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
	<20100316235422.GC13948@n2100.arm.linux.org.uk>
	<57314e841003170102y2b2634f1na9c18282f344d3c2@mail.gmail.com>
	<20100317081520.GA15954@n2100.arm.linux.org.uk>
Message-ID: <d73d4eaf1003171426y35f9c431l93182fa73b3a5084@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 1:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 17, 2010 at 10:02:09AM +0200, Budhee Jamaich wrote:
>> On Wed, Mar 17, 2010 at 1:54 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> from Documentation/DMA-API.txt:
>>
>> "void *
>> dma_alloc_coherent(struct device *dev, size_t size,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dma_addr_t *dma_handle, gfp_t flag)
>>
>> Consistent memory is memory for which a write by either the device or
>> the processor can immediately be read by the processor or device
>> without having to worry about caching effects. ?(You may however need
>> to make sure to flush the processor's write buffers before telling
>> devices to read that memory.)"
>>
>>
>>
>> That last sentence - what does it really say ? That I still need to
>> manually clean/invalidate the caches myself ?
>
> No - if it did, it would contradict the previous sentence. ?What it's
> referring to is that on weakly ordered CPUs, you may need barriers.

Tegra2 needs a wmb() and an L2 cache sync on dma_alloc_coherent memory
before handing it to the device.  Currently, I am using Catalin's
patches for machine-specific wmb() implementations to do both
operations using a wmb() and keep the L2 details out of the drivers.
Is that the correct use of those patches?  Is there any other way to
handle dma_alloc_coherent memory on ARMv7?
