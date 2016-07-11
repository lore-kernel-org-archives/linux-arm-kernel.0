From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 11 Jul 2016 12:07:34 +0100
Subject: [PATCH v4 5/8] iommu/of: Introduce iommu_fwspec
In-Reply-To: <20160707165631.GB2685@red-moon>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <7947dbaa0e0d4ace8eebe8de1fe5810fe05f7734.1467388950.git.robin.murphy@arm.com>
 <20160707165631.GB2685@red-moon>
Message-ID: <57837DF6.5060504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/16 17:56, Lorenzo Pieralisi wrote:
> On Fri, Jul 01, 2016 at 05:50:14PM +0100, Robin Murphy wrote:
> 
> [...]
> 
>> +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
>> +{
>> +	struct iommu_fwspec *fwspec = dev->archdata.iommu;
>> +	size_t size;
>> +
>> +	if (!fwspec)
>> +		return -EINVAL;
>> +
>> +	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
> 								^^^^
> 
> + num_ids ?

Oops, quite right. Thanks!

Robin.

> Lorenzo
> 
>> +	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
>> +	if (!fwspec)
>> +		return -ENOMEM;
>> +
>> +	while (num_ids--)
>> +		fwspec->ids[fwspec->num_ids++] = *ids++;
>> +
>> +	dev->archdata.iommu = fwspec;
>> +	return 0;
>> +}
>> +
>> +inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
>> +{
>> +	return dev->archdata.iommu;
>> +}
>> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
>> index bd02b44902d0..308791fca32d 100644
>> --- a/include/linux/of_iommu.h
>> +++ b/include/linux/of_iommu.h
>> @@ -15,6 +15,14 @@ extern void of_iommu_init(void);
>>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  					struct device_node *master_np);
>>  
>> +struct iommu_fwspec {
>> +	const struct iommu_ops	*iommu_ops;
>> +	struct device_node	*iommu_np;
>> +	void			*iommu_priv;
>> +	unsigned int		num_ids;
>> +	u32			ids[];
>> +};
>> +
>>  #else
>>  
>>  static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
>> @@ -31,8 +39,15 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  	return NULL;
>>  }
>>  
>> +struct iommu_fwspec;
>> +
>>  #endif	/* CONFIG_OF_IOMMU */
>>  
>> +int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
>> +void iommu_fwspec_free(struct device *dev);
>> +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>> +struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
>> +
>>  void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
>>  const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
>>  
>> -- 
>> 2.8.1.dirty
>>
> 
