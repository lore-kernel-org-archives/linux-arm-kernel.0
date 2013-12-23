From: s-anna@ti.com (Anna, Suman)
Date: Mon, 23 Dec 2013 17:35:29 -0600
Subject: [PATCH 1/7] iommu/omap: Do bus_set_iommu() only if probe()
 succeeds
In-Reply-To: <52B8A5F8.3000706@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-2-git-send-email-florian.vaussard@epfl.ch>
 <52B888C2.8040303@ti.com> <52B8A5F8.3000706@epfl.ch>
Message-ID: <52B8C8C1.8080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

>>
>> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>>> Currently, bus_set_iommu() is done in omap_iommu_init(). However,
>>> omap_iommu_probe() can fail in a number of ways, leaving the platform
>>> bus with a dangling reference to a non-initialized iommu. Perform
>>> bus_set_iommu() only if omap_iommu_probe() succeed.
>>
>> Can you clarify a bit more on what kind of issues you were seeing
>> specifically? In general, there can be multiple instances of the iommu,
>> so setting it in probe may not be fixing whatever issue you were seeing.
>> The current OMAP3 code has only the ISP MMU enabled, but there is also
>> another one for the IVA MMU (currently not configured by default).
>> Moving the bus_set_iommu to probe makes sense if only one iommu is
>> present, so this patch may not be needed at all.
>>
>
> If omap_iommu_probe() fails, the init will have called bus_set_iommu()
> anyways. Thus, when a driver request the iommu by calling
> iommu_domain_alloc(), it will succeed (but iommu_attach_device() will
> fail if I remember).

Yeah, thats the behavior I expected anyway.

> Leaving a driver with a dangling reference to
> a phantom iommu is not good IMHO. It will lead to strange behaviours
> one day or another.
>
> As for the multiple iommu case, as I do not think it is currently
> possible, as bus_type (in this case &platform_bus_type) has only
> one struct iommu_ops. bus_set_iommu() will return EBUSY on the
> second call. Am I missing something?

What I meant was the problem you cited will still exist, say if ISP MMU 
probe failed, but the IVA MMU probe succeeded. The bus_set_iommu() can 
only be called once anyway, so moving it from init to probe would not 
help much.

regards
Suman

>
>> Also, the main change in this patch is moving the bus_set_iommu from
>> omap_iommu_init to omap_iommu_probe, so you should probably leave out
>> moving the function. The omap_iommu_probe function would anyway need
>> conversion to using devm_ functions.
>>
>
> This was my first try also, but as bus_set_iommu() needs omap_iommu_ops
> (itself depending on several functions), its call must come after the
> declaration of omap_iommu_ops. Thus I moved omap_iommu_probe() after
> the declaration of omap_iommu_ops. But I can probably use a forward
> declaration for omap_iommu_ops, this would be better.
>
> Indeed, we can also convert to devm_.
>
> Regards,
>
> Florian
>
