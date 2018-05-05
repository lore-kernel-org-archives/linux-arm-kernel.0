From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Sat, 5 May 2018 10:56:03 +0100
Subject: [PATCH v2 03/27] coresight: Add helper device type
In-Reply-To: <20180503170040.GA11425@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-4-git-send-email-suzuki.poulose@arm.com>
 <20180503170040.GA11425@xps15>
Message-ID: <86778b1b-cd08-629a-b56c-20549d9d7299@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2018 06:00 PM, Mathieu Poirier wrote:

...

>> +/*
>> + * coresight_release_device - Release this device and any of the helper
>> + * devices connected to it for trace operation.
>> + */
>> +static void coresight_release_device(struct coresight_device *csdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < csdev->nr_outport; i++) {
>> +		struct coresight_device *child = csdev->conns[i].child_dev;
>> +
>> +		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>> +			pm_runtime_put(child->dev.parent);
>> +	}
> 
> There is a newline here in coresight_prepare_device().  Either add one (or not)
> in both function but please be consistent.
> 

>> @@ -480,8 +517,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>>   
>>   	node->csdev = csdev;
>>   	list_add(&node->link, path);
>> -	pm_runtime_get_sync(csdev->dev.parent);
>> -
>> +	coresight_prepare_device(csdev);
> 
> There was a newline between pm_runtime_get_sync() and the return statement in
> the original code.
> 


>> @@ -775,6 +811,10 @@ static struct device_type coresight_dev_type[] = {
>>   		.name = "source",
>>   		.groups = coresight_source_groups,
>>   	},
>> +	{
>> +		.name = "helper",
>> +	},
>> +
> 
> Extra newline.
> 

>>   };   
>> +/**
>> + * struct coresight_ops_helper - Operations for a helper device.
>> + *
>> + * All operations could pass in a device specific data, which could
>> + * help the helper device to determine what to do.
>> + *
>> + * @enable	: Turn the device ON.
>> + * @disable	: Turn the device OFF.
> 
> There is a discrepancy between the comment and the operations, i.e enabling a
> device is not synonymous of turning it on.  Looking at patch 04/27 the ops is
> called in tmc_etr_enable/disable_catu() so the comment propably needs to be
> changed.

Sure, will fix all of them.

Cheers
Suzuki
