From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 28 Feb 2018 16:22:13 +0000
Subject: [PATCH 16/37] iommu: Add generic PASID table library
In-Reply-To: <20180227105121.7c6e1110@jacob-builder>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-17-jean-philippe.brucker@arm.com>
 <20180227105121.7c6e1110@jacob-builder>
Message-ID: <0779f165-d750-f375-41cb-90663ead9300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/18 18:51, Jacob Pan wrote:
[...]
>> +struct iommu_pasid_table_ops *
>> +iommu_alloc_pasid_ops(enum iommu_pasid_table_fmt fmt,
>> +		      struct iommu_pasid_table_cfg *cfg, void
>> *cookie) +{
> I guess you don't need to pass in cookie here.

The cookie is stored in the table driver and passed back to the IOMMU
driver when invalidating a PASID table entry

>> +	struct iommu_pasid_table *table;
>> +	const struct iommu_pasid_init_fns *fns;
>> +
>> +	if (fmt >= PASID_TABLE_NUM_FMTS)
>> +		return NULL;
>> +
>> +	fns = pasid_table_init_fns[fmt];
>> +	if (!fns)
>> +		return NULL;
>> +
>> +	table = fns->alloc(cfg, cookie);
>> +	if (!table)
>> +		return NULL;
>> +
>> +	table->fmt = fmt;
>> +	table->cookie = cookie;
>> +	table->cfg = *cfg;
>> +
> the ops is already IOMMU model specific, why do you need to pass cfg
> back?

The table driver needs some config information at runtime. Callbacks such
as iommu_pasid_table_ops::alloc_shared_entry() receive the
iommu_pasid_table_ops instance as argument. They can then get the
iommu_pasid_table structure with container_of() and retrieve the config
stored in table->cfg.

>> +	return &table->ops;
> If there is no common code that uses these ops, I don't see the benefit
> of having these APIs. Or the plan is to consolidate even further such
> that referene to pasid table can be attached at per iommu_domain etc,
> but that would be model specific choice.

I don't plan to consolidate further. This API is for multiple IOMMU
drivers with different transports implementing the same PASID table
formats. For example my vSVA implementation uses this API in virtio-iommu
for assigning PASID tables to the guest (All fairly experimental at this
point. I initially intended to assign just the page directories, but
passing the whole PASID table seemed more popular.)

In the future there might be other vendor IOMMUs implementing the same
PASID table formats, just like there are currently 6 IOMMU drivers using
the page-table code implemented by the io-pgtable.c lib (which I copied in
this patch).

Thanks,
Jean
