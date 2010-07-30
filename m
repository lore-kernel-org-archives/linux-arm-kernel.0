From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Fri, 30 Jul 2010 09:25:48 -0700 (PDT)
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007301001.02509.arnd@arndb.de>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<d493494df33aaf65e526181b1dbafce3.squirrel@www.codeaurora.org>
	<201007301001.02509.arnd@arndb.de>
Message-ID: <3faa32ace3110e9d1e51ef9735287de1.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Friday 30 July 2010 07:19:06 stepanm at codeaurora.org wrote:
>> Unlike a more traditional system with one IOMMU between the bus and
>> memory, MSM has multiple IOMMUs, with each one hard-wired to a dedicated
>> device. Furthermore, each IOMMU can have more than one translation
>> context. One of the use cases is being able to create mappings within
>> multiple instances of one context, and arbitrarily context-switch the
>> IOMMU on the fly.
>>
>> It sounds like the domain abstraction and attach_device/detach_device
>> can
>> encapsulate this rather nicely and I am in the process of updating my
>> driver to fit this framework.
>>
>> My problem, however, is with iommu_domain_alloc(). This will set up a
>> domain and call the ops function to initialize it, but I want to be able
>> to pass it an ???IOMMU id" that will tell the underlying driver which
>> IOMMU
>> (and which "stream id") is to be associated with that domain instance.
>
> This probably best fits into the device itself, so you can assign the
> iommu data when probing the bus, e.g. (I don't know what bus you use)
>
> struct msm_device {
> 	struct msm_iommu *iommu;
> 	struct device dev;
> };
>
> This will work both for device drivers using the DMA API and for KVM
> with the IOMMU API.


Right, this makes sense, and that is similar to how we were planning to
set the iommus for the devices. But my question is, how does the IOMMU API
know *which* IOMMU to talk to? It seems like this API has been designed
with a singular IOMMU in mind, and it is implied that things like
iommu_domain_alloc, iommu_map, etc all use "the" IOMMU. But I would like
to allocate a domain and specify which IOMMU it is to be used for.

I can think of solving this in several ways.
One way would be to modify iommu_domain_alloc to take an IOMMU parameter,
which gets passed into domain_init. This seems like the cleanest solution.
Another way would be to have something like msm_iommu_domain_bind(domain,
iommu) which would need to be called after iommu_domain_alloc to set the
domain binding.
A third way that I could see is to delay the domain/iommu binding until
iommu_attach_device, where the iommu could be picked up from the device
that is passed in. I am not certain of this approach, since I had not been
planning to pass in full devices, as in the MSM case this makes little
sense (that is, if I am understanding the API correctly). On MSM, each
device already has a dedicated IOMMU hard-wired to it. I had been planning
to use iommu_attach_device to switch between active domains on a specific
IOMMU and the given device would be of little use because that association
is implicit on MSM.

Does that make sense? Am I correctly understanding the API? What do you
think would be a good way to handle the multiple-iommu case?

Thanks
Steve
