From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 17 Oct 2016 16:25:36 +0200
Subject: [PATCH v14 04/16] iommu/dma: MSI doorbell alloc/free
In-Reply-To: <87lgxrqijs.fsf@e105922-lin.cambridge.arm.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
 <1476278544-3397-5-git-send-email-eric.auger@redhat.com>
 <87lgxrqijs.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <422b6060-3c58-0bd3-b0ee-78803b5da7fc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 14/10/2016 13:25, Punit Agrawal wrote:
> Hi Eric,
> 
> One query and a comment below.
> 
> Eric Auger <eric.auger@redhat.com> writes:
> 
>> We introduce the capability to (un)register MSI doorbells.
>>
>> A doorbell region is characterized by its physical address base, size,
>> and whether it its safe (ie. it implements IRQ remapping). A doorbell
>> can be per-cpu or global. We currently only care about global doorbells.
>>
>> A function returns whether all registered doorbells are safe.
>>
>> MSI controllers likely to work along with IOMMU that translate MSI
>> transaction must register their doorbells to allow device assignment
>> with MSI support.  Otherwise the MSI transactions will cause IOMMU faults.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v13 -> v14:
>> - previously in msi-doorbell.h/c
>> ---
>>  drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/dma-iommu.h | 41 ++++++++++++++++++++++++++
>>  2 files changed, 116 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d45f9a0..d8a7d86 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -43,6 +43,38 @@ struct iommu_dma_cookie {
>>  	spinlock_t		msi_lock;
>>  };
>>  
>> +/**
>> + * struct iommu_msi_doorbell_info - MSI doorbell region descriptor
>> + * @percpu_doorbells: per cpu doorbell base address
>> + * @global_doorbell: base address of the doorbell
>> + * @doorbell_is_percpu: is the doorbell per cpu or global?
>> + * @safe: true if irq remapping is implemented
>> + * @size: size of the doorbell
>> + */
>> +struct iommu_msi_doorbell_info {
>> +	union {
>> +		phys_addr_t __percpu    *percpu_doorbells;
> 
> Out of curiosity, have you come across systems that have per-cpu
> doorbells? I couldn't find a system that'd help solidify my
> understanding on it's usage.

This came out after a discussion With Marc. However at the moment I am
not aware of any MSI controller featuring per-cpu doorbell. Not sure
whether it stays relevant to keep this notion at that stage.

> 
>> +		phys_addr_t             global_doorbell;
>> +	};
>> +	bool    doorbell_is_percpu;
>> +	bool    safe;
> 
> Although you've got the comment above, 'safe' doesn't quite convey it's
> purpose. Can this be renamed to something more descriptive -
> 'intr_remapping' or 'intr_isolation' perhaps?

Yes definitively

Thanks

Eric
> 
> Thanks,
> Punit
> 
> 
> [...]
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
