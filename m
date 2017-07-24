From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 24 Jul 2017 10:55:53 +0100
Subject: [PATCH 1/4] iommu/msm: Add iommu_group support
In-Reply-To: <f5071164-c965-b6bf-c330-90ff6ea0c956@codeaurora.org>
References: <cover.1500637633.git.robin.murphy@arm.com>
 <b87d44e09fa18efbb9daf6258c1f8ecbedaac23c.1500637633.git.robin.murphy@arm.com>
 <f5071164-c965-b6bf-c330-90ff6ea0c956@codeaurora.org>
Message-ID: <e148ac58-2fda-454f-c8b1-e01dd1c1347c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/17 08:34, Sricharan R wrote:
> Hi Robin,
> 
>> As the last step to making groups mandatory, clean up the remaining
>> drivers by adding basic support. Whilst it may not perfectly reflect the
>> isolation capabilities of the hardware, using generic_device_group()
>> should at least maintain existing behaviour with respect to the API.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/iommu/msm_iommu.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>> index d0448353d501..04f4d51ffacb 100644
>> --- a/drivers/iommu/msm_iommu.c
>> +++ b/drivers/iommu/msm_iommu.c
>> @@ -393,6 +393,7 @@ static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
>>  static int msm_iommu_add_device(struct device *dev)
>>  {
>>  	struct msm_iommu_dev *iommu;
>> +	struct iommu_group *group;
>>  	unsigned long flags;
>>  	int ret = 0;
>>  
>> @@ -406,7 +407,16 @@ static int msm_iommu_add_device(struct device *dev)
>>  
>>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>>  
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	group = iommu_group_get_for_dev(dev);
>> +	if (IS_ERR(group))
>> +		return PTR_ERR(group);
>> +
>> +	iommu_group_put(group);
>> +
>> +	return 0;
>>  }
>>  
> 
>  While this is correct for completing the group support, this adds the default domain and
>  that might break in the driver while attaching a private domain. The msm_iomm_attach_dev
>  needs to be fixed by calling msm_iommu_detach_dev while trying to attach a new domain when
>  already connected to a default one. But let me test and confirm this.

The default domain shouldn't matter, since msm_iommu_domain_alloc() will
refuse to create DMA ops or identity domains in the first place. In the
absence of a default domain, __iommu_detach_group() will still end up
calling ops->detach_dev, so I don't think the ultimate behaviour is any
different with this change. Testing is of course welcome, though ;)

Robin.
