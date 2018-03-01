From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 01 Mar 2018 19:14:10 +0800
Subject: [RESEND PATCH v6 14/14] iommu/rockchip: Support sharing IOMMU
 between masters
In-Reply-To: <44efebd3-ab48-4e12-cf92-66b6563f7644@arm.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-15-jeffy.chen@rock-chips.com>
 <44efebd3-ab48-4e12-cf92-66b6563f7644@arm.com>
Message-ID: <5A97E082.3020109@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 03/01/2018 07:03 PM, Robin Murphy wrote:
>>
>> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
>> +{
>> +    struct rk_iommu *iommu;
>> +
>> +    iommu = rk_iommu_from_dev(dev);
>> +
>> +    return iommu->group;
>
> Oops, seems I overlooked this in my previous review - it should really be:
>
>      return iommu_group_get(iommu->group);
>
> or the refcounting will be unbalanced on those future systems where it
> really will be called more than once.
>
hmmm, right, it should be return iommu_group_ref_get(iommu->group);

i was following omap iommu:
static struct iommu_group *omap_iommu_device_group(struct device *dev)
{
         struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
         struct iommu_group *group = ERR_PTR(-EINVAL);

         if (arch_data->iommu_dev)
                 group = arch_data->iommu_dev->group;

         return group;
}

will fix it too in the version.

> Robin.
