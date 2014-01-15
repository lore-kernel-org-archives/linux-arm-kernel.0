From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 15 Jan 2014 18:12:37 +0100
Subject: [PATCH 1/7] iommu/omap: Do bus_set_iommu() only if probe()
 succeeds
In-Reply-To: <52B8C8C1.8080101@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-2-git-send-email-florian.vaussard@epfl.ch>
 <52B888C2.8040303@ti.com> <52B8A5F8.3000706@epfl.ch>
 <52B8C8C1.8080101@ti.com>
Message-ID: <52D6C185.2090303@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

So back to this...

On 12/24/2013 12:35 AM, Anna, Suman wrote:
> Hi Florian,
> 

[...]

>>
>> If omap_iommu_probe() fails, the init will have called bus_set_iommu()
>> anyways. Thus, when a driver request the iommu by calling
>> iommu_domain_alloc(), it will succeed (but iommu_attach_device() will
>> fail if I remember).
> 
> Yeah, thats the behavior I expected anyway.
> 
>> Leaving a driver with a dangling reference to
>> a phantom iommu is not good IMHO. It will lead to strange behaviours
>> one day or another.
>>
>> As for the multiple iommu case, as I do not think it is currently
>> possible, as bus_type (in this case &platform_bus_type) has only
>> one struct iommu_ops. bus_set_iommu() will return EBUSY on the
>> second call. Am I missing something?
> 
> What I meant was the problem you cited will still exist, say if ISP MMU
> probe failed, but the IVA MMU probe succeeded. The bus_set_iommu() can
> only be called once anyway, so moving it from init to probe would not
> help much.
> 

Ok I see your point. Similar IPs share the same ops, but with different
omap_iommu_arch_data, even if currently we only have one registered
IOMMU for OMAP3.

So I will drop this patch.

Regards,
Florian
