From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Aug 2011 15:08:42 +0100
Subject: [PATCH 1/4] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <20110810132956.GG2680@pulham.picochip.com>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<20110810132956.GG2680@pulham.picochip.com>
Message-ID: <4E5505EA.6050207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

Thanks for reviewing this for me.

Most of your comments I've adhered to, but I do have a question inline.

>> +	return ret;
>> +}
>> +
>> +int __init soc_device_register(struct device *soc_parent,
>> +			struct soc_device *soc_dev)
>> +{
>> +	int ret;
>> +
>> +	spin_lock_irq(&register_lock);
>> +
>> +	if (!soc_count) {
>> +		/* Register top-level SoC device '/sys/devices/soc' */
>> +		ret = device_register(&soc_grandparent);
>> +		if (ret)
>> +		{
>> +			spin_unlock_irq(&register_lock);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	soc_count++;
>> +	soc_parent->parent = &soc_grandparent;
>> +	dev_set_name(soc_parent, "%i", soc_count);
>> +	soc_parent->platform_data = soc_dev;
> 
> I don't think platform_data is the right place for this.  

I agree with you, but I was unsure how else to get the data back.

> It's not clear
> what soc_parent and soc_dev do here as soc_dev never gets registered.
>
> Should this be:
> 
> 	soc_dev->parent = &soc_grandparent;
> 	dev_set_name(soc_dev, "%i", soc_count);
> 	device_register(soc_dev);

AFAIK soc_dev can't be registered. It's just a container which holds
each SoW's information to be exported in the way of const char *'s.

struct soc_device {
	struct device dev;
	const char *machine;
	const char *family;
	const char *soc_id;
	const char *revision;
};

I don't believe that the "struct device dev;" is required either, but
this is something I was advised to put in.

Can you think of a better way to store these values other than in
platform_data then?

> and drop soc_parent and add the files to soc_device?  In soc_info_get(), 
> you could then do:
> 
> 	struct soc_device *soc = container_of(dev, struct soc_device, dev);
> 
>> +	spin_unlock_irq(&register_lock);
>> +
>> +	ret = device_register(soc_parent);
>> +	if (ret)
>> +		return ret;
>> +
>> +	soc_device_create_files(soc_parent);
>> +
>> +	return ret;
>> +}

Kind regards,
Lee
