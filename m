From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Fri, 30 Jul 2010 15:58:00 -0700 (PDT)
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007302359.08188.arnd@arndb.de>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007301001.02509.arnd@arndb.de>
	<3faa32ace3110e9d1e51ef9735287de1.squirrel@www.codeaurora.org>
	<201007302359.08188.arnd@arndb.de>
Message-ID: <2d92bd7e819dd81e2f64d358918711d3.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Friday 30 July 2010 18:25:48 stepanm at codeaurora.org wrote:
>
>> > This probably best fits into the device itself, so you can assign the
>> > iommu data when probing the bus, e.g. (I don't know what bus you use)
>> >
>> > struct msm_device {
>> > 	struct msm_iommu *iommu;
>> > 	struct device dev;
>> > };
>> >
>> > This will work both for device drivers using the DMA API and for KVM
>> > with the IOMMU API.
>>
>>
>> Right, this makes sense, and that is similar to how we were planning to
>> set the iommus for the devices. But my question is, how does the IOMMU
>> API
>> know *which* IOMMU to talk to? It seems like this API has been designed
>> with a singular IOMMU in mind, and it is implied that things like
>> iommu_domain_alloc, iommu_map, etc all use "the" IOMMU.
>
> The primary key is always the device pointer. If you look e.g. at
> arch/powerpc/include/asm/dma-mapping.h, you find
>
> static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> {
>         return dev->archdata.dma_ops;
> }
>
> From there, you know the type of the iommu, each of which has its
> own dma_ops pointer. The dma_ops->map_sg() referenced there is
> specific to one (or a fixed small number of) bus_type, e.g. PCI
> or in your case an MSM specific SoC bus, so it can cast the device
> to the bus specific data structure:
>
> int msm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>                 enum dma_data_direction dir)
> {
> 	struct msm_device *dev = container_of(dev, struct msm_device, dev);
>
> 	...
> }
>
>> But I would like
>> to allocate a domain and specify which IOMMU it is to be used for.
>> I can think of solving this in several ways.
>> One way would be to modify iommu_domain_alloc to take an IOMMU
>> parameter,
>> which gets passed into domain_init. This seems like the cleanest
>> solution.
>> Another way would be to have something like
>> msm_iommu_domain_bind(domain,
>> iommu) which would need to be called after iommu_domain_alloc to set the
>> domain binding.
>
> The iommu_domain is currently a concept that is only used in KVM, and
> there
> a domain currently would always span all of the IOMMUs that can host
> virtualized devices. I'm not sure what you want to do with domains though.
> Are you implementing KVM or another hypervisor, or is there another use
> case?
>
> I've seen discussions about using an IOMMU to share page tables with
> regular processes so that user space can program a device to do DMA into
> its own address space, which would require an IOMMU domain per process
> using the device.
>
> However, most of the time, it is better to change the programming model
> of those devices to do the mapping inside of a kernel device driver
> that allocates a physical memory area and maps it into both the BUS
> address space (using dma_map_{sg,single}) and the user address space
> (using mmap()).
>
>> A third way that I could see is to delay the domain/iommu binding until
>> iommu_attach_device, where the iommu could be picked up from the device
>> that is passed in. I am not certain of this approach, since I had not
>> been
>> planning to pass in full devices, as in the MSM case this makes little
>> sense (that is, if I am understanding the API correctly). On MSM, each
>> device already has a dedicated IOMMU hard-wired to it. I had been
>> planning
>> to use iommu_attach_device to switch between active domains on a
>> specific
>> IOMMU and the given device would be of little use because that
>> association
>> is implicit on MSM.
>>
>> Does that make sense? Am I correctly understanding the API? What do you
>> think would be a good way to handle the multiple-iommu case?
>
> My impression is that you are confusing the multi-IOMMU and the
> multi-domain
> problem, which are orthogonal. The dma-mapping API can deal with multiple
> IOMMUs as I described above, but has no concept of domains. KVM uses the
> iommu.h API to get one domain per guest OS, but as you said, it does not
> have a concept of multiple IOMMUs because neither Intel nor AMD require
> that
> today.
>
> If you really need multiple domains across multiple IOMMUs, I'd suggest
> that
> we first merge the APIs and then port your code to that, but as a first
> step
> you could implement the standard dma-mapping.h API, which allows you to
> use
> the IOMMUs in kernel space.

One of our uses cases actually does involve using domains pretty much as
you had described them, though only on one of the IOMMUs. That is, the
domain for that IOMMU basically abstracts its page table, and it is a
legitimate thing to switch out page tables for the IOMMU on the fly. I
guess the difference is that you described the domain as the set of
mappings made on ALL the IOMMUs, whereas I had envisioned there being one
(or more) domains for each IOMMU.
