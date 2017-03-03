From: labbott@redhat.com (Laura Abbott)
Date: Fri, 3 Mar 2017 10:41:25 -0800
Subject: [RFC PATCH 03/12] staging: android: ion: Duplicate sg_table
In-Reply-To: <07df01d293f6$bcfb4f30$36f1ed90$@alibaba-inc.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-4-git-send-email-labbott@redhat.com>
 <07df01d293f6$bcfb4f30$36f1ed90$@alibaba-inc.com>
Message-ID: <59f69b1b-0a10-01e9-3e64-387d8f123674@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 12:18 AM, Hillf Danton wrote:
> 
> On March 03, 2017 5:45 AM Laura Abbott wrote: 
>>
>> +static struct sg_table *dup_sg_table(struct sg_table *table)
>> +{
>> +	struct sg_table *new_table;
>> +	int ret, i;
>> +	struct scatterlist *sg, *new_sg;
>> +
>> +	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
>> +	if (!new_table)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
>> +	if (ret) {
>> +		kfree(table);
> 
> Free new table?
> 
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	new_sg = new_table->sgl;
>> +	for_each_sg(table->sgl, sg, table->nents, i) {
>> +		memcpy(new_sg, sg, sizeof(*sg));
>> +		sg->dma_address = 0;
>> +		new_sg = sg_next(new_sg);
>> +	}
>> +
> 
> Do we need a helper, sg_copy_table(dst_table, src_table)?
> 
>> +	return new_table;
>> +}
>> +

Yes, that would probably be good since I've seen this
code elsewhere.

Thanks,
Laura
