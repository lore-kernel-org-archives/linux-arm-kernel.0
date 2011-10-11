From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 11 Oct 2011 11:19:06 +0530
Subject: [PATCH v2 5/5] regulator: map consumer regulator based on device
	tree
In-Reply-To: <20111010173506.GH3607@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-6-git-send-email-rnayak@ti.com>
	<20111010173506.GH3607@opensource.wolfsonmicro.com>
Message-ID: <4E93D8D2.1050703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
>> @@ -1178,6 +1225,10 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>>   			goto found;
>>   		}
>>   	}
>> +	if (!dev)
>> +		list_for_each_entry(rdev,&regulator_list, list)
>> +			if (strcmp(rdev_get_name(rdev), id))
>> +				goto found;
>>
>
> This looks really strange, we didn't remove any old lookup code and the
> DT lookup jumps to found by iself so why are we adding code here?

The old lookup code looks up using the regulator_map_list, and the dt
lookup depends on a dev pointer to extract the of_node.
This above code was needed for cases when a regulator_get() would be
called on dt builds without specifying a device pointer, like the
cpufreq implementations you mentioned.
This is what I tried putting in the comments above the lookup code.

	/*
          * Lookup happens in 3 ways
          * 1. If a dev and dev->of_node exist, look for a
          * regulator mapping in dt node.
          * 2. Check if a match can be found in regulator_map_list
          * if regulator info is still passed in non-dt way
          * 3. if !dev, then just look for a matching regulator name.
          * Useful for dt builds using regulator_get() without specifying
          * a device.
          */

I know its quite complicated but thats because we need to support both
the legacy and the dt based lookups.

>
>> +	if (supply) {
>> +		struct regulator_dev *r;
>> +		struct device_node *node;
>> +
>> +		/* first do a dt based lookup */
>> +		if (dev) {
>> +			node = of_get_regulator(dev, supply);
>> +			if (node)
>> +				list_for_each_entry(r,&regulator_list, list)
>> +					if (node == r->dev.parent->of_node)
>> +						goto found;
>>   		}
>>
>> -		if (!found) {
>> -			dev_err(dev, "Failed to find supply %s\n",
>> -				init_data->supply_regulator);
>> -			ret = -ENODEV;
>> -			goto scrub;
>> -		}
>> +		/* next try doing it non-dt way */
>> +		list_for_each_entry(r,&regulator_list, list)
>> +			if (strcmp(rdev_get_name(r), supply) == 0)
>> +				goto found;
>>
>> +		dev_err(dev, "Failed to find supply %s\n", supply);
>> +		ret = -ENODEV;
>> +		goto scrub;
>> +
>> +found:
>
> This is all getting *really* complicated and illegible.  I'm not sure
> what the best way to structure is but erroring out early looks useful.
