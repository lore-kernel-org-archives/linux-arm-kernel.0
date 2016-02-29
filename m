From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Feb 2016 13:30:58 +0000
Subject: [PATCH 0/2] arm64, cma, gicv3-its: Use CMA for allocation of
 large device tables
In-Reply-To: <20160229122511.GS24726@rric.localdomain>
References: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
 <56D42199.7040207@arm.com> <20160229122511.GS24726@rric.localdomain>
Message-ID: <56D44812.6000309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/02/16 12:25, Robert Richter wrote:
> On 29.02.16 10:46:49, Marc Zyngier wrote:
>> On 25/02/16 11:02, Robert Richter wrote:
>>> From: Robert Richter <rrichter@cavium.com>
>>>
>>> This series implements the use of CMA for allocation of large device
>>> tables for the arm64 gicv3 interrupt controller.
>>>
>>> There are 2 patches, the first is for early activation of cma, which
>>> needs to be done before interrupt initialization to make it available
>>> to the gicv3. The second implements the use of CMA to allocate
>>> gicv3-its device tables.
>>>
>>> This solves the problem where mem allocation is limited to 4MB. A
>>> previous patch sent to the list to address this that instead increases
>>> FORCE_MAX_ZONEORDER becomes obsolete.
>>
>> I think you're looking at the problem the wrong way. Instead of going
>> through CMA directly, I'd rather go through the normal DMA API
>> (dma_alloc_coherent), which can itself try CMA (should it be enabled).
>>
>> That will give you all the benefit of the CMA allocation, and also make
>> the driver more robust. I meant to do this for a while, and never found
>> the time. Any chance you could have a look?
> 
> I was considering this first, and in fact the backend used is the
> same. The problem is that irq initialization is much more earlier than
> standard device probing. The gic even does not have its own struct
> device and is not initialized like devices are. This makes the whole
> dma_alloc_coherent() approach not feasable, at least this would
> require introducing and using a dev struct for the gic. But still this
> migth not work as it could be too early during boot. I also think
> there were reasons not implementing the gic as a device.
> 
> I was following more the approach of iommu/mmu implementations which
> use dma_alloc_from_contiguous() directly. I think this is more close
> to the device tables for its.
> 
> Code path of dma_alloc_coherent():
> 
>  dma_alloc_coherent()
>     v
>  dma_alloc_attrs()             <---- Requires get_dma_ops(dev) != NULL
>     v
>  dma_alloc_from_coherent()
>     v
>  ...
> 
> The difference it that dma_alloc_coherent() tries cma first and then
> proceeds with ops->alloc() (which is __dma_alloc() for arm64) if
> dma_alloc_from_coherent() fails. In my implementation I am directly
> using dma_alloc_from_coherent() and only for large mem sizes.
> 
> So both approaches uses finally the same allocation, but for gicv3-its
> the generic dma framework is not used since the gic is not implemented
> as a device.

And that's what I propose we change.

The core GIC itself indeed isn't a device, and I'm not proposing we make
it a device (yet). But the ITS is only used much later in the game, and
we could move the table allocation to a different time (when the actual
domains are allocated, for example...). Then, we'd have a set of devices
available, and the DMA API is our friend again.

	M.
-- 
Jazz is not dead. It just smells funny...
